import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tatsam/Screens/contactScreen/bloc/bloc.dart';

class ContactBloc extends Bloc<ContactScreenEvent, ContactScreenState> {
  ContactBloc() : super(ContactInitialState());

  @override
  Stream<ContactScreenState> mapEventToState(ContactScreenEvent event) async* {
    if (event is ContactSearchEvent) {
      yield ContactSearchState();
    }
  }
}
