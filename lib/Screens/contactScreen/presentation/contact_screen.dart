import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tatsam/Screens/contactScreen/bloc/bloc.dart';
import 'package:tatsam/Screens/contactScreen/presentation/widget/alphabet_scroll_widget.dart';
import 'package:tatsam/Utils/constants/colors.dart';
import 'package:tatsam/Utils/constants/image.dart';
import 'package:tatsam/Utils/constants/strings.dart';
import 'package:tatsam/Utils/size_utils/size_utils.dart';
import 'package:tatsam/commonWidget/custom_appbar.dart';
import 'package:tatsam/commonWidget/drawer_screen.dart';
import 'package:tatsam/commonWidget/search_box_widget.dart';

class ContactScreen extends StatefulWidget {
  const ContactScreen({Key? key}) : super(key: key);

  @override
  State<ContactScreen> createState() => _ContactScreenState();
}

class _ContactScreenState extends State<ContactScreen> {
  ContactBloc contactBloc = ContactBloc();
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
          },
          builder: (context, state) {
            return Padding(
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
                    onMenuTap: () => scaffoldState.currentState!.openDrawer(),
                    onSearchTap: () => contactBloc.add(ContactSearchEvent()),
                  ),
                  Visibility(
                    visible: isSearching,
                    child: SearchBoxWidget(
                      controller: searchController,
                      rightPadding: 6.0,
                      leftPadding: 18.0,
                      onSubmitted: (char) {
                        contactBloc.add(ContactSearchEvent());
                      },
                    ),
                  ),
                  SizedBox(height: SizeUtils().hp(4)),
                  Expanded(
                    child: Container(
                      decoration: BoxDecoration(
                        color: otpBoxColor.withOpacity(0.15),
                        borderRadius: BorderRadius.circular(30),
                      ),
                      child:
                          NotificationListener<OverscrollIndicatorNotification>(
                        onNotification: (overScroll) {
                          overScroll.disallowIndicator();
                          return false;
                        },
                        child: AlphabetScrollWidget(items: userContactList),
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
}
