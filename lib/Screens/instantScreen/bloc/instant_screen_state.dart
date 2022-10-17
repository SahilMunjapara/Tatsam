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

class InstantErrorState extends InstantScreenState {
  AppException exception;
  InstantErrorState(this.exception);
}
