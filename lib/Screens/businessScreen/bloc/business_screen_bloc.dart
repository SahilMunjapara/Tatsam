import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tatsam/Screens/businessScreen/bloc/bloc.dart';

class BusinessBloc extends Bloc<BusinessScreenEvent, BusinessScreenState> {
  BusinessBloc() : super(BusinessInitialState());

  @override
  Stream<BusinessScreenState> mapEventToState(
      BusinessScreenEvent event) async* {
    if (event is BusinessSearchEvent) {
      yield BusinessSearchState();
    }
  }
}
