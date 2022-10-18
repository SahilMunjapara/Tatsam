import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tatsam/Screens/contactScreen/bloc/bloc.dart';
import 'package:tatsam/Screens/contactScreen/data/model/user_response_model.dart';
import 'package:tatsam/Screens/contactScreen/presentation/widget/alphabet_scroll_widget.dart';
import 'package:tatsam/Utils/constants/colors.dart';
import 'package:tatsam/Utils/constants/strings.dart';
import 'package:tatsam/Utils/size_utils/size_utils.dart';
import 'package:tatsam/commonWidget/custom_appbar.dart';
import 'package:tatsam/commonWidget/custom_dialog_box_widget.dart';
import 'package:tatsam/commonWidget/drawer_screen.dart';
import 'package:tatsam/commonWidget/progress_bar_round.dart';
import 'package:tatsam/commonWidget/search_box_widget.dart';
import 'package:tatsam/commonWidget/snackbar_widget.dart';
import 'package:tatsam/service/exception/exception.dart';

class ContactScreen extends StatefulWidget {
  const ContactScreen({Key? key}) : super(key: key);

  @override
  State<ContactScreen> createState() => _ContactScreenState();
}

class _ContactScreenState extends State<ContactScreen> {
  ContactBloc contactBloc = ContactBloc();
  late GlobalKey<ScaffoldState> scaffoldState;
  late TextEditingController searchController;
  late List<UserResponseModel> userList, searchUserList;
  bool isSearching = false;
  bool isLoading = false;

  @override
  void initState() {
    super.initState();
    userList = searchUserList = [];
    contactBloc.add(ContactListEvent());
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
        resizeToAvoidBottomInset: false,
        key: scaffoldState,
        backgroundColor: transparentColor,
        drawer: const DrawerScreen(),
        body: BlocConsumer(
          bloc: contactBloc,
          listener: (context, state) {
            if (state is ContactSearchState) {
              isSearching = !isSearching;
            }
            if (state is ContactLoadingStartState) {
              isLoading = true;
            }
            if (state is ContactLoadingEndState) {
              isLoading = false;
            }
            if (state is ContactListState) {
              userList = state.responsemodel;
            }
            if (state is ContactWithCharSearchState) {
              searchUserList.clear();
              searchUserList = userList
                  .where((user) =>
                      user.name!
                          .toUpperCase()
                          .contains(state.searchChar.toUpperCase()) ||
                      user.phoneNo!.contains(state.searchChar))
                  .toList();
              log(searchUserList.toString());
            }
            if (state is ContactErrorState) {
              AppException exception = state.exception;
              if (ResponseString.unauthorized == exception.message) {
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
                  padding: EdgeInsets.only(
                    bottom: SizeUtils().hp(6),
                  ),
                  child: Column(
                    children: [
                      SizedBox(height: SizeUtils().hp(2)),
                      CustomAppBar(
                        title: Strings.contactsScreenHeader,
                        padding: 6.0,
                        isSearch: isSearching,
                        onMenuTap: () =>
                            scaffoldState.currentState!.openDrawer(),
                        onSearchTap: () =>
                            contactBloc.add(ContactSearchEvent()),
                      ),
                      Visibility(
                        visible: isSearching,
                        child: SearchBoxWidget(
                          controller: searchController,
                          rightPadding: 6.0,
                          leftPadding: 18.0,
                          onChanged: (char) {
                            contactBloc.add(
                              ContactWithCharSearchEvent(searchChar: char),
                            );
                          },
                          onSubmitted: (char) {
                            contactBloc.add(ContactSearchEvent());
                          },
                          onSearchDoneTap: () =>
                              contactBloc.add(ContactSearchEvent()),
                        ),
                      ),
                      SizedBox(height: SizeUtils().hp(4)),
                      Expanded(
                        child: Container(
                          decoration: BoxDecoration(
                            color: otpBoxColor.withOpacity(0.15),
                            borderRadius: BorderRadius.circular(30),
                          ),
                          child: NotificationListener<
                              OverscrollIndicatorNotification>(
                            onNotification: (overScroll) {
                              overScroll.disallowIndicator();
                              return false;
                            },
                            child: isLoading
                                ? const SizedBox()
                                : searchUserList.isEmpty
                                    ? AlphabetScrollWidget(items: userList)
                                    : AlphabetScrollWidget(
                                        items: searchUserList),
                          ),
                        ),
                      ),
                    ],
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
}
