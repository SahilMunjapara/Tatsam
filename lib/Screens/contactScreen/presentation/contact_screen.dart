import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:tatsam/Screens/contactScreen/presentation/widget/alphabet_scroll_widget.dart';
import 'package:tatsam/Utils/constants/colors.dart';
import 'package:tatsam/Utils/constants/image.dart';
import 'package:tatsam/Utils/constants/strings.dart';
import 'package:tatsam/Utils/constants/textStyle.dart';
import 'package:tatsam/Utils/size_utils/size_utils.dart';

class ContactScreen extends StatefulWidget {
  const ContactScreen({Key? key}) : super(key: key);

  @override
  State<ContactScreen> createState() => _ContactScreenState();
}

class _ContactScreenState extends State<ContactScreen> {
  @override
  Widget build(BuildContext context) {
    SizeUtils().init(context);
    return SafeArea(
      child: Scaffold(
        backgroundColor: transparentColor,
        body: Padding(
          padding: EdgeInsets.only(bottom: SizeUtils().hp(6)),
          child: Column(
            children: [
              SizedBox(height: SizeUtils().hp(2)),
              _profileTitleWidgets(),
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

  Widget _profileTitleWidgets() {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: SizeUtils().wp(8)),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Column(
            children: [
              SizedBox(height: SizeUtils().hp(2)),
              Container(
                height: SizeUtils().hp(6),
                width: SizeUtils().wp(11),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(7),
                  color: profileButtonColor,
                  boxShadow: const [
                    BoxShadow(
                      blurRadius: 4,
                      color: boxShadow,
                      offset: Offset(2, 2),
                    )
                  ],
                ),
                child: Padding(
                  padding: EdgeInsets.symmetric(
                    horizontal: SizeUtils().wp(2.5),
                    vertical: SizeUtils().hp(2),
                  ),
                  child: SvgPicture.asset(
                    ImageString.menuSvg,
                    fit: BoxFit.fill,
                  ),
                ),
              ),
            ],
          ),
          Text(
            Strings.contactsScreenHeader,
            style: size38Regular(),
          ),
          Column(
            children: [
              SizedBox(height: SizeUtils().hp(2)),
              Container(
                height: SizeUtils().hp(6),
                width: SizeUtils().wp(11),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(7),
                  color: profileButtonColor,
                  boxShadow: const [
                    BoxShadow(
                      blurRadius: 4,
                      color: boxShadow,
                      offset: Offset(-2, 2),
                    )
                  ],
                ),
                child: Padding(
                  padding: EdgeInsets.symmetric(
                    horizontal: SizeUtils().wp(3.5),
                    vertical: SizeUtils().hp(2),
                  ),
                  child: SvgPicture.asset(
                    ImageString.searchSvg,
                    fit: BoxFit.fill,
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
