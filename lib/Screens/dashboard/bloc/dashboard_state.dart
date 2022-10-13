import 'package:tatsam/Screens/dashboard/data/model/screen_enum.dart';

abstract class DashboardState {}

class DashboardInitState extends DashboardState {}

class DashboardLandingScreenState extends DashboardState {
  AppScreens appScreens;
  DashboardLandingScreenState(this.appScreens);
}
