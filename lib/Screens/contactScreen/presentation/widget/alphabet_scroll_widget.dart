import 'package:azlistview/azlistview.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:tatsam/Screens/contactScreen/presentation/widget/inner_shadow.dart';
import 'package:tatsam/Utils/constants/colors.dart';
import 'package:tatsam/Utils/constants/image.dart';
import 'package:tatsam/Utils/constants/textStyle.dart';
import 'package:tatsam/Utils/size_utils/size_utils.dart';
import 'package:flutter_slidable/flutter_slidable.dart';

class AlphabetScrollWidget extends StatefulWidget {
  const AlphabetScrollWidget({required this.items, Key? key}) : super(key: key);
  final List<String> items;

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

  void initList(List<String> items) {
    this.items = items
        .map((item) => _AZItem(title: item, tag: item[0].toUpperCase()))
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
        return _buildListItem(item);
      },
    );
  }

  Widget _buildListItem(_AZItem item) {
    return Padding(
      padding: EdgeInsets.symmetric(
        horizontal: SizeUtils().wp(5),
        vertical: SizeUtils().hp(3),
      ),
      child: Slidable(
        key: const ValueKey(0),
        endActionPane: const ActionPane(
          motion: ScrollMotion(),
          extentRatio: 0.3,
          children: [
            SlidableAction(
              onPressed: null,
              backgroundColor: transparentColor,
              foregroundColor: Colors.white,
              icon: Icons.phone,
            ),
            SlidableAction(
              onPressed: null,
              backgroundColor: transparentColor,
              foregroundColor: Colors.white,
              icon: Icons.person,
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
                    decoration: BoxDecoration(
                      image: const DecorationImage(
                        image: AssetImage(ImageString.person),
                        fit: BoxFit.fill,
                      ),
                      borderRadius: BorderRadius.circular(30),
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
                Text('1234', style: size18Regular()),
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

  _AZItem({
    required this.title,
    required this.tag,
  });

  @override
  String getSuspensionTag() => tag;
}
