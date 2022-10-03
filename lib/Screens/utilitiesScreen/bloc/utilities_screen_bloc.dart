import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tatsam/Screens/utilitiesScreen/bloc/bloc.dart';

class UtilitiesBloc extends Bloc<UtilitiesScreenEvent, UtilitiesScreenState> {
  UtilitiesBloc() : super(UtilitiesInitialState());

  @override
  Stream<UtilitiesScreenState> mapEventToState(
      UtilitiesScreenEvent event) async* {
    if (event is UtilitiesSearchEvent) {
      yield UtilitiesSearchState();
    }
  }
}
