import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tatsam/Screens/instantScreen/bloc/bloc.dart';
import 'package:tatsam/Screens/instantScreen/data/model/instant_delete_state_response.dart';
import 'package:tatsam/Screens/instantScreen/data/repository/instant_repository.dart';
import 'package:tatsam/service/exception/exception.dart';
import 'package:tatsam/service/network/model/resource_model.dart';

class InstantBloc extends Bloc<InstantScreenEvent, InstantScreenState> {
  InstantBloc() : super(InstantInitialState());
  final InstantRepository _instantRepository = InstantRepository();

  @override
  Stream<InstantScreenState> mapEventToState(InstantScreenEvent event) async* {
    if (event is InstantSearchEvent) {
      yield InstantSelectSearchState(false);
      yield InstantSearchState(event.isSearching!);
    }

    if (event is InstantSelectSearchEvent) {
      yield InstantSearchState(false);
      yield InstantSelectSearchState(event.isSelectSearching!);
    }

    if (event is InstantSearchCharEvent) {
      yield InstantSearchCharState(event.searchChar!);
    }

    if (event is GetAllContactEvent) {
      yield InstantLoadingStartState();
      Resource resource = await _instantRepository.getAllContact(event);
      if (resource.data != null) {
        yield GetAllContactState(resource.data);
      } else {
        yield InstantErrorState(
          AppException.decodeExceptionData(jsonString: resource.error ?? ''),
        );
      }
      yield InstantLoadingEndState();
    }

    if (event is InstantDeleteEvent) {
      yield InstantLoadingStartState();
      Resource resource = await _instantRepository.deleteInstant(event);
      if (resource.data != null) {
        yield InstantDeleteState(
          InstantDeleteStateModel(
              responseModel: resource.data, userId: event.instantId),
        );
      } else {
        yield InstantErrorState(
          AppException.decodeExceptionData(jsonString: resource.error ?? ''),
        );
      }
      yield InstantLoadingEndState();
    }

    if (event is SelectedInstantUserEvent) {
      yield SelectedInstantUserState(event.userResponseModel);
    }

    if (event is SelectedInstantRemoveEvent) {
      yield SelectedInstantRemoveState(event.userResponseModel);
    }

    if (event is GetInstantEvent) {
      yield InstantLoadingStartState();
      Resource resource = await _instantRepository.getInstantList(event);
      if (resource.data != null) {
        yield GetInstantState(resource.data);
      } else {
        yield InstantErrorState(
          AppException.decodeExceptionData(jsonString: resource.error ?? ''),
        );
      }
      yield InstantLoadingEndState();
    }

    if (event is InstantAddEvent) {
      yield InstantLoadingStartState();
      Resource resource = await _instantRepository.instantAdd(event);
      if (resource.data != null) {
        yield InstantAddState(resource.data);
      } else {
        yield InstantErrorState(
          AppException.decodeExceptionData(jsonString: resource.error ?? ''),
        );
      }
      yield InstantLoadingEndState();
    }
  }
}
