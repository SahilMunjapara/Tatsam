import 'package:tatsam/Screens/contactScreen/data/model/user_response_model.dart';
import 'package:tatsam/Screens/instantScreen/data/model/instant_delete_state_response.dart';
import 'package:tatsam/Screens/instantScreen/data/model/instant_response_model.dart';
import 'package:tatsam/service/exception/exception.dart';

abstract class InstantScreenState {}

class InstantInitialState extends InstantScreenState {}

class InstantLoadingStartState extends InstantScreenState {}

class InstantLoadingEndState extends InstantScreenState {}

class InstantSearchState extends InstantScreenState {
  bool isSearching;
  InstantSearchState(this.isSearching);
}

class InstantSelectSearchState extends InstantScreenState {
  bool isSelectSearching;
  InstantSelectSearchState(this.isSelectSearching);
}

class GetInstantState extends InstantScreenState {
  InstantResponseModel responseModel;
  GetInstantState(this.responseModel);
}

class InstantSearchCharState extends InstantScreenState {
  String searchChar;
  InstantSearchCharState(this.searchChar);
}

class InstantDeleteState extends InstantScreenState {
  InstantDeleteStateModel response;
  InstantDeleteState(this.response);
}

class GetAllContactState extends InstantScreenState {
  List<UserResponseModel> responseModel;
  GetAllContactState(this.responseModel);
}

class SelectedInstantUserState extends InstantScreenState {
  UserResponseModel responseModel;
  SelectedInstantUserState(this.responseModel);
}

class SelectedInstantRemoveState extends InstantScreenState {
  UserResponseModel responseModel;
  SelectedInstantRemoveState(this.responseModel);
}

class InstantErrorState extends InstantScreenState {
  AppException exception;
  InstantErrorState(this.exception);
}
