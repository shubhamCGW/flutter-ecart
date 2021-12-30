// import 'package:flutter_secure_storage/flutter_secure_storage.dart';
// import 'package:shared_preferences/shared_preferences.dart';

// // ...

// final prefs = await SharedPreferences.getInstance();

// if (prefs.getBool('first_run') ?? true) {
//   FlutterSecureStorage storage = FlutterSecureStorage();

//   await storage.deleteAll();

//   prefs.setBool('first_run', false);
// }