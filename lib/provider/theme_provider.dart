// import 'package:flutter/material.dart';
// import 'package:flutter/scheduler.dart';
// import 'package:google_fonts/google_fonts.dart';

// import '../constants.dart';
// import '../theme.dart';

// class ThemeProvider extends ChangeNotifier {
//   ThemeMode themeMode = ThemeMode.system;

//   bool get isDarkMode {
//     if (themeMode == ThemeMode.system) {
//       final brightness = SchedulerBinding.instance.window.platformBrightness;
//       return brightness == Brightness.dark;
//     } else {
//       return themeMode == ThemeMode.dark;
//     }
//   }

//   void toggleTheme(bool isOn) {
//     themeMode = isOn ? ThemeMode.dark : ThemeMode.light;
//     notifyListeners();
//   }
// }

// class MyThemes {
//   static final darkTheme = ThemeData(
//     primaryColor: Colors.white,
//     scaffoldBackgroundColor: kContentColorLightTheme,
//     appBarTheme: appBarTheme,
//     iconTheme: IconThemeData(color: kContentColorDarkTheme),
//     textTheme:
//         GoogleFonts.interTextTheme().apply(bodyColor: kContentColorDarkTheme),
//     colorScheme: ColorScheme.dark().copyWith(
//       primary: kPrimaryColor,
//       secondary: kPrimaryLightColor,
//       error: kErrorColor,
//     ),
//     bottomNavigationBarTheme: BottomNavigationBarThemeData(
//       backgroundColor: kContentColorLightTheme,
//       selectedItemColor: Colors.white70,
//       unselectedItemColor: kContentColorDarkTheme.withOpacity(0.32),
//       selectedIconTheme: IconThemeData(color: Colors.white),
//       showUnselectedLabels: true,
//     ),
//   );

//   static final lightTheme = ThemeData(
//     primaryColor: kPrimaryColor,
//     scaffoldBackgroundColor: Colors.white,
//     appBarTheme: appBarTheme,
//     iconTheme: IconThemeData(color: kContentColorLightTheme),
//     textTheme:
//         GoogleFonts.interTextTheme().apply(bodyColor: kContentColorLightTheme),
//     colorScheme: ColorScheme.light(
//       primary: kPrimaryColor,
//       secondary: kPrimaryLightColor,
//       error: kErrorColor,
//     ),
//     bottomNavigationBarTheme: BottomNavigationBarThemeData(
//       backgroundColor: Colors.white,
//       selectedItemColor: kContentColorLightTheme.withOpacity(0.7),
//       selectedLabelStyle: TextStyle(fontWeight: FontWeight.bold, fontSize: 24),
//       unselectedItemColor: kContentColorLightTheme,
//       unselectedLabelStyle:
//           TextStyle(fontWeight: FontWeight.bold, fontSize: 24),
//       selectedIconTheme: IconThemeData(color: kPrimaryColor),
//       showUnselectedLabels: true,
//     ),
//   );
// }
