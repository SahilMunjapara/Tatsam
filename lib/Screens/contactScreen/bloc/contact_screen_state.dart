import 'package:tatsam/Screens/contactScreen/data/model/user_response_model.dart';
import 'package:tatsam/service/exception/exception.dart';

abstract class ContactScreenState {}

class ContactInitialState extends ContactScreenState {}

class ContactLoadingStartState extends ContactScreenState {}

class ContactLoadingEndState extends ContactScreenState {}

class ContactSearchState extends ContactScreenState {}

class ContactListState extends ContactScreenState {
  List<UserResponseModel> responsemodel;
  ContactListState(this.responsemodel);
}

class ContactErrorState extends ContactScreenState {
  AppException exception;
  ContactErrorState(this.exception);
}
