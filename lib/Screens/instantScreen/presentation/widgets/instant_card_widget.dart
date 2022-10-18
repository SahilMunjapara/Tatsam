import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:tatsam/Screens/instantScreen/data/model/instant_response_model.dart';
import 'package:tatsam/Utils/constants/colors.dart';
import 'package:tatsam/Utils/constants/image.dart';
import 'package:tatsam/Utils/constants/textStyle.dart';
import 'package:tatsam/Utils/size_utils/size_utils.dart';

class InstantCard extends StatelessWidget {
  const InstantCard({this.instantData, this.onDeleteTap, Key? key})
      : super(key: key);
  final InstantData? instantData;
  final VoidCallback? onDeleteTap;

  @override
  Widget build(BuildContext context) {
    SizeUtils().init(context);
    return Padding(
      padding: EdgeInsets.only(
        top: SizeUtils().hp(2),
        bottom: SizeUtils().hp(2),
        right: SizeUtils().wp(2),
      ),
      child: Slidable(
        key: const ValueKey(0),
        endActionPane: ActionPane(
          motion: const ScrollMotion(),
          extentRatio: 0.3,
          children: [
            Container(
              height: SizeUtils().hp(9.5),
              width: SizeUtils().wp(12),
              decoration: BoxDecoration(
                color: otpBoxColor.withOpacity(0.3),
                borderRadius: const BorderRadius.only(
                  topRight: Radius.circular(10),
                  bottomRight: Radius.circular(10),
                ),
              ),
              child: GestureDetector(
                onTap: onDeleteTap,
                child: Center(
                  child: SvgPicture.asset(ImageString.deleteSvg),
                ),
              ),
            ),
          ],
        ),
        child: Container(
          decoration: BoxDecoration(
            gradient: const LinearGradient(
              colors: [boxGradient1, boxGradient2],
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
            ),
            borderRadius: BorderRadius.circular(10),
            border: Border.all(color: whiteColor),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Container(
                height: SizeUtils().hp(8),
                width: SizeUtils().wp(15),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(5),
                  image: instantData!.imagePath!.isEmpty
                      ? const DecorationImage(
                          image: AssetImage(ImageString.person),
                          fit: BoxFit.fill,
                        )
                      : DecorationImage(
                          image: NetworkImage(instantData!.imagePath!),
                          fit: BoxFit.fill,
                        ),
                ),
              ),
              SizedBox(
                width: SizeUtils().wp(22),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      instantData!.name!.length < 10
                          ? instantData!.name!
                          : instantData!.name!.substring(0, 10),
                      style: size14Regular(),
                    ),
                    SizedBox(height: SizeUtils().hp(1.5)),
                    Text(
                      instantData!.phoneNo!,
                      style: size12Regular(),
                    )
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
