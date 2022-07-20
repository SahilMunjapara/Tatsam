import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:tatsam/Utils/constants/colors.dart';
import 'package:tatsam/Utils/constants/image.dart';
import 'package:tatsam/Utils/constants/strings.dart';
import 'package:tatsam/Utils/constants/textStyle.dart';
import 'package:tatsam/Utils/size_utils/size_utils.dart';

class OtpScreen extends StatefulWidget {
  const OtpScreen({Key? key}) : super(key: key);

  @override
  State<OtpScreen> createState() => _OtpScreenState();
}

class _OtpScreenState extends State<OtpScreen> {
  @override
  Widget build(BuildContext context) {
    SizeUtils().init(context);
    return WillPopScope(
      onWillPop: () => Future<bool>.value(false),
      child: SafeArea(
        child: Scaffold(
          backgroundColor: backgroundColor,
          body: Stack(
            children: [
              Positioned(
                right: 0,
                child: Image.asset(ImageString.topRightCircle),
              ),
              Positioned(
                left: 0,
                bottom: 0,
                child: Image.asset(ImageString.bottomLeftCircle),
              ),
              Center(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 30.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      SizedBox(height: SizeUtils().hp(3)),
                      Text(
                        Strings.appName,
                        style: size48Regular(),
                      ),
                      SizedBox(height: SizeUtils().hp(2)),
                      SvgPicture.asset(ImageString.otpVerificationSvg),
                      SizedBox(height: SizeUtils().hp(7.5)),
                      Text(
                        Strings.otpScreenDetail,
                        style: size20Regular(),
                      ),
                      SizedBox(height: SizeUtils().hp(4)),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Column(
                            children: [
                              Image.asset(ImageString.otpBox),
                              const SizedBox(height: 30),
                            ],
                          ),
                          Column(
                            children: [
                              const SizedBox(height: 30),
                              Image.asset(ImageString.otpBox),
                            ],
                          ),
                          Column(
                            children: [
                              Image.asset(ImageString.otpBox),
                              const SizedBox(height: 30),
                            ],
                          ),
                          Column(
                            children: [
                              const SizedBox(height: 30),
                              Image.asset(ImageString.otpBox),
                            ],
                          ),
                        ],
                      ),
                      SizedBox(height: SizeUtils().hp(4)),
                      Text(
                        Strings.resendOtp,
                        style: size15Regular(),
                      ),
                      SizedBox(height: SizeUtils().hp(2)),
                      Container(
                        decoration: BoxDecoration(
                          color: otpBoxColor,
                          borderRadius: BorderRadius.circular(30),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 50, vertical: 12),
                          child: Text(
                            Strings.verify,
                            style: size19Regular(textColor: blackColor),
                          ),
                        ),
                      ),
                    ],
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
