import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tatsam/Screens/contactScreen/bloc/bloc.dart';
import 'package:tatsam/Screens/contactScreen/data/repository/contact_screen_repository.dart';
import 'package:tatsam/service/exception/exception.dart';
import 'package:tatsam/service/network/model/resource_model.dart';

class ContactBloc extends Bloc<ContactScreenEvent, ContactScreenState> {
  ContactBloc() : super(ContactInitialState());

  final ContactScreenRepository _contactScreenRepository =
      ContactScreenRepository();

  @override
  Stream<ContactScreenState> mapEventToState(ContactScreenEvent event) async* {
    if (event is ContactSearchEvent) {
      yield ContactSearchState();
    }
    if (event is ContactListEvent) {
      yield ContactLoadingStartState();
      Resource resource = await _contactScreenRepository.getContactList(event);
      if (resource.data != null) {
        yield ContactListState(resource.data);
      } else {
        yield ContactErrorState(
            AppException.decodeExceptionData(jsonString: resource.error ?? ''));
      }
      yield ContactLoadingEndState();
    }
    if (event is ContactWithCharSearchEvent) {
      yield ContactLoadingStartState();
      yield ContactWithCharSearchState(event.searchChar!);
      yield ContactLoadingEndState();
    }
  }
}
