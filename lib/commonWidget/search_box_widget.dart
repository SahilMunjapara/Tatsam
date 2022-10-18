import 'package:flutter/material.dart';
import 'package:tatsam/Utils/constants/colors.dart';
import 'package:tatsam/Utils/constants/image.dart';
import 'package:tatsam/Utils/constants/textStyle.dart';
import 'package:tatsam/Utils/size_utils/size_utils.dart';
import 'package:tatsam/commonWidget/custom_text_field.dart';

class SearchBoxWidget extends StatelessWidget {
  const SearchBoxWidget(
      {this.controller,
      this.onSubmitted,
      this.onChanged,
      this.onSearchDoneTap,
      this.leftPadding = 12.0,
      this.rightPadding = 0.0,
      Key? key})
      : super(key: key);

  final TextEditingController? controller;
  final Function(String)? onSubmitted;
  final Function(String)? onChanged;
  final VoidCallback? onSearchDoneTap;
  final double leftPadding;
  final double rightPadding;

  @override
  Widget build(BuildContext context) {
    SizeUtils().init(context);
    return Padding(
      padding: EdgeInsets.only(
        right: SizeUtils().wp(rightPadding),
        left: SizeUtils().wp(leftPadding),
      ),
      child: Container(
        decoration: BoxDecoration(
          color: otpBoxColor.withOpacity(0.49),
          borderRadius: const BorderRadius.only(
              bottomLeft: Radius.circular(15),
              bottomRight: Radius.circular(15)),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Padding(
              padding: EdgeInsets.symmetric(
                  horizontal: SizeUtils().wp(5), vertical: SizeUtils().hp(2)),
              child: Container(
                decoration: const BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage(ImageString.searchForm),
                    fit: BoxFit.fill,
                  ),
                ),
                child: Padding(
                  padding: EdgeInsets.symmetric(
                    horizontal: SizeUtils().wp(6),
                  ),
                  child: CustomTextField(
                    controller: controller,
                    cursorColor: blackColor,
                    isBorder: false,
                    textInputType: TextInputType.name,
                    textInputAction: TextInputAction.done,
                    style: size14Regular(textColor: blackColor),
                    onFieldSubmitted: (value) => onSubmitted!(value),
                    onChange: (value) => onChanged!(value),
                  ),
                ),
              ),
            ),
            GestureDetector(
              onTap: onSearchDoneTap,
              child: Padding(
                padding: EdgeInsets.symmetric(
                    horizontal: SizeUtils().wp(2), vertical: SizeUtils().hp(2)),
                child: Image.asset(ImageString.searchDone),
              ),
            )
          ],
        ),
      ),
    );
  }
}
