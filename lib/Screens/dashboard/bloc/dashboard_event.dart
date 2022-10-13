import 'package:equatable/equatable.dart';
import 'package:tatsam/Screens/dashboard/data/model/screen_enum.dart';

abstract class DashboardEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

class DashboardLandingScreenEvent extends DashboardEvent {
  final AppScreens? appScreens;
  DashboardLandingScreenEvent({this.appScreens});
}
