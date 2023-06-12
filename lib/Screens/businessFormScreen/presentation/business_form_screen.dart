import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:image_picker/image_picker.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:tatsam/Screens/businessFormScreen/bloc/bloc.dart';
import 'package:tatsam/Screens/dashboard/bloc/bloc.dart';
import 'package:tatsam/Screens/dashboard/data/model/screen_enum.dart';
import 'package:tatsam/Utils/constants/colors.dart';
import 'package:tatsam/Utils/constants/image.dart';
import 'package:tatsam/Utils/constants/strings.dart';
import 'package:tatsam/Utils/constants/textStyle.dart';
import 'package:tatsam/Utils/size_utils/size_utils.dart';
import 'package:tatsam/Utils/validation/validation.dart';
import 'package:tatsam/commonWidget/custom_appbar.dart';
import 'package:tatsam/commonWidget/custom_dialog_box_widget.dart';
import 'package:tatsam/commonWidget/custom_text_field.dart';
import 'package:tatsam/commonWidget/drawer_screen.dart';
import 'package:tatsam/commonWidget/snackbar_widget.dart';
import 'package:tatsam/service/exception/exception.dart';
import 'package:universal_io/io.dart' as IO;

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
  late File businessLogoImage;
  late ImagePicker _imagePicker;
  late GlobalKey<ScaffoldState> scaffoldState;
  late String dropdownvalue;
  bool isLoading = false;
  late String businessTypeId;
  List<String> items = businessTypeList;

  @override
  void initState() {
    super.initState();
    businessLogoImage = File('');
    _imagePicker = ImagePicker();
    dropdownvalue = Strings.architecture;
    businessTypeId = StringDigits.one;
    nameController = TextEditingController();
    workNameController = TextEditingController();
    mobileNumberController = TextEditingController();
    scaffoldState = GlobalKey<ScaffoldState>();
  }

  void _onStatusRequested(status) {
    if (status != PermissionStatus.granted) {
      if (IO.Platform.isIOS) {
        openAppSettings();
      } else {
        if (status == PermissionStatus.permanentlyDenied) {
          openAppSettings();
        }
      }
    } else {
      _getImage(ImageSource.gallery);
    }
  }

  Future requestPermission(Permission permission) async {
    final result = await permission.request();
    return result;
  }

  void _askPermissionStorage() {
    requestPermission(Permission.storage).then(_onStatusRequested);
  }

  void _askPermissionPhotos() {
    requestPermission(Permission.photos).then(_onStatusRequested);
  }

  _getImage(ImageSource source) async {
    PickedFile? pickedFile = await _imagePicker.getImage(
            source: source, maxWidth: 640, imageQuality: 100) ??
        PickedFile('');

    if (pickedFile.path.isNotEmpty) {
      businessFormBloc.add(
        BusinessImageFetchEvent(pickedImage: File(pickedFile.path)),
      );
    }
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
          listener: (context, state) {
            if (state is BusinessFormLoadingStartState) {
              isLoading = true;
            }
            if (state is BusinessFormLoadingEndState) {
              isLoading = false;
            }
            if (state is BusinessTypeSelectState) {
              dropdownvalue = state.businessType;
              switch (dropdownvalue) {
                case Strings.architecture:
                  businessTypeId = StringDigits.one;
                  break;
                case Strings.doctor:
                  businessTypeId = StringDigits.two;
                  break;
                case Strings.plumber:
                  businessTypeId = StringDigits.three;
                  break;
                case Strings.ui:
                  businessTypeId = StringDigits.four;
                  break;
                default:
              }
            }
            if (state is AddNewBusinessState) {
              SnackbarWidget.showBottomToast(
                  message: state.responseModel.message);
              context.read<DashboardBloc>().add(
                    DashboardLandingScreenEvent(
                        appScreens: AppScreens.businessScreen),
                  );
            }
            if (state is BusinessImageFetchState) {
              businessLogoImage = state.pickedImage;
            }
            if (state is BusinessFormErrorState) {
              AppException exception = state.exception;
              if (ResponseString.unauthorized == exception.message) {
                CustomDialog.showSessionExpiredDialog(context);
              } else {
                SnackbarWidget.showBottomToast(
                  message: exception.errorCode == 201
                      ? ValidatorString.alreadyBusinessTypeSelected
                      : exception.message,
                );
              }
            }
          },
          builder: (context, state) {
            return GestureDetector(
              onTap: () => FocusScope.of(context).unfocus(),
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: SizeUtils().wp(6)),
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      SizedBox(height: SizeUtils().hp(2)),
                      CustomAppBar(
                        title: Strings.businessFormScreenHeader,
                        onMenuTap: () =>
                            scaffoldState.currentState!.openDrawer(),
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
                          _textFormTitle(Strings.businessType),
                          SizedBox(height: SizeUtils().hp(0.5)),
                          _textFormBackground(
                            child: DropdownButtonHideUnderline(
                              child: DropdownButton(
                                isExpanded: true,
                                value: dropdownvalue,
                                dropdownColor: whiteColor,
                                icon: Icon(
                                  Icons.arrow_drop_down_rounded,
                                  color: blackColor,
                                  size: SizeUtils().wp(8),
                                ),
                                items: items.map((String items) {
                                  return DropdownMenuItem(
                                    value: items,
                                    child: Text(
                                      items,
                                      style:
                                          size18Regular(textColor: blackColor),
                                    ),
                                  );
                                }).toList(),
                                onChanged: (type) {
                                  businessFormBloc.add(
                                    BusinessTypeSelectEvent(
                                      businessType: type.toString(),
                                    ),
                                  );
                                },
                              ),
                            ),
                          ),
                          SizedBox(height: SizeUtils().hp(2)),
                          _textFormTitle(Strings.uploadLogo),
                          SizedBox(height: SizeUtils().hp(0.5)),
                          GestureDetector(
                            onTap: () {
                              if (IO.Platform.isIOS) {
                                _askPermissionPhotos();
                              } else {
                                _askPermissionStorage();
                              }
                            },
                            child: businessLogoImage.path.isEmpty
                                ? _uploadImageField()
                                : SizedBox(
                                    height: SizeUtils().hp(10),
                                    width: SizeUtils().wp(19),
                                    child: Stack(
                                      children: [
                                        Container(
                                          height: SizeUtils().hp(10),
                                          width: SizeUtils().wp(18),
                                          decoration: BoxDecoration(
                                            shape: BoxShape.circle,
                                            image: DecorationImage(
                                              image:
                                                  FileImage(businessLogoImage),
                                              fit: BoxFit.fill,
                                            ),
                                          ),
                                        ),
                                        Positioned(
                                          bottom: 0,
                                          right: 0,
                                          child: Container(
                                            height: SizeUtils().hp(4),
                                            width: SizeUtils().wp(7),
                                            decoration: const BoxDecoration(
                                              shape: BoxShape.circle,
                                              color: profileButtonColor,
                                            ),
                                            child: Center(
                                              child: Icon(
                                                Icons.camera_alt,
                                                size: SizeUtils().wp(4),
                                              ),
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                          ),
                          SizedBox(height: SizeUtils().hp(2)),
                          Center(
                            child: GestureDetector(
                              onTap: isLoading
                                  ? null
                                  : () {
                                      if (checkValidation()) {
                                        if (businessLogoImage.path.isEmpty) {
                                          SnackbarWidget.showBottomToast(
                                              message: ValidatorString
                                                  .businessImageRequired);
                                        } else {
                                          businessFormBloc.add(
                                            AddNewBusinessEvent(
                                              businessName: nameController.text,
                                              businessAddress:
                                                  workNameController.text,
                                              businessPhoneNumber:
                                                  mobileNumberController.text,
                                              businessTypeId: businessTypeId,
                                              businessImage: businessLogoImage,
                                            ),
                                          );
                                        }
                                      }
                                    },
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
                          ),
                        ],
                      )
                    ],
                  ),
                ),
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

  Widget _uploadImageField() {
    return Container(
      height: SizeUtils().hp(12),
      decoration: const BoxDecoration(
        image: DecorationImage(
          image: AssetImage(ImageString.uploadBackgroundLine),
          fit: BoxFit.fill,
        ),
      ),
      child: Padding(
        padding: EdgeInsets.symmetric(
          vertical: SizeUtils().hp(0.5),
          horizontal: SizeUtils().wp(1),
        ),
        child: Container(
          decoration: const BoxDecoration(
            image: DecorationImage(
              image: AssetImage(ImageString.uploadBackground),
              fit: BoxFit.fill,
            ),
          ),
          child: Center(
            child: SvgPicture.asset(ImageString.uploadSvg),
          ),
        ),
      ),
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

  bool checkValidation() {
    if (mobileNumberController.text.isEmpty ||
        workNameController.text.isEmpty ||
        nameController.text.isEmpty) {
      SnackbarWidget.showBottomToast(message: ValidatorString.allFieldRequired);
      return false;
    } else {
      if (!Validator.validCharacters.hasMatch(nameController.text)) {
        SnackbarWidget.showBottomToast(message: ValidatorString.validName);
        return false;
      } else if (!Validator.validCharacters.hasMatch(workNameController.text)) {
        SnackbarWidget.showBottomToast(message: ValidatorString.validWorkName);
        return false;
      } else if (!Validator.mobileCharacter
          .hasMatch(mobileNumberController.text)) {
        SnackbarWidget.showBottomToast(message: ValidatorString.validMobile);
        return false;
      } else {
        return true;
      }
    }
  }
}
