import 'package:tatsam/Screens/profileScreen/data/model/profile_update_response_model.dart';
import 'package:tatsam/service/exception/exception.dart';

abstract class ProfileScreenState {}

class ProfileInitialState extends ProfileScreenState {}

class ProfileLoadingStartedState extends ProfileScreenState {}

class ProfileLoadingStoppedState extends ProfileScreenState {}

class ProfileEditState extends ProfileScreenState {
  bool isProfileEdit;
  ProfileEditState(this.isProfileEdit);
}

class ProfileUpdatedState extends ProfileScreenState {
  ProfileUpdateResponseModel responseModel;
  ProfileUpdatedState(this.responseModel);
}

class ProfileErrorState extends ProfileScreenState {
  AppException exception;
  ProfileErrorState(this.exception);
}
