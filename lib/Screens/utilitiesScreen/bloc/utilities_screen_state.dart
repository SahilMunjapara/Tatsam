import 'package:tatsam/Screens/utilitiesScreen/data/model/utilities_response_model.dart';
import 'package:tatsam/service/exception/exception.dart';

abstract class UtilitiesScreenState {}

class UtilitiesInitialState extends UtilitiesScreenState {}

class UtilitiesLoadingStartState extends UtilitiesScreenState {}

class UtilitiesLoadingEndState extends UtilitiesScreenState {}

class UtilitiesSearchState extends UtilitiesScreenState {}

class UtilitiesListState extends UtilitiesScreenState {
  UtilitiesResponseModel responseModel;
  UtilitiesListState(this.responseModel);
}

class UtilitiesErrorState extends UtilitiesScreenState {
  AppException exception;
  UtilitiesErrorState(this.exception);
}
