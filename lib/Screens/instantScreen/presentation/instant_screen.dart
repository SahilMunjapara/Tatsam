import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:tatsam/Screens/instantScreen/bloc/bloc.dart';
import 'package:tatsam/Utils/constants/colors.dart';
import 'package:tatsam/Utils/constants/image.dart';
import 'package:tatsam/Utils/constants/strings.dart';
import 'package:tatsam/Utils/constants/textStyle.dart';
import 'package:tatsam/Utils/size_utils/size_utils.dart';
import 'package:tatsam/commonWidget/custom_appbar.dart';
import 'package:tatsam/commonWidget/drawer_screen.dart';
import 'package:tatsam/commonWidget/search_box_widget.dart';
import 'package:tatsam/commonWidget/select_search_box_widget.dart';

class InstantScreen extends StatefulWidget {
  const InstantScreen({Key? key}) : super(key: key);

  @override
  State<InstantScreen> createState() => _InstantScreenState();
}

class _InstantScreenState extends State<InstantScreen> {
  InstantBloc instantBloc = InstantBloc();
  late GlobalKey<ScaffoldState> scaffoldState;
  late TextEditingController searchController;
  bool isSearching = false;
  bool isSelectSearching = false;

  @override
  void initState() {
    super.initState();
    searchController = TextEditingController();
    scaffoldState = GlobalKey<ScaffoldState>();
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
            if (state is InstantSearchState) {
              isSearching = state.isSearching;
            }
            if (state is InstantSelectSearchState) {
              isSelectSearching = state.isSelectSearching;
            }
          },
          builder: (context, state) {
            return Padding(
              padding: EdgeInsets.symmetric(horizontal: SizeUtils().wp(6)),
              child: ListView(
                children: [
                  SizedBox(height: SizeUtils().hp(2)),
                  CustomAppBar(
                    title: Strings.instantScreenHeader,
                    isSearch: isSearching,
                    onMenuTap: () => scaffoldState.currentState!.openDrawer(),
                    onSearchTap: () => instantBloc
                        .add(InstantSearchEvent(isSearching: !isSearching)),
                  ),
                  Visibility(
                    visible: isSearching,
                    child: SearchBoxWidget(
                      controller: searchController,
                      onSubmitted: (char) {
                        instantBloc
                            .add(InstantSearchEvent(isSearching: !isSearching));
                      },
                    ),
                  ),
                  SizedBox(height: SizeUtils().hp(4)),
                  _headerTwoOptionWidget(),
                  Visibility(
                    visible: isSelectSearching,
                    child: const SelectSearchBoxWidget(),
                  ),
                  SizedBox(height: SizeUtils().hp(2)),
                  SizedBox(
                    width: SizeUtils().screenWidth,
                    height: SizeUtils().hp(55),
                    child:
                        NotificationListener<OverscrollIndicatorNotification>(
                      onNotification: (overScroll) {
                        overScroll.disallowIndicator();
                        return false;
                      },
                      child: GridView.builder(
                        gridDelegate:
                            const SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2,
                          childAspectRatio: 1.8,
                        ),
                        itemCount: 5,
                        itemBuilder: (context, index) {
                          return _contactDetailsWidget();
                        },
                      ),
                    ),
                  ),
                  SizedBox(height: SizeUtils().hp(2)),
                  _sendButton()
                ],
              ),
            );
          },
        ),
      ),
    );
  }

  Widget _contactDetailsWidget() {
    return Padding(
      padding: EdgeInsets.only(
        top: SizeUtils().hp(2),
        bottom: SizeUtils().hp(2),
        right: SizeUtils().wp(2),
      ),
      child: Slidable(
        key: const ValueKey(0),
        endActionPane: ActionPane(
          motion: const ScrollMotion(),
          extentRatio: 0.3,
          children: [
            Container(
              height: SizeUtils().hp(9.5),
              width: SizeUtils().wp(12),
              decoration: BoxDecoration(
                color: otpBoxColor.withOpacity(0.3),
                borderRadius: const BorderRadius.only(
                  topRight: Radius.circular(10),
                  bottomRight: Radius.circular(10),
                ),
              ),
              child: Center(
                child: SvgPicture.asset(ImageString.deleteSvg),
              ),
            ),
          ],
        ),
        child: Container(
          decoration: BoxDecoration(
            gradient: const LinearGradient(
              colors: [boxGradient1, boxGradient2],
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
            ),
            borderRadius: BorderRadius.circular(10),
            border: Border.all(color: whiteColor),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Container(
                height: SizeUtils().hp(8),
                width: SizeUtils().wp(15),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(5),
                  image: const DecorationImage(
                    image: AssetImage(ImageString.person),
                    fit: BoxFit.fill,
                  ),
                ),
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Nirav Patel',
                    style: size14Regular(),
                  ),
                  SizedBox(height: SizeUtils().hp(1.5)),
                  Text(
                    '9988665544',
                    style: size12Regular(),
                  )
                ],
              ),
            ],
          ),
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
