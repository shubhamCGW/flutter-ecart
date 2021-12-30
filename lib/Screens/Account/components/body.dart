import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_auth/Screens/Account/components/profile_image.dart';
import 'package:flutter_auth/Screens/Login/login_screen.dart';
import 'package:flutter_auth/Screens/profile/EditProfile.dart';
import 'package:flutter_auth/Screens/profile/settings.dart';
import 'package:flutter_auth/api/api.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'profile_menu.dart';

class Body extends StatefulWidget {
  @override
  State<Body> createState() => _BodyState();
}

class _BodyState extends State<Body> {
  bool isLoading = false;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: EdgeInsets.symmetric(vertical: 20),
      child: Column(
        children: [
          ProfilePic(),
          SizedBox(height: 2),
          ProfileMenu(
            text: "My Account",
            icon: "assets/icons/account_icon.svg",
            press: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => EditProfileSreen()));
            },
          ),
          ProfileMenu(
            text: "Notifications",
            icon: "assets/icons/account_icons/notification_icon.svg",
            press: () {},
          ),
          ProfileMenu(
            text: "Settings",
            icon: "assets/icons/Settings.svg",
            press: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => SettingsPage()));
            },
          ),
          ProfileMenu(
            text: "Help Center",
            icon: "assets/icons/account_icons/help_icon.svg",
            press: () {},
          ),
          ProfileMenu(
            text: "Log Out",
            icon: "assets/icons/logout.svg",
            press: isLoading ? null : logout,
          ),
        ],
      ),
    );
  }

  void logout() async {
    setState(() {
      isLoading = true;
      showLoaderDialog(context);
    });

    SharedPreferences preferences = await SharedPreferences.getInstance();
    var uProfile = json.decode(preferences.getString("userProfile"));

    var res = await CallApi().authPostData(uProfile['token'], 'logout');
    if (res.statusCode == 200) {
      Map<String, dynamic> response = json.decode(res.body);
      if (response['status']) {
        savePref();
        Navigator.of(context).pushReplacement(
            new MaterialPageRoute(builder: (context) => LoginScreen()));
      } else {
        print(" ${response['error']}");
      }
    } else {
      print("Please try again!");
    }
     setState(() {
      isLoading = false;
    });
  }

  savePref() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    preferences.getString("userProfile");
    preferences.clear();
  }

  showLoaderDialog(BuildContext context) {
    AlertDialog alert = AlertDialog(
      content: new Row(
        children: [
          CircularProgressIndicator(),
          Container(
              margin: EdgeInsets.only(left: 7), child: Text("Loading...")),
        ],
      ),
    );
    showDialog(
      barrierDismissible: false,
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }
}
