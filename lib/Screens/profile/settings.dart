import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_auth/Screens/Account/components/profile_menu.dart';
import 'package:flutter_auth/Screens/Address/MyAddresses.dart';
import 'package:flutter_auth/Screens/cards/SavedCard.dart';
import 'package:flutter_auth/Screens/profile/ChangePassword.dart';
import 'package:flutter_auth/Screens/profile/Menu.dart';
import 'package:flutter_auth/constants.dart';

class SettingsPage extends StatefulWidget {
  @override
  _SettingsPageState createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  @override
  Widget build(BuildContext context) {
    //  final text = Provider.of<ThemeProvider>(context).themeMode == ThemeMode.dark
    //     ? 'DarkTheme'
    //     : 'LightTheme';
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.indigo,
        elevation: 0.0,
        centerTitle: true,
        leading: GestureDetector(
          onTap: () {
            Navigator.pop(context);
          },
          child: Container(
            child: Icon(
              Icons.keyboard_arrow_left,
              color: Colors.white,
            ),
          ),
        ),
        title: Text(
          "Settings",
          style: TextStyle(
              fontSize: 20, fontWeight: FontWeight.bold, color: Colors.white),
        ),
        // actions: [
        //   IconButton(
        //       onPressed: () {
        //         Navigator.push(context,
        //             MaterialPageRoute(builder: (context) => SearchScreen()));
        //       },
        //       icon: Icon(Icons.search, color: Colors.white)),
        //   IconButton(
        //       onPressed: () {
        //         Navigator.push(context,
        //             MaterialPageRoute(builder: (context) => CartScreen()));
        //       },
        //       icon: Icon(Icons.shopping_cart, color: Colors.white)),
        // ],
      ),
      body: Container(
        padding: EdgeInsets.only(left: 16, top: 25, right: 16),
        child: ListView(
          children: [
            Row(
              children: [
                Icon(
                  Icons.person,
                  color: Colors.indigo,
                ),
                SizedBox(
                  width: 8,
                ),
                Text(
                  "Account",
                  style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: kPrimaryColor),
                ),
              ],
            ),
            Divider(
              height: 15,
              thickness: 2,
            ),
            ProfileMenu(
                text: "Change Password",
                icon: "assets/icons/ChangePassword.svg",
                press: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => ChangePswdScreen()));
                }),
            ProfileMenu(
                text: "MY Address",
                icon: "assets/icons/Location.svg",
                press: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => MyAddresses()));
                }),
            ProfileMenu(
                text: "Language",
                icon: "assets/icons/Language.svg",
                press: () {
                  // Navigator.push(
                  //     context, MaterialPageRoute(builder: (context) => null));
                }),
            ProfileMenu(
                text: "Saved Cards",
                icon: "assets/icons/CreditCard.svg",
                press: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => SavedCards()));
                }),
            Menu(
              hasNavigation: false,
              text: "Deactivate Account",
              press: () {},
            ),
            // Row(
            //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
            //   children: [
            //     Text(
            //       "Dark Mode",
            //       style: TextStyle(
            //           fontSize: 16,
            //           fontWeight: FontWeight.bold,
            //           color: kPrimaryColor),
            //     ),
            //     ChangeThemeButtonWidget(),
            //   ],
            // ),
            SizedBox(
              height: 10,
            ),
            Row(
              children: [
                Icon(
                  Icons.volume_up_outlined,
                  color: Colors.indigo,
                ),
                SizedBox(
                  width: 8,
                ),
                Text(
                  "Notifications",
                  style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: kPrimaryColor),
                ),
              ],
            ),
            Divider(
              height: 15,
              thickness: 2,
            ),
            // SizedBox(
            //   height: 10,
            // ),
            buildNotificationOptionRow("New for you", true),
            // buildNotificationOptionRow("Account activity", true),
            // buildNotificationOptionRow("Opportunity", false),
            SizedBox(
              height: 10,
            ),
          ],
        ),
      ),
    );
  }

  Row buildNotificationOptionRow(String title, bool isActive) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          title,
          style: TextStyle(
              fontSize: 12, fontWeight: FontWeight.w500, color: kPrimaryColor),
        ),
        Transform.scale(
            scale: 0.7,
            child: CupertinoSwitch(
              value: isActive,
              activeColor: Colors.indigo,
              onChanged: (bool val) {},
            ))
      ],
    );
  }
}
