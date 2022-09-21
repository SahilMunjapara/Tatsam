import 'package:flutter/cupertino.dart';
import 'package:flutter_svg/svg.dart';
import 'package:tatsam/Utils/constants/colors.dart';
import 'package:tatsam/Utils/constants/image.dart';
import 'package:tatsam/Utils/constants/textStyle.dart';
import 'package:tatsam/Utils/size_utils/size_utils.dart';

class CustomAppBar extends StatelessWidget {
  const CustomAppBar({this.title, this.onMenuTap, this.padding = 0.0, Key? key})
      : super(key: key);
  final String? title;
  final VoidCallback? onMenuTap;
  final double padding;

  @override
  Widget build(BuildContext context) {
    SizeUtils().init(context);
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: SizeUtils().wp(padding)),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Column(
            children: [
              SizedBox(height: SizeUtils().hp(2)),
              GestureDetector(
                onTap: onMenuTap,
                child: Container(
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
              ),
            ],
          ),
          Text(
            title!,
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
