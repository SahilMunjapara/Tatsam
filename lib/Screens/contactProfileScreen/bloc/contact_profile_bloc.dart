import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tatsam/Screens/contactProfileScreen/bloc/bloc.dart';
import 'package:tatsam/Screens/contactProfileScreen/data/repository/contact_profile_repository.dart';
import 'package:tatsam/service/exception/exception.dart';
import 'package:tatsam/service/network/model/resource_model.dart';

class ContactProfileBloc
    extends Bloc<ContactProfileEvent, ContactProfileState> {
  ContactProfileBloc() : super(ContactProfileInitialState());

  final ContactProfileRepository _contactProfileRepository =
      ContactProfileRepository();

  @override
  Stream<ContactProfileState> mapEventToState(
      ContactProfileEvent event) async* {
    if (event is GetContactProfileEvent) {
      yield ContactProfileLoadingStartState();
      Resource resource =
          await _contactProfileRepository.getContactProfile(event);
      if (resource.data != null) {
        yield GetContactProfileState(resource.data);
      } else {
        yield ContactProfileErrorState(
            AppException.decodeExceptionData(jsonString: resource.error ?? ''));
      }
      yield ContactProfileLoadingEndState();
    }
  }
}
