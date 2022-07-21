import 'package:flutter/material.dart';
import 'package:tatsam/Navigation/routes_key.dart';
import 'package:tatsam/Screens/dashboard/presentation/dashboard.dart';
import 'package:tatsam/Screens/loginScreen/presentation/login_screen.dart';
import 'package:tatsam/Screens/otpScreen/presentation/otp_screen.dart';
import 'package:tatsam/Screens/profileScreen/presentation/profile_screen.dart';
import 'package:tatsam/Screens/signupScreen/presentation/signup_screen.dart';

class RouteGenerator {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    final args = settings.arguments;

    switch (settings.name) {
      case Routes.loginScreen:
        return MaterialPageRoute(builder: (context) => const LoginScreen());
      case Routes.signupScreen:
        return MaterialPageRoute(builder: (context) => const SignupScreen());
      case Routes.otpScreen:
        return MaterialPageRoute(builder: (context) => const OtpScreen());
      case Routes.dashboardScreen:
        return MaterialPageRoute(builder: (context) => const DashBoardScreen());
      case Routes.profileScreen:
        return MaterialPageRoute(builder: (context) => const ProfileScreen());
      default:
        return _errorRoute();
    }
  }

  static Route<dynamic> _errorRoute() {
    return MaterialPageRoute(
      builder: (context) {
        return Scaffold(
          appBar: AppBar(
            title: const Text("Error"),
          ),
          body: const Center(
            child: Text("Page not found!"),
          ),
        );
      },
    );
  }
}
