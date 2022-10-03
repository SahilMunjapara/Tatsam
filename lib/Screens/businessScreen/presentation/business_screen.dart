import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tatsam/Screens/businessScreen/bloc/bloc.dart';
import 'package:tatsam/Utils/constants/colors.dart';
import 'package:tatsam/Utils/constants/image.dart';
import 'package:tatsam/Utils/constants/strings.dart';
import 'package:tatsam/Utils/constants/textStyle.dart';
import 'package:tatsam/Utils/size_utils/size_utils.dart';
import 'package:tatsam/commonWidget/custom_appbar.dart';
import 'package:tatsam/commonWidget/drawer_screen.dart';
import 'package:tatsam/commonWidget/gradient_border.dart';
import 'package:tatsam/commonWidget/gradient_text.dart';
import 'package:tatsam/commonWidget/search_box_widget.dart';

class BusinessScreen extends StatefulWidget {
  const BusinessScreen({Key? key}) : super(key: key);

  @override
  State<BusinessScreen> createState() => _BusinessScreenState();
}

class _BusinessScreenState extends State<BusinessScreen> {
  BusinessBloc businessBloc = BusinessBloc();
  late GlobalKey<ScaffoldState> scaffoldState;
  late TextEditingController searchController;
  bool isSearching = false;

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
          bloc: businessBloc,
          listener: (context, state) {
            if (state is BusinessSearchState) {
              isSearching = !isSearching;
            }
          },
          builder: (context, state) {
            return Padding(
              padding: EdgeInsets.symmetric(horizontal: SizeUtils().wp(6)),
              child: Column(
                children: [
                  SizedBox(height: SizeUtils().hp(2)),
                  CustomAppBar(
                    title: Strings.businessScreenHeader,
                    isSearch: isSearching,
                    onMenuTap: () => scaffoldState.currentState!.openDrawer(),
                    onSearchTap: () => businessBloc.add(BusinessSearchEvent()),
                  ),
                  Visibility(
                    visible: isSearching,
                    child: SearchBoxWidget(
                      controller: searchController,
                      onSubmitted: (char) {
                        businessBloc.add(BusinessSearchEvent());
                      },
                    ),
                  ),
                  SizedBox(height: SizeUtils().hp(4)),
                  Expanded(
                    child:
                        NotificationListener<OverscrollIndicatorNotification>(
                      onNotification: (overScroll) {
                        overScroll.disallowIndicator();
                        return false;
                      },
                      child: Padding(
                        padding: EdgeInsets.only(bottom: SizeUtils().hp(5)),
                        child: ListView.builder(
                          itemCount: 12,
                          itemBuilder: (context, index) {
                            return _businessProfileWidget(
                              businessImage: 'BImage',
                              userName: 'Twinkle N Patel',
                              businessName: 'Ui designer',
                              userPhoneNumber: '9988776655',
                              userImage: 'UImage',
                            );
                          },
                        ),
                      ),
                    ),
                  ),
                ],
              ),
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
      child: Padding(
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
              Text(businessImage!),
              Padding(
                padding: EdgeInsets.symmetric(vertical: SizeUtils().hp(2)),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
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
                      style: size18Regular(),
                    ),
                    SizedBox(height: SizeUtils().hp(0.5)),
                    Text(
                      userPhoneNumber!,
                      style: size18Regular(),
                    ),
                  ],
                ),
              ),
              Container(
                height: SizeUtils().hp(8),
                width: SizeUtils().wp(14),
                decoration: const BoxDecoration(
                  shape: BoxShape.circle,
                  image: DecorationImage(
                    image: AssetImage(ImageString.person),
                    fit: BoxFit.fill,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
