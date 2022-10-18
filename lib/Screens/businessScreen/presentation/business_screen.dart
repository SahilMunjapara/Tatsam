import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tatsam/Screens/businessScreen/bloc/bloc.dart';
import 'package:tatsam/Screens/businessScreen/data/model/business_response_model.dart';
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
import 'package:tatsam/commonWidget/gradient_border.dart';
import 'package:tatsam/commonWidget/gradient_text.dart';
import 'package:tatsam/commonWidget/progress_bar_round.dart';
import 'package:tatsam/commonWidget/search_box_widget.dart';
import 'package:tatsam/commonWidget/snackbar_widget.dart';
import 'package:tatsam/service/exception/exception.dart';

class BusinessScreen extends StatefulWidget {
  const BusinessScreen({Key? key}) : super(key: key);

  @override
  State<BusinessScreen> createState() => _BusinessScreenState();
}

class _BusinessScreenState extends State<BusinessScreen> {
  BusinessBloc businessBloc = BusinessBloc();
  late GlobalKey<ScaffoldState> scaffoldState;
  late TextEditingController searchController;
  late List<BusinessData> businessList;
  late List<BusinessData> searchBusinessList;
  bool isSearching = false;
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    businessList = searchBusinessList = [];
    businessBloc.add(
      GetBusinessEvent(
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
          bloc: businessBloc,
          listener: (context, state) {
            if (state is BusinessLoadingStartState) {
              isLoading = true;
            }
            if (state is BusinessLoadingEndState) {
              isLoading = false;
            }
            if (state is BusinessSearchState) {
              isSearching = !isSearching;
            }
            if (state is GetBusinessState) {
              businessList = state.responseModel.businessData!;
            }
            if (state is BusinessSearchCharState) {
              searchBusinessList.clear();
              searchBusinessList = businessList
                  .where((business) =>
                      business.businessName!
                          .toUpperCase()
                          .contains(state.searchChar.toUpperCase()) ||
                      business.user!.name!
                          .toUpperCase()
                          .contains(state.searchChar.toUpperCase()) ||
                      business.user!.phoneNo!.contains(state.searchChar))
                  .toList();
            }
            if (state is BusinessErrorState) {
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
                  padding: EdgeInsets.symmetric(horizontal: SizeUtils().wp(6)),
                  child: Column(
                    children: [
                      SizedBox(height: SizeUtils().hp(2)),
                      CustomAppBar(
                        title: Strings.businessScreenHeader,
                        isSearch: isSearching,
                        onMenuTap: () =>
                            scaffoldState.currentState!.openDrawer(),
                        onSearchTap: () =>
                            businessBloc.add(BusinessSearchEvent()),
                      ),
                      Visibility(
                        visible: isSearching,
                        child: SearchBoxWidget(
                          controller: searchController,
                          onChanged: (char) => businessBloc
                              .add(BusinessSearchCharEvent(searchChar: char)),
                          onSubmitted: (char) =>
                              businessBloc.add(BusinessSearchEvent()),
                          onSearchDoneTap: () =>
                              businessBloc.add(BusinessSearchEvent()),
                        ),
                      ),
                      SizedBox(height: SizeUtils().hp(4)),
                      businessList.isEmpty
                          ? const SizedBox()
                          : Expanded(
                              child: NotificationListener<
                                  OverscrollIndicatorNotification>(
                                onNotification: (overScroll) {
                                  overScroll.disallowIndicator();
                                  return false;
                                },
                                child: Padding(
                                  padding: EdgeInsets.only(
                                      bottom: SizeUtils().hp(5)),
                                  child: searchBusinessList.isEmpty
                                      ? ListView.builder(
                                          itemCount: businessList.length,
                                          itemBuilder: (context, index) {
                                            return _businessProfileWidget(
                                              businessImage: businessList[index]
                                                  .businessType!
                                                  .imagePath,
                                              userName: businessList[index]
                                                  .user!
                                                  .name,
                                              businessName: businessList[index]
                                                  .businessName,
                                              userPhoneNumber:
                                                  businessList[index]
                                                      .user!
                                                      .phoneNo,
                                              userImage: businessList[index]
                                                  .businessImagePath!,
                                            );
                                          },
                                        )
                                      : ListView.builder(
                                          itemCount: searchBusinessList.length,
                                          itemBuilder: (context, index) {
                                            return _businessProfileWidget(
                                              businessImage:
                                                  searchBusinessList[index]
                                                      .businessType!
                                                      .imagePath,
                                              userName:
                                                  searchBusinessList[index]
                                                      .user!
                                                      .name,
                                              businessName:
                                                  searchBusinessList[index]
                                                      .businessName,
                                              userPhoneNumber:
                                                  businessList[index]
                                                      .user!
                                                      .phoneNo,
                                              userImage:
                                                  searchBusinessList[index]
                                                      .businessImagePath!,
                                            );
                                          },
                                        ),
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

  Widget _businessProfileWidget({
    String? businessImage,
    String? userName,
    String? userPhoneNumber,
    String? businessName,
    String? userImage,
  }) {
    return Padding(
      padding: EdgeInsets.symmetric(
        vertical: SizeUtils().hp(1),
      ),
      child: Stack(
        children: [
          Padding(
            padding: const EdgeInsets.all(2.0),
            child: Container(
              decoration: BoxDecoration(
                border: const GradientBoxBorder(
                  gradient: LinearGradient(
                    colors: [
                      shadow2Color,
                      shadow3Color,
                      shadow4Color,
                      shadow1Color
                    ],
                  ),
                  width: 2,
                ),
                color: whiteColor.withOpacity(0.15),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  SizedBox(width: SizeUtils().wp(12)),
                  SizedBox(
                    width: SizeUtils().wp(42),
                    child: Padding(
                      padding:
                          EdgeInsets.symmetric(vertical: SizeUtils().hp(2)),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          GradientText(
                            userName!,
                            style: size21Regular().copyWith(shadows: [
                              Shadow(
                                offset: const Offset(2, 4),
                                blurRadius: 4,
                                color: blackColor.withOpacity(0.4),
                              ),
                            ]),
                            gradient: const LinearGradient(
                              colors: [textGradient1Color, whiteColor],
                            ),
                          ),
                          SizedBox(height: SizeUtils().hp(2)),
                          Text(
                            businessName!,
                            maxLines: 1,
                            style: size18Regular(),
                          ),
                          SizedBox(height: SizeUtils().hp(0.5)),
                          Text(
                            userPhoneNumber!,
                            maxLines: 1,
                            style: size18Regular(),
                          ),
                        ],
                      ),
                    ),
                  ),
                  Container(
                    height: SizeUtils().hp(8),
                    width: SizeUtils().wp(14),
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      image: userImage!.isNotEmpty
                          ? DecorationImage(
                              image: NetworkImage(userImage),
                              fit: BoxFit.fill,
                            )
                          : const DecorationImage(
                              image: AssetImage(ImageString.person),
                              fit: BoxFit.fill,
                            ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          Positioned(
            bottom: SizeUtils().hp(0.5),
            left: SizeUtils().wp(1),
            child: SizedBox(
              height: SizeUtils().hp(10),
              width: SizeUtils().wp(16),
              child: Image.network(businessImage!, fit: BoxFit.fill),
            ),
          ),
        ],
      ),
    );
  }
}
