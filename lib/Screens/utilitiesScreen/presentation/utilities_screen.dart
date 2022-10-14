import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tatsam/Screens/utilitiesScreen/bloc/bloc.dart';
import 'package:tatsam/Utils/constants/colors.dart';
import 'package:tatsam/Utils/constants/image.dart';
import 'package:tatsam/Utils/constants/strings.dart';
import 'package:tatsam/Utils/constants/textStyle.dart';
import 'package:tatsam/Utils/size_utils/size_utils.dart';
import 'package:tatsam/commonWidget/custom_appbar.dart';
import 'package:tatsam/commonWidget/drawer_screen.dart';
import 'package:tatsam/commonWidget/search_box_widget.dart';

class UtilitiesScreen extends StatefulWidget {
  const UtilitiesScreen({Key? key}) : super(key: key);

  @override
  State<UtilitiesScreen> createState() => _UtilitiesScreenState();
}

class _UtilitiesScreenState extends State<UtilitiesScreen> {
  final UtilitiesBloc utilitiesBloc = UtilitiesBloc();
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
          bloc: utilitiesBloc,
          listener: (context, state) {
            if (state is UtilitiesSearchState) {
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
                    title: Strings.utilitiesScreenHeader,
                    isSearch: isSearching,
                    onMenuTap: () => scaffoldState.currentState!.openDrawer(),
                    onSearchTap: () =>
                        utilitiesBloc.add(UtilitiesSearchEvent()),
                  ),
                  Visibility(
                    visible: isSearching,
                    child: SearchBoxWidget(
                      controller: searchController,
                      onSubmitted: (char) {
                        utilitiesBloc.add(UtilitiesSearchEvent());
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
                          itemCount: 15,
                          itemBuilder: (context, index) {
                            return _utilitiesCardWidget();
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

  Widget _utilitiesCardWidget() {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: SizeUtils().hp(1)),
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
                          'Fire Station',
                          style: size12Regular().copyWith(
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        SizedBox(height: SizeUtils().hp(3)),
                        Text('101', style: size12Regular()),
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
    );
  }
}