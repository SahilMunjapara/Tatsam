import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tatsam/Screens/businessFormScreen/bloc/bloc.dart';

class BusinessFormBloc
    extends Bloc<BusinessFormScreenEvent, BusinessFormScreenState> {
  BusinessFormBloc() : super(BusinessFormInitialState());

  @override
  Stream<BusinessFormScreenState> mapEventToState(
      BusinessFormScreenEvent event) async* {}
}
