import 'package:tatsam/Screens/otpScreen/data/model/fetch_user_response_model.dart';
import 'package:tatsam/Screens/profileScreen/bloc/bloc.dart';
import 'package:tatsam/Screens/profileScreen/data/model/profile_update_response_model.dart';
import 'package:tatsam/service/exception/exception.dart';
import 'package:universal_io/io.dart';

abstract class ProfileScreenState {}

class ProfileInitialState extends ProfileScreenState {}

class ProfileLoadingStartedState extends ProfileScreenState {}

class ProfileLoadingStoppedState extends ProfileScreenState {}

class ProfileImageFetchState extends ProfileScreenState {
  File pickedImage;
  ProfileImageFetchState(this.pickedImage);
}

class ProfileEditState extends ProfileScreenState {
  bool isProfileEdit;
  ProfileEditState(this.isProfileEdit);
}

class ProfileUpdatedState extends ProfileScreenState {
  ProfileUpdateResponseModel responseModel;
  ProfileUpdatedState(this.responseModel);
}

class ProfileDetailFetchState extends ProfileScreenState {
  FetchUserResponseModel responseModel;
  ProfileDetailFetchState(this.responseModel);
}

class ProfileErrorState extends ProfileScreenState {
  AppException exception;
  ProfileErrorState(this.exception);
}
