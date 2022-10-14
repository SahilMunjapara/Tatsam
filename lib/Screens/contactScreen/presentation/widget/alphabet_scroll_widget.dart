import 'dart:developer';

import 'package:azlistview/azlistview.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:tatsam/Screens/contactProfileScreen/bloc/bloc.dart';
import 'package:tatsam/Screens/contactScreen/data/model/user_response_model.dart';
import 'package:tatsam/Screens/contactScreen/presentation/widget/inner_shadow.dart';
import 'package:tatsam/Screens/dashboard/bloc/bloc.dart';
import 'package:tatsam/Screens/dashboard/data/model/screen_enum.dart';
import 'package:tatsam/Utils/constants/colors.dart';
import 'package:tatsam/Utils/constants/image.dart';
import 'package:tatsam/Utils/constants/textStyle.dart';
import 'package:tatsam/Utils/size_utils/size_utils.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:url_launcher/url_launcher.dart';

class AlphabetScrollWidget extends StatefulWidget {
  const AlphabetScrollWidget({required this.items, Key? key}) : super(key: key);
  final List<UserResponseModel> items;

  @override
  State<AlphabetScrollWidget> createState() => _AlphabetScrollWidgetState();
}

class _AlphabetScrollWidgetState extends State<AlphabetScrollWidget> {
  List<_AZItem> items = [];

  @override
  void initState() {
    super.initState();
    initList(widget.items);
  }

  void initList(List<UserResponseModel> items) {
    this.items = items
        .map((item) => _AZItem(
              title: item.name!,
              tag: item.name![0].toUpperCase(),
              phoneNumber: item.phoneNo!,
              userId: item.id!.toString(),
            ))
        .toList();
    SuspensionUtil.sortListBySuspensionTag(this.items);
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return AzListView(
      data: items,
      itemCount: items.length,
      itemBuilder: (context, index) {
        final item = items[index];
        return _buildListItem(item, () {
          DashboardBloc bloc = context.read<DashboardBloc>();
          bloc.contactProfileSearchId = item.userId;
          bloc.add(
            DashboardLandingScreenEvent(
              appScreens: AppScreens.contactProfileScreen,
            ),
          );
        });
      },
    );
  }

  Widget _buildListItem(_AZItem item, VoidCallback onProfileTap) {
    return Padding(
      padding: EdgeInsets.symmetric(
        horizontal: SizeUtils().wp(5),
        vertical: SizeUtils().hp(3),
      ),
      child: Slidable(
        key: const ValueKey(0),
        endActionPane: ActionPane(
          motion: const ScrollMotion(),
          extentRatio: 0.3,
          children: [
            Expanded(
              child: Padding(
                padding: EdgeInsets.only(left: SizeUtils().wp(1.5)),
                child: Container(
                  decoration: const BoxDecoration(
                    gradient: LinearGradient(
                      colors: [
                        callBoxGradient1,
                        callBoxGradient2,
                      ],
                    ),
                    boxShadow: [
                      BoxShadow(
                        offset: Offset(-1, 1),
                        color: shadow1Color,
                        blurRadius: 5,
                      )
                    ],
                    borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(20),
                      topLeft: Radius.circular(20),
                    ),
                  ),
                  child: Padding(
                    padding: EdgeInsets.symmetric(
                      vertical: SizeUtils().hp(1.5),
                      horizontal: SizeUtils().wp(2.5),
                    ),
                    child: Row(
                      children: [
                        GestureDetector(
                          onTap: () {
                            launchUrl(Uri.parse('tel:${item.phoneNumber}'));
                          },
                          child: Icon(
                            Icons.phone,
                            size: SizeUtils().hp(2.5),
                          ),
                        ),
                        SizedBox(width: SizeUtils().wp(1)),
                        SizedBox(
                          height: SizeUtils().hp(2.5),
                          child: const VerticalDivider(
                            color: whiteColor,
                            thickness: 1.5,
                          ),
                        ),
                        SizedBox(width: SizeUtils().wp(1)),
                        GestureDetector(
                          onTap: onProfileTap,
                          child: Icon(
                            Icons.person,
                            size: SizeUtils().hp(2.5),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                InnerShadow(
                  blur: 4,
                  color: shadow1Color,
                  offset: const Offset(0, 0),
                  child: Container(
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
                ),
                SizedBox(width: SizeUtils().wp(3)),
                Text(item.title, style: size18Regular()),
              ],
            ),
            Row(
              children: [
                SizedBox(
                  height: SizeUtils().hp(5),
                  child: VerticalDivider(
                    color: whiteColor.withOpacity(0.3),
                    thickness: 1.8,
                  ),
                ),
                SizedBox(width: SizeUtils().wp(3)),
                SvgPicture.asset(ImageString.homeSvg),
                SizedBox(width: SizeUtils().wp(3)),
                SizedBox(
                  width: SizeUtils().wp(10),
                  child: Text(
                    item.phoneNumber,
                    maxLines: 1,
                    style: size18Regular(),
                  ),
                ),
                SizedBox(width: SizeUtils().wp(5)),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class _AZItem extends ISuspensionBean {
  final String title;
  final String tag;
  final String phoneNumber;
  final String userId;

  _AZItem({
    required this.title,
    required this.tag,
    required this.phoneNumber,
    required this.userId,
  });

  @override
  String getSuspensionTag() => tag;
}
