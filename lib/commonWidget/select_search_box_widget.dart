import 'package:flutter/material.dart';
import 'package:tatsam/Screens/contactScreen/data/model/user_response_model.dart';
import 'package:tatsam/Utils/constants/colors.dart';
import 'package:tatsam/Utils/constants/image.dart';
import 'package:tatsam/Utils/constants/textStyle.dart';
import 'package:tatsam/Utils/size_utils/size_utils.dart';

class SelectSearchBoxWidget extends StatelessWidget {
  const SelectSearchBoxWidget(
      {this.userList,
      this.selectedUserList,
      this.onUserTap,
      this.onDeleteTap,
      this.onAddTap,
      Key? key})
      : super(key: key);
  final List<UserResponseModel>? userList;
  final List<UserResponseModel>? selectedUserList;
  final Function(UserResponseModel)? onUserTap;
  final Function(UserResponseModel)? onDeleteTap;
  final VoidCallback? onAddTap;

  @override
  Widget build(BuildContext context) {
    SizeUtils().init(context);
    return SizedBox(
      height: SizeUtils().hp(25),
      child: Stack(
        children: [
          Padding(
            padding: EdgeInsets.only(left: SizeUtils().wp(12)),
            child: Container(
              height: SizeUtils().hp(15),
              decoration: BoxDecoration(
                color: otpBoxColor.withOpacity(0.49),
                borderRadius: const BorderRadius.only(
                  bottomLeft: Radius.circular(15),
                  bottomRight: Radius.circular(15),
                ),
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.only(
              left: SizeUtils().wp(12),
              top: SizeUtils().hp(3),
            ),
            child: Center(
              child: Column(
                children: [
                  Container(
                    height: SizeUtils().hp(6),
                    width: SizeUtils().wp(60),
                    color: whiteColor,
                    child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemCount: selectedUserList!.length,
                      itemBuilder: (context, index) {
                        return Padding(
                          padding: EdgeInsets.symmetric(
                              horizontal: SizeUtils().wp(1.5)),
                          child: Center(
                            child: Container(
                              width: SizeUtils().wp(15),
                              decoration: BoxDecoration(
                                color: blackColor,
                                borderRadius: BorderRadius.circular(5),
                              ),
                              child: Padding(
                                padding: EdgeInsets.symmetric(
                                  vertical: SizeUtils().hp(0.7),
                                  horizontal: SizeUtils().wp(0.5),
                                ),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceAround,
                                  children: [
                                    SizedBox(
                                      width: SizeUtils().wp(10),
                                      child: Text(
                                        selectedUserList![index].name!,
                                        overflow: TextOverflow.ellipsis,
                                        maxLines: 1,
                                        style: size14Regular(),
                                      ),
                                    ),
                                    GestureDetector(
                                      onTap: () {
                                        onDeleteTap!(selectedUserList![index]);
                                      },
                                      child: Icon(
                                        Icons.close,
                                        size: SizeUtils().wp(3.5),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                  SizedBox(height: SizeUtils().hp(1)),
                  Expanded(
                    child: Padding(
                      padding:
                          EdgeInsets.symmetric(horizontal: SizeUtils().wp(8)),
                      child: Container(
                        color: whiteColor,
                        child: ListView.separated(
                          padding: EdgeInsets.symmetric(
                            horizontal: SizeUtils().wp(3),
                            vertical: SizeUtils().hp(1),
                          ),
                          itemBuilder: (context, index) {
                            return index == 0
                                ? const SizedBox()
                                : const Divider(
                                    color: dividerColor, thickness: 1.2);
                          },
                          separatorBuilder: (context, index) {
                            return GestureDetector(
                              onTap: () {
                                onUserTap!(userList![index]);
                              },
                              child: Padding(
                                padding: EdgeInsets.symmetric(
                                    vertical: SizeUtils().hp(1)),
                                child: Text(
                                  userList![index].name!,
                                  style: size14Regular(textColor: blackColor)
                                      .copyWith(fontWeight: FontWeight.w600),
                                ),
                              ),
                            );
                          },
                          itemCount: userList!.length,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          Positioned(
            bottom: 0,
            right: 0,
            child: GestureDetector(
              onTap: onAddTap,
              child: Container(
                decoration: const BoxDecoration(
                  shape: BoxShape.circle,
                  color: whiteColor,
                ),
                child: Image.asset(ImageString.searchDone),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
