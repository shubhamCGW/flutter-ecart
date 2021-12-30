import 'package:flutter/material.dart';
import 'package:flutter_auth/Screens/Dashboard/home_screen.dart';
import 'package:flutter_auth/Screens/Login/login_screen.dart';
import 'package:flutter_auth/Screens/Products/seeAll.dart';
import 'package:flutter_auth/Screens/ResetPassword/ResetPassword.dart';
import 'package:flutter_auth/Screens/Signup/signup_screen.dart';
import 'package:flutter_auth/Screens/SplashScreen/splash_screen.dart';
import 'package:flutter_auth/Screens/VerifyOtp/verifyOtp.dart';
import 'package:flutter_auth/theme.dart';

import 'route_generator.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'E-cart',
      theme: lightThemeData(context),
      darkTheme: darkThemeData(context),
      home: SplashScreen(),
      initialRoute: '/',
      onGenerateRoute: RouteGenerator.generateRoute,
      routes: <String, WidgetBuilder>{
        '/splashScreen': (BuildContext context) => new SplashScreen(),
        '/signup': (BuildContext context) => new SignUpScreen(),
        '/login': (BuildContext context) => new LoginScreen(),
        '/home': (BuildContext context) => new HomeScreen(),
        '/resetPasswordScreen': (BuildContext context) =>
            new ResetPasswordScreen(),
        '/verifyOtp': (BuildContext context) => new VerifyOtpScreen(),
        'seeAll': (BuildContext context) => SeeAllProdList(),
      },
    );
  }
}

