import 'package:flutter/material.dart';
import 'package:tatsam/Navigation/routes_key.dart';
import 'package:tatsam/Screens/dashboard/presentation/dashboard.dart';
import 'package:tatsam/Screens/loginScreen/presentation/login_screen.dart';
import 'package:tatsam/Screens/otpScreen/data/model/otp_screen_param.dart';
import 'package:tatsam/Screens/otpScreen/presentation/otp_screen.dart';
import 'package:tatsam/Screens/profileScreen/presentation/profile_screen.dart';
import 'package:tatsam/Screens/signupScreen/presentation/signup_screen.dart';

class RouteGenerator {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    final args = settings.arguments;

    switch (settings.name) {
      case Routes.loginScreen:
        return _animatedNavigation(const LoginScreen(), isFromLeft: true);
        // return MaterialPageRoute(builder: (context) => const LoginScreen());
      case Routes.signupScreen:
        return _animatedNavigation(const SignupScreen());
        // return MaterialPageRoute(builder: (context) => const SignupScreen());
      case Routes.otpScreen:
        return _animatedNavigation(
            OtpScreen(otpScreenParam: args as OtpScreenParam));
        // return MaterialPageRoute(
        //   builder: (context) => OtpScreen(
        //     otpScreenParam: args as OtpScreenParam,
        //   ),
        // );
      case Routes.dashboardScreen:
        return _animatedNavigation(const DashBoardScreen());
        // return MaterialPageRoute(builder: (context) => const DashBoardScreen());
      case Routes.profileScreen:
        return _animatedNavigation(const ProfileScreen());
        // return MaterialPageRoute(builder: (context) => const ProfileScreen());
      default:
        return _errorRoute();
    }
  }

  static Route<dynamic> _animatedNavigation(Widget page,
      {bool isFromLeft = false}) {
    return PageRouteBuilder(
      transitionDuration: const Duration(milliseconds: 600),
      transitionsBuilder: (context, animation, secondaryAnimation, child) {
        Offset begin =
            isFromLeft ? const Offset(-1.0, 0.0) : const Offset(1.0, 0.0);
        const end = Offset.zero;
        const curve = Curves.ease;
        var tween = Tween(begin: begin, end: end).chain(
          CurveTween(curve: curve),
        );
        return SlideTransition(
          position: animation.drive(tween),
          child: child,
        );
      },
      pageBuilder: (BuildContext context, Animation<double> animation,
          Animation<double> secondaryAnimation) {
        return page;
      },
    );
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
