import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tatsam/Screens/profileScreen/bloc/bloc.dart';
import 'package:tatsam/Screens/profileScreen/data/repository/profile_screen_repository.dart';
import 'package:tatsam/service/exception/exception.dart';
import 'package:tatsam/service/network/model/resource_model.dart';

class ProfileBloc extends Bloc<ProfileScreenEvent, ProfileScreenState> {
  ProfileScreenRepository profileScreenRepository = ProfileScreenRepository();
  ProfileBloc() : super(ProfileInitialState());

  @override
  Stream<ProfileScreenState> mapEventToState(ProfileScreenEvent event) async* {
    if (event is ProfileEditEvent) {
      yield ProfileEditState(event.isProfileEdit!);
    }
    if (event is ProfileupdatedEvent) {
      yield ProfileLoadingStartedState();
      Resource resource = await profileScreenRepository.updateProfile(event);
      if (resource.data != null) {
        yield ProfileUpdatedState(resource.data);
      } else {
        yield ProfileErrorState(
          AppException.decodeExceptionData(jsonString: resource.error ?? ''),
        );
      }
      yield ProfileLoadingStoppedState();
    }
  }
}
