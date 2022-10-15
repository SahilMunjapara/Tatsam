import 'package:flutter/material.dart';
import 'package:tatsam/Utils/constants/colors.dart';
import 'package:tatsam/Utils/size_utils/size_utils.dart';

class SelectSearchBoxWidget extends StatelessWidget {
  const SelectSearchBoxWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    SizeUtils().init(context);
    return SizedBox(
      height: SizeUtils().hp(10),
      child: Padding(
        padding: EdgeInsets.only(
          right: SizeUtils().wp(0),
          left: SizeUtils().wp(12),
        ),
        child: Container(
          decoration: BoxDecoration(
            color: otpBoxColor.withOpacity(0.49),
            borderRadius: const BorderRadius.only(
              bottomLeft: Radius.circular(15),
              bottomRight: Radius.circular(15),
            ),
          ),
          child: Padding(
            padding: const EdgeInsets.all(25.0),
            child: Container(
              color: whiteColor,
              height: SizeUtils().hp(6),
            ),
          ),
        ),
      ),
    );
  }
}
