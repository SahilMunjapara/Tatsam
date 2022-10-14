import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tatsam/Screens/instantScreen/bloc/bloc.dart';

class InstantBloc extends Bloc<InstantScreenEvent, InstantScreenState> {
  InstantBloc() : super(InstantInitialState());

  @override
  Stream<InstantScreenState> mapEventToState(InstantScreenEvent event) async* {
    if (event is InstantSearchEvent) {
      yield InstantSearchState();
    }
  }
}