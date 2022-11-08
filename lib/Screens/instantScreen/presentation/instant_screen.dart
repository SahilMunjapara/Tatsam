import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:tatsam/Screens/contactScreen/data/model/user_response_model.dart';
import 'package:tatsam/Screens/instantScreen/bloc/bloc.dart';
import 'package:tatsam/Screens/instantScreen/data/model/instant_response_model.dart';
import 'package:tatsam/Screens/instantScreen/presentation/widgets/instant_card_widget.dart';
import 'package:tatsam/Utils/app_preferences/app_preferences.dart';
import 'package:tatsam/Utils/app_preferences/prefrences_key.dart';
import 'package:tatsam/Utils/constants/colors.dart';
import 'package:tatsam/Utils/constants/strings.dart';
import 'package:tatsam/Utils/constants/textStyle.dart';
import 'package:tatsam/Utils/size_utils/size_utils.dart';
import 'package:tatsam/commonWidget/custom_appbar.dart';
import 'package:tatsam/commonWidget/custom_dialog_box_widget.dart';
import 'package:tatsam/commonWidget/drawer_screen.dart';
import 'package:tatsam/commonWidget/progress_bar_round.dart';
import 'package:tatsam/commonWidget/search_box_widget.dart';
import 'package:tatsam/commonWidget/select_search_box_widget.dart';
import 'package:tatsam/commonWidget/snackbar_widget.dart';
import 'package:tatsam/service/exception/exception.dart';
import 'package:flutter_sms/flutter_sms.dart';

class InstantScreen extends StatefulWidget {
  const InstantScreen({Key? key}) : super(key: key);

  @override
  State<InstantScreen> createState() => _InstantScreenState();
}

