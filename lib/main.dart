import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:tatsam/Navigation/route_generator.dart';
import 'package:tatsam/Navigation/routes_key.dart';
import 'package:tatsam/Utils/constants/strings.dart';

import 'Utils/log_utils/log_util.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp])
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
    return MaterialApp(
      title: Strings.appName,
      theme: ThemeData(
        fontFamily: Strings.fontFamily,
        brightness: Brightness.dark,
        scaffoldBackgroundColor: Colors.black,
      ),
      debugShowCheckedModeBanner: false,
      initialRoute: Routes.signupScreen,
      onGenerateRoute: RouteGenerator.generateRoute,
    );
  }
}
