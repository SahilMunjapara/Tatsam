import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:tatsam/Utils/constants/colors.dart';
import 'package:tatsam/Utils/constants/image.dart';
import 'package:tatsam/Utils/constants/strings.dart';
import 'package:tatsam/Utils/constants/textStyle.dart';
import 'package:tatsam/Utils/size_utils/size_utils.dart';
import 'package:tatsam/commonWidget/custom_text_field.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  @override
  Widget build(BuildContext context) {
    SizeUtils().init(context);
    return SafeArea(
      child: Scaffold(
        backgroundColor: transparentColor,
        resizeToAvoidBottomInset: true,
        body: Padding(
          padding: EdgeInsets.symmetric(horizontal: SizeUtils().wp(8)),
          child: Column(
            children: [
              SizedBox(height: SizeUtils().hp(2)),
              _profileTitleWidgets(),
              SizedBox(height: SizeUtils().hp(4)),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: SizeUtils().wp(2.5)),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    SizedBox(
                      height: SizeUtils().hp(2.5),
                      width: SizeUtils().wp(5),
                      child: SvgPicture.asset(ImageString.closeSvg),
                    ),
                    SizedBox(
                      height: SizeUtils().hp(2.5),
                      width: SizeUtils().wp(5),
                      child: SvgPicture.asset(ImageString.checkSvg),
                    ),
                  ],
                ),
              ),
              SizedBox(height: SizeUtils().hp(2)),
              Container(
                height: SizeUtils().hp(18),
                width: SizeUtils().wp(34),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(30),
                  color: whiteColor,
                  image: const DecorationImage(
                    image: AssetImage(ImageString.person),
                    fit: BoxFit.fill,
                  ),
                ),
                child: Stack(
                  children: [
                    Positioned(
                      bottom: 0,
                      right: 0,
                      child: Container(
                        height: SizeUtils().hp(5),
                        width: SizeUtils().wp(9),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: backgroundColor,
                        ),
                        child: const Center(
                          child: Icon(Icons.edit),
                        ),
                      ),
                    )
                  ],
                ),
              ),
              SizedBox(height: SizeUtils().hp(3)),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _textFormTitle(Strings.fullName),
                  SizedBox(height: SizeUtils().hp(0.5)),
                  _textFormBackground(
                    child: CustomTextField(
                      isBorder: false,
                      hintText: Strings.nameHint,
                      textInputType: TextInputType.name,
                      textInputAction: TextInputAction.done,
                      style: size16Regular(),
                    ),
                  ),
                  SizedBox(height: SizeUtils().hp(2.5)),
                  _textFormTitle(Strings.contactNum),
                  SizedBox(height: SizeUtils().hp(0.5)),
                  _textFormBackground(
                    child: CustomTextField(
                      isBorder: false,
                      maxLength: 10,
                      hintText: Strings.contactHint,
                      textInputType: TextInputType.phone,
                      textInputAction: TextInputAction.done,
                      style: size16Regular(),
                    ),
                  ),
                  SizedBox(height: SizeUtils().hp(2.5)),
                  _textFormTitle(Strings.emailId),
                  SizedBox(height: SizeUtils().hp(0.5)),
                  _textFormBackground(
                    child: CustomTextField(
                      isBorder: false,
                      hintText: Strings.emailHint,
                      textInputType: TextInputType.emailAddress,
                      textInputAction: TextInputAction.done,
                      style: size16Regular(),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _textFormBackground({Widget? child}) {
    return Container(
      decoration: const BoxDecoration(
        image: DecorationImage(
          image: AssetImage(ImageString.textForm),
          fit: BoxFit.fill,
        ),
      ),
      child: Padding(
        padding: EdgeInsets.symmetric(
          vertical: SizeUtils().hp(1),
          horizontal: SizeUtils().wp(8),
        ),
        child: child,
      ),
    );
  }

  Widget _textFormTitle(String title) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: SizeUtils().wp(6)),
      child: Text(title, style: size18Regular()),
    );
  }

  Widget _profileTitleWidgets() {
    return Row(
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
          Strings.profile,
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
    );
  }
}