class _InstantScreenState extends State<InstantScreen> {
  InstantBloc instantBloc = InstantBloc();
  late GlobalKey<ScaffoldState> scaffoldState;
  late TextEditingController searchController;
  late List<InstantData> instantUsers, searchInstantUsers;
  late List<UserResponseModel> allUserList, selectedUserList;
  bool isSearching = false;
  bool isSelectSearching = false;
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    instantUsers = searchInstantUsers = [];
    allUserList = selectedUserList = [];
    instantBloc.add(GetAllContactEvent());
    instantBloc.add(GetInstantEvent(
      userId: AppPreference().getStringData(PreferencesKey.userId),
    ));
    searchController = TextEditingController();
    scaffoldState = GlobalKey<ScaffoldState>();
  }

  @override
  void dispose() {
    searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    SizeUtils().init(context);
    return SafeArea(
      child: Scaffold(
        key: scaffoldState,
        resizeToAvoidBottomInset: false,
        backgroundColor: transparentColor,
        drawer: const DrawerScreen(),
        body: BlocConsumer(
          bloc: instantBloc,
          listener: (context, state) {
            if (state is InstantLoadingStartState) {
              isLoading = true;
            }
            if (state is InstantLoadingEndState) {
              isLoading = false;
            }
            if (state is InstantSearchState) {
              isSearching = state.isSearching;
            }
            if (state is InstantSelectSearchState) {
              isSelectSearching = state.isSelectSearching;
            }
            if (state is GetAllContactState) {
              allUserList = state.responseModel;
              allUserList.removeWhere(
                (user) =>
                    user.id ==
                    AppPreference().getStringData(PreferencesKey.userId),
              );
            }
            if (state is GetInstantState) {
              instantUsers.clear();
              instantUsers = state.responseModel.instantData!;
            }
            if (state is InstantAddState) {
              instantBloc.add(GetInstantEvent(
                userId: AppPreference().getStringData(PreferencesKey.userId),
              ));
            }
            if (state is InstantSearchCharState) {
              searchInstantUsers.clear();
              searchInstantUsers = instantUsers
                  .where((instant) =>
                      instant.name!
                          .toUpperCase()
                          .contains(state.searchChar.toUpperCase()) ||
                      instant.phoneNo!.contains(state.searchChar))
                  .toList();
            }
            if (state is SelectedInstantUserState) {
              bool isAlreadyAdded = false;
              for (var item in instantUsers) {
                item.id == state.responseModel.id
                    ? isAlreadyAdded = true
                    : isAlreadyAdded = false;
              }
              isAlreadyAdded
                  ? SnackbarWidget.showBottomToast(
                      message: Strings.alreadySelected,
                    )
                  : selectedUserList.add(state.responseModel);
            }
            if (state is SelectedInstantRemoveState) {
              selectedUserList
                  .removeWhere((user) => user.id == state.responseModel.id);
            }
            if (state is InstantDeleteState) {
              searchInstantUsers.removeWhere((instant) =>
                  instant.instantId!.id == int.parse(state.response.userId!));
              instantUsers.removeWhere((instant) =>
                  instant.instantId!.id == int.parse(state.response.userId!));
              SnackbarWidget.showBottomToast(message: Strings.instantDeleteMsg);
            }
            if (state is InstantErrorState) {
              AppException exception = state.exception;
              if (exception.message == ResponseString.unauthorized) {
                CustomDialog.showSessionExpiredDialog(context);
              } else {
                SnackbarWidget.showBottomToast(message: exception.message);
              }
            }
          },
          builder: (context, state) {
            return Stack(
              children: [
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: SizeUtils().wp(6)),
                  child: NotificationListener<OverscrollIndicatorNotification>(
                    onNotification: (overScroll) {
                      overScroll.disallowIndicator();
                      return false;
                    },
                    child: ListView(
                      children: [
                        SizedBox(height: SizeUtils().hp(2)),
                        CustomAppBar(
                          title: Strings.instantScreenHeader,
                          isSearch: isSearching,
                          onMenuTap: () =>
                              scaffoldState.currentState!.openDrawer(),
                          onSearchTap: () => instantBloc.add(
                              InstantSearchEvent(isSearching: !isSearching)),
                        ),
                        Visibility(
                          visible: isSearching,
                          child: SearchBoxWidget(
                            controller: searchController,
                            onChanged: (char) => instantBloc
                                .add(InstantSearchCharEvent(searchChar: char)),
                            onSubmitted: (char) => instantBloc.add(
                                InstantSearchEvent(isSearching: !isSearching)),
                            onSearchDoneTap: () => instantBloc.add(
                                InstantSearchEvent(isSearching: !isSearching)),
                          ),
                        ),
                        SizedBox(height: SizeUtils().hp(4)),
                        _headerTwoOptionWidget(),
                        Visibility(
                          visible: isSelectSearching,
                          child: SelectSearchBoxWidget(
                            userList: allUserList,
                            selectedUserList: selectedUserList,
                            onAddTap: () {
                              instantBloc.add(
                                InstantSelectSearchEvent(
                                    isSelectSearching: false),
                              );
                              if (selectedUserList.isNotEmpty) {
                                List<String> newUserList = [];
                                selectedUserList
                                    .map(
                                        (e) => newUserList.add(e.id.toString()))
                                    .toList();
                                instantBloc.add(
                                    InstantAddEvent(instantIds: newUserList));
                              }
                            },
                            onDeleteTap: (user) {
                              instantBloc.add(
                                SelectedInstantRemoveEvent(
                                    userResponseModel: user),
                              );
                            },
                            onUserTap: (user) {
                              if (selectedUserList.length +
                                      instantUsers.length >=
                                  5) {
                                SnackbarWidget.showBottomToast(
                                  message: Strings.only5InstnatAllow,
                                );
                              } else {
                                if (selectedUserList.contains(user)) {
                                  SnackbarWidget.showBottomToast(
                                    message: Strings.alreadySelected,
                                  );
                                } else {
                                  instantBloc.add(
                                    SelectedInstantUserEvent(
                                        userResponseModel: user),
                                  );
                                }
                              }
                            },
                          ),
                        ),
                        SizedBox(height: SizeUtils().hp(2)),
                        _instantGridView(),
                        SizedBox(height: SizeUtils().hp(2)),
                        Visibility(
                          visible: !isLoading && instantUsers.isNotEmpty,
                          child: GestureDetector(
                            onTap: _sendSmsToInstant,
                            child: _sendButton(),
                          ),
                        )
                      ],
                    ),
                  ),
                ),
                ProgressBarRound(isLoading: isLoading),
              ],
            );
          },
        ),
      ),
    );
  }

  void _sendSmsToInstant() async {
    PermissionStatus status = await Permission.sms.request();
    if (status == PermissionStatus.granted) {
      List<String> recipients = List<String>.from(
          instantUsers.map((e) => Strings.phoneCode.trim() + e.phoneNo!));
      await sendSMS(
        message: Strings.instantMSG,
        recipients: recipients,
        sendDirect: true,
      ).onError((error, stackTrace) {
        SnackbarWidget.showBottomToast(message: Strings.instantErrorSms);
        throw UnimplementedError();
      }).then((value) {
        SnackbarWidget.showBottomToast(message: Strings.instantSuccessMSGSend);
      });
    } else {
      SnackbarWidget.showBottomToast(
          message: ValidatorString.smsPermissionRequired);
    }
  }

  Widget _instantGridView() {
    return instantUsers.isEmpty
        ? const SizedBox()
        : SizedBox(
            width: SizeUtils().screenWidth,
            height: SizeUtils().hp(55),
            child: NotificationListener<OverscrollIndicatorNotification>(
              onNotification: (overScroll) {
                overScroll.disallowIndicator();
                return false;
              },
              child: searchInstantUsers.isEmpty
                  ? GridView.builder(
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        childAspectRatio: 1.8,
                      ),
                      itemCount: instantUsers.length,
                      itemBuilder: (context, index) {
                        return InstantCard(
                            instantData: instantUsers[index],
                            onDeleteTap: () {
                              instantBloc.add(InstantDeleteEvent(
                                instantId: instantUsers[index]
                                    .instantId!
                                    .id
                                    .toString(),
                              ));
                            });
                      },
                    )
                  : GridView.builder(
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        childAspectRatio: 1.8,
                      ),
                      itemCount: searchInstantUsers.length,
                      itemBuilder: (context, index) {
                        return InstantCard(
                          instantData: searchInstantUsers[index],
                          onDeleteTap: () {
                            instantBloc.add(
                              InstantDeleteEvent(
                                instantId: searchInstantUsers[index]
                                    .instantId!
                                    .id
                                    .toString(),
                              ),
                            );
                          },
                        );
                      },
                    ),
            ),
          );
  }

  Widget _headerTwoOptionWidget() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          Strings.urgentHelp,
          style: size20Regular(),
        ),
        GestureDetector(
          onTap: () {
            instantBloc.add(
              InstantSelectSearchEvent(isSelectSearching: !isSelectSearching),
            );
          },
          child: isSelectSearching
              ? Container(
                  color: otpBoxColor.withOpacity(0.49),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 8.0, vertical: 2.0),
                    child: Text(
                      Strings.selectPlus,
                      style: size20Regular(),
                    ),
                  ),
                )
              : Text(
                  Strings.selectPlus,
                  style: size20Regular(),
                ),
        ),
      ],
    );
  }

  Widget _sendButton() {
    return Align(
      alignment: Alignment.bottomRight,
      child: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [
              shadow1Color.withOpacity(0.35),
              shadow1Color,
              shadow1Color,
              shadow1Color,
            ],
          ),
          borderRadius: BorderRadius.circular(30),
          border: Border.all(color: shadow1Color, width: 2),
        ),
        child: Padding(
          padding: EdgeInsets.symmetric(
            vertical: SizeUtils().hp(1),
            horizontal: SizeUtils().wp(4),
          ),
          child: Text(
            Strings.send,
            style: size16Regular(textColor: blackColor)
                .copyWith(fontFamily: Strings.secondFontFamily),
          ),
        ),
      ),
    );
  }
}
