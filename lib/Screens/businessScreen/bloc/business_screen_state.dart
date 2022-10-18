import 'package:tatsam/Screens/businessScreen/data/model/business_response_model.dart';
import 'package:tatsam/service/exception/exception.dart';

abstract class BusinessScreenState {}

class BusinessInitialState extends BusinessScreenState {}

class BusinessSearchState extends BusinessScreenState {}

class BusinessLoadingStartState extends BusinessScreenState {}

class BusinessLoadingEndState extends BusinessScreenState {}

class GetBusinessState extends BusinessScreenState {
  BusinessResponseModel responseModel;
  GetBusinessState(this.responseModel);
}

class BusinessSearchCharState extends BusinessScreenState {
  String searchChar;
  BusinessSearchCharState(this.searchChar);
}

class BusinessErrorState extends BusinessScreenState {
  AppException exception;
  BusinessErrorState(this.exception);
}
