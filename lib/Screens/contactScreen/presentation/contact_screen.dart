import 'package:flutter/material.dart';
import 'package:tatsam/Screens/contactScreen/presentation/widget/alphabet_scroll_widget.dart';
import 'package:tatsam/Utils/constants/colors.dart';
import 'package:tatsam/Utils/constants/strings.dart';
import 'package:tatsam/Utils/size_utils/size_utils.dart';
import 'package:tatsam/commonWidget/custom_appbar.dart';
import 'package:tatsam/commonWidget/drawer_screen.dart';

class ContactScreen extends StatefulWidget {
  const ContactScreen({Key? key}) : super(key: key);

  @override
  State<ContactScreen> createState() => _ContactScreenState();
}

class _ContactScreenState extends State<ContactScreen> {
  late GlobalKey<ScaffoldState> scaffoldState;

  @override
  void initState() {
    super.initState();
    scaffoldState = GlobalKey<ScaffoldState>();
  }

  @override
  Widget build(BuildContext context) {
    SizeUtils().init(context);
    return SafeArea(
      child: Scaffold(
        key: scaffoldState,
        backgroundColor: transparentColor,
        drawer: const DrawerScreen(),
        body: Padding(
          padding: EdgeInsets.only(
            bottom: SizeUtils().hp(6),
          ),
          child: Column(
            children: [
              SizedBox(height: SizeUtils().hp(2)),
              CustomAppBar(
                title: Strings.contactsScreenHeader,
                padding: 6.0,
                onMenuTap: () => scaffoldState.currentState!.openDrawer(),
              ),
              SizedBox(height: SizeUtils().hp(4)),
              Expanded(
                child: Container(
                  decoration: BoxDecoration(
                    color: otpBoxColor.withOpacity(0.15),
                    borderRadius: BorderRadius.circular(30),
                  ),
                  child: NotificationListener<OverscrollIndicatorNotification>(
                    onNotification: (overScroll) {
                      overScroll.disallowIndicator();
                      return false;
                    },
                    child: const AlphabetScrollWidget(
                      items: [
                        'arav patel',
                        'birav patel',
                        'cirav patel',
                        'dirav patel',
                        'eirav patel',
                        'firav patel',
                        'girav patel',
                        'hirav patel',
                        'irav patel',
                        'jirav patel',
                        'kirav patel',
                        'lirav patel',
                        'mirav patel',
                        'nirav patel',
                        'oirav patel',
                        'pirav patel',
                        'qirav patel',
                        'rirav patel',
                        'sirav patel',
                        'tirav patel',
                        'uirav patel',
                        'virav patel',
                        'wirav patel',
                        'xirav patel',
                        'yirav patel',
                        'zirav patel',
                      ],
                    ),
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
