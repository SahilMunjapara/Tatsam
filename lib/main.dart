import 'dart:async';

import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tatsam/Navigation/route_generator.dart';
import 'package:tatsam/Navigation/routes_key.dart';
import 'package:tatsam/Screens/dashboard/bloc/bloc.dart';
import 'package:tatsam/Utils/app_preferences/app_preferences.dart';
import 'package:tatsam/Utils/app_preferences/prefrences_key.dart';
import 'package:tatsam/Utils/constants/strings.dart';

import 'Utils/log_utils/log_util.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await AppPreference().initialAppPreference();
  await Firebase.initializeApp();
  await SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp])
      .then((_) async {
    runZonedGuarded(() {
      runApp(const Application());
    }, (error, stackTrace) {
      LogUtils.showErrorLogs(
        error: error.toString(),
        message: stackTrace.toString(),
        tag: 'RUN APP ERROR',
      );
    });
  });
}

class Application extends StatelessWidget {
  const Application({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<DashboardBloc>(
          create: (BuildContext context) => DashboardBloc(),
        ),
      ],
      child: MaterialApp(
        title: Strings.appName,
        theme: ThemeData(
          fontFamily: Strings.fontFamily,
          brightness: Brightness.dark,
          scaffoldBackgroundColor: Colors.black,
        ),
        debugShowCheckedModeBanner: false,
        initialRoute:
            AppPreference().getBoolData(PreferencesKey.isLogin) ?? false
                ? Routes.dashboardScreen
                : Routes.loginScreen,
        onGenerateRoute: RouteGenerator.generateRoute,
      ),
    );
  }
}
