import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tatsam/Screens/businessScreen/data/model/business_response_model.dart';
import 'package:tatsam/Screens/dashboard/bloc/bloc.dart';
import 'package:tatsam/Screens/dashboard/data/model/screen_enum.dart';

class DashboardBloc extends Bloc<DashboardEvent, DashboardState> {
  DashboardBloc()
      : super(DashboardLandingScreenState(AppScreens.profileScreen));

  AppScreens appScreens = AppScreens.profileScreen;
  String contactProfileSearchId = '';
  BusinessData editBusinessData = BusinessData();

  @override
  Stream<DashboardState> mapEventToState(DashboardEvent event) async* {
    if (event is DashboardLandingScreenEvent) {
      appScreens = event.appScreens!;
      yield DashboardLandingScreenState(appScreens);
    }
  }
}
