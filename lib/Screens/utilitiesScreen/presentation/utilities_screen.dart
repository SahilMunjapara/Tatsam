import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:tatsam/Screens/utilitiesScreen/bloc/bloc.dart';
import 'package:tatsam/Screens/utilitiesScreen/data/model/utilities_response_model.dart';
import 'package:tatsam/Utils/app_preferences/app_preferences.dart';
import 'package:tatsam/Utils/app_preferences/prefrences_key.dart';
import 'package:tatsam/Utils/constants/colors.dart';
import 'package:tatsam/Utils/constants/image.dart';
import 'package:tatsam/Utils/constants/strings.dart';
import 'package:tatsam/Utils/constants/textStyle.dart';
import 'package:tatsam/Utils/size_utils/size_utils.dart';
import 'package:tatsam/commonWidget/custom_appbar.dart';
import 'package:tatsam/commonWidget/custom_dialog_box_widget.dart';
import 'package:tatsam/commonWidget/drawer_screen.dart';
import 'package:tatsam/commonWidget/progress_bar_round.dart';
import 'package:tatsam/commonWidget/search_box_widget.dart';
import 'package:tatsam/commonWidget/snackbar_widget.dart';
import 'package:tatsam/service/exception/exception.dart';
import 'package:url_launcher/url_launcher.dart';

class UtilitiesScreen extends StatefulWidget {
  const UtilitiesScreen({Key? key}) : super(key: key);

  @override
  State<UtilitiesScreen> createState() => _UtilitiesScreenState();
}

class _UtilitiesScreenState extends State<UtilitiesScreen> {
  final UtilitiesBloc utilitiesBloc = UtilitiesBloc();
  late GlobalKey<ScaffoldState> scaffoldState;
  late TextEditingController searchController;
  late UtilitiesResponseModel utilitiesList, searchUtilitiesList;
  bool isSearching = false;
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    utilitiesList =
        searchUtilitiesList = UtilitiesResponseModel(utilitiesData: []);
    utilitiesBloc.add(
      UtilitiesListEvent(
        groupId: AppPreference().getStringData(PreferencesKey.groupId),
      ),
    );
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
          bloc: utilitiesBloc,
          listener: (context, state) {
            if (state is UtilitiesSearchState) {
              isSearching = !isSearching;
            }
            if (state is UtilitiesListState) {
              utilitiesList = state.responseModel;
            }
            if (state is UtilitiesLoadingStartState) {
              isLoading = true;
            }
            if (state is UtilitiesLoadingEndState) {
              isLoading = false;
            }
            if (state is UtilitiesSearchCharState) {
              searchUtilitiesList.utilitiesData!.clear();
              searchUtilitiesList.utilitiesData = utilitiesList.utilitiesData!
                  .where((utility) =>
                      utility.name!
                          .toUpperCase()
                          .contains(state.searchChar.toUpperCase()) ||
                      utility.phoneNo!.contains(state.searchChar))
                  .toList();
            }
            if (state is UtilitiesErrorState) {
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
                  child: Column(
                    children: [
                      SizedBox(height: SizeUtils().hp(2)),
                      CustomAppBar(
                        title: Strings.utilitiesScreenHeader,
                        isSearch: isSearching,
                        onMenuTap: () =>
                            scaffoldState.currentState!.openDrawer(),
                        onSearchTap: () =>
                            utilitiesBloc.add(UtilitiesSearchEvent()),
                      ),
                      Visibility(
                        visible: isSearching,
                        child: SearchBoxWidget(
                          controller: searchController,
                          onChanged: (char) => utilitiesBloc
                              .add(UtilitiesSearchCharEvent(searchChar: char)),
                          onSubmitted: (char) =>
                              utilitiesBloc.add(UtilitiesSearchEvent()),
                          onSearchDoneTap: () =>
                              utilitiesBloc.add(UtilitiesSearchEvent()),
                        ),
                      ),
                      SizedBox(height: SizeUtils().hp(4)),
                      Expanded(
                        child: NotificationListener<
                            OverscrollIndicatorNotification>(
                          onNotification: (overScroll) {
                            overScroll.disallowIndicator();
                            return false;
                          },
                          child: Padding(
                            padding: EdgeInsets.only(bottom: SizeUtils().hp(5)),
                            child: searchUtilitiesList.utilitiesData!.isEmpty
                                ? ListView.builder(
                                    itemCount:
                                        utilitiesList.utilitiesData!.length,
                                    itemBuilder: (context, index) {
                                      return _utilitiesCardWidget(
                                        utilitiesList.utilitiesData![index],
                                      );
                                    },
                                  )
                                : ListView.builder(
                                    itemCount: searchUtilitiesList
                                        .utilitiesData!.length,
                                    itemBuilder: (context, index) {
                                      return _utilitiesCardWidget(
                                        searchUtilitiesList
                                            .utilitiesData![index],
                                      );
                                    },
                                  ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                ProgressBarRound(isLoading: isLoading)
              ],
            );
          },
        ),
      ),
    );
  }

  Widget _utilitiesCardWidget(UtilitiesData utilitiesData) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: SizeUtils().hp(1)),
      child: GestureDetector(
        onTap: () => launchUrl(Uri.parse('tel:${utilitiesData.phoneNo}')),
        child: Container(
          decoration: BoxDecoration(
            gradient: const LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [boxGradient1, boxGradient2],
            ),
            borderRadius: BorderRadius.circular(10),
            border: Border.all(color: whiteColor, width: 0.8),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                children: [
                  Row(
                    children: [
                      Padding(
                        padding: EdgeInsets.all(SizeUtils().wp(2.5)),
                        child: SizedBox(
                          height: SizeUtils().hp(8),
                          width: SizeUtils().wp(15),
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(5),
                            child: Image.asset(
                              ImageString.person,
                              fit: BoxFit.fill,
                            ),
                          ),
                        ),
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            utilitiesData.name!,
                            style: size12Regular().copyWith(
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          SizedBox(height: SizeUtils().hp(3)),
                          Text(utilitiesData.phoneNo!, style: size12Regular()),
                        ],
                      ),
                    ],
                  ),
                ],
              ),
              Column(),
            ],
          ),
        ),
      ),
    );
  }
}
