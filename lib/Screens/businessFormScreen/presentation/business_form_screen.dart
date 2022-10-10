import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tatsam/Screens/businessFormScreen/bloc/bloc.dart';
import 'package:tatsam/Utils/constants/colors.dart';
import 'package:tatsam/Utils/constants/image.dart';
import 'package:tatsam/Utils/constants/strings.dart';
import 'package:tatsam/Utils/constants/textStyle.dart';
import 'package:tatsam/Utils/size_utils/size_utils.dart';
import 'package:tatsam/commonWidget/custom_appbar.dart';
import 'package:tatsam/commonWidget/custom_text_field.dart';
import 'package:tatsam/commonWidget/drawer_screen.dart';

class BusinessFormScreen extends StatefulWidget {
  const BusinessFormScreen({Key? key}) : super(key: key);

  @override
  State<BusinessFormScreen> createState() => _BusinessFormScreenState();
}

class _BusinessFormScreenState extends State<BusinessFormScreen> {
  BusinessFormBloc businessFormBloc = BusinessFormBloc();
  late TextEditingController nameController;
  late TextEditingController workNameController;
  late TextEditingController mobileNumberController;

  late GlobalKey<ScaffoldState> scaffoldState;

  @override
  void initState() {
    super.initState();
    nameController = TextEditingController();
    workNameController = TextEditingController();
    mobileNumberController = TextEditingController();
    scaffoldState = GlobalKey<ScaffoldState>();
  }

  @override
  void dispose() {
    nameController.dispose();
    workNameController.dispose();
    mobileNumberController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    SizeUtils().init(context);
    return SafeArea(
      child: Scaffold(
        backgroundColor: transparentColor,
        resizeToAvoidBottomInset: false,
        key: scaffoldState,
        drawer: const DrawerScreen(),
        body: BlocConsumer(
          bloc: businessFormBloc,
          listener: (context, state) {},
          builder: (context, state) {
            return Padding(
              padding: EdgeInsets.symmetric(horizontal: SizeUtils().wp(6)),
              child: Column(
                children: [
                  SizedBox(height: SizeUtils().hp(2)),
                  CustomAppBar(
                    title: Strings.businessFormScreenHeader,
                    onMenuTap: () => scaffoldState.currentState!.openDrawer(),
                  ),
                  SizedBox(height: SizeUtils().hp(4)),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      _textFormTitle(Strings.name),
                      SizedBox(height: SizeUtils().hp(0.5)),
                      _textFormBackground(
                        child: CustomTextField(
                          controller: nameController,
                          cursorColor: blackColor,
                          isBorder: false,
                          textInputType: TextInputType.name,
                          textInputAction: TextInputAction.done,
                          style: size18Regular(textColor: blackColor),
                        ),
                      ),
                      SizedBox(height: SizeUtils().hp(2)),
                      _textFormTitle(Strings.workName),
                      SizedBox(height: SizeUtils().hp(0.5)),
                      _textFormBackground(
                        child: CustomTextField(
                          controller: workNameController,
                          cursorColor: blackColor,
                          isBorder: false,
                          textInputType: TextInputType.name,
                          textInputAction: TextInputAction.done,
                          style: size18Regular(textColor: blackColor),
                        ),
                      ),
                      SizedBox(height: SizeUtils().hp(2)),
                      _textFormTitle(Strings.mobileNo),
                      SizedBox(height: SizeUtils().hp(0.5)),
                      _textFormBackground(
                        child: CustomTextField(
                          controller: mobileNumberController,
                          cursorColor: blackColor,
                          isBorder: false,
                          textInputType: TextInputType.phone,
                          textInputAction: TextInputAction.done,
                          style: size18Regular(textColor: blackColor),
                        ),
                      ),
                      SizedBox(height: SizeUtils().hp(2)),
                      Center(
                        child: Container(
                          decoration: BoxDecoration(
                              color: whiteColor,
                              borderRadius: BorderRadius.circular(30)),
                          child: Padding(
                            padding: EdgeInsets.symmetric(
                              vertical: SizeUtils().hp(1),
                              horizontal: SizeUtils().wp(3),
                            ),
                            child: Text(
                              Strings.submit,
                              style: size18Regular(textColor: blackColor),
                            ),
                          ),
                        ),
                      ),
                    ],
                  )
                ],
              ),
            );
          },
        ),
      ),
    );
  }

  Widget _textFormTitle(String title) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: SizeUtils().wp(6)),
      child: Text(title, style: size18Regular()),
    );
  }

  Widget _textFormBackground({Widget? child}) {
    return Container(
      decoration: const BoxDecoration(
        image: DecorationImage(
          image: AssetImage(ImageString.textForm2),
          fit: BoxFit.fill,
        ),
      ),
      child: Padding(
        padding: EdgeInsets.symmetric(
          vertical: SizeUtils().hp(0.2),
          horizontal: SizeUtils().wp(8),
        ),
        child: child,
      ),
    );
  }
}
