import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_auth/Models/User.dart';
import 'package:flutter_auth/Screens/Account/accountScreen.dart';
import 'package:flutter_auth/Screens/Cart/cart.dart';
import 'package:flutter_auth/Screens/Category/CategoryList.dart';
import 'package:flutter_auth/Screens/Dashboard/home_screen.dart';
import 'package:flutter_auth/Screens/Login/login_screen.dart';
import 'package:flutter_auth/Screens/favoriteScreen.dart';
import 'package:flutter_auth/api/api.dart';
import 'package:shared_preferences/shared_preferences.dart';

class MainDrawer extends StatefulWidget {
  const MainDrawer({Key key}) : super(key: key);

  @override
  _MainDrawerState createState() => _MainDrawerState();
}

class _MainDrawerState extends State<MainDrawer> {
  bool isLoading = false;
  Future<User> authUser;

  @override
  void initState() {
    super.initState();
    authUser = getUser();
    // print(authUser);
  }

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        children: [
          UserAccountsDrawerHeader(
            accountName: FutureBuilder(
                future: authUser,
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    return Text(snapshot.data.name);
                  } else if (snapshot.hasError) {
                    return Text('${snapshot.error}');
                  }
                  // By default, show a loading spinner.
                  return const CircularProgressIndicator();
                }),
            accountEmail: FutureBuilder(
                future: authUser,
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    return Text(snapshot.data.email);
                  } else if (snapshot.hasError) {
                    return Text('${snapshot.error}');
                  }
                  // By default, show a loading spinner.
                  return const CircularProgressIndicator();
                }),
            currentAccountPicture: GestureDetector(
              child: FutureBuilder(
                  future: authUser,
                  builder: (context, snapshot) {
                    if (snapshot.hasData) {
                      return CircleAvatar(
                        // backgroundColor: Colors.grey,
                        backgroundImage: snapshot.data.image == null ? AssetImage('assets/images/profile_pic.png'):
                            NetworkImage(snapshot.data.image),
                      );
                    } else if (snapshot.hasError) {
                      return Text('${snapshot.error}');
                    }
                    // By default, show a loading spinner.
                    return const CircularProgressIndicator();
                  }),
            ),
            decoration: new BoxDecoration(color: Colors.indigo),
          ),
          InkWell(
            onTap: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => HomeScreen()));
            },
            child: ListTile(
              title: Text(
                'Home Page',
                style: TextStyle(color: Colors.indigo),
              ),
              leading: Icon(Icons.home, color: Colors.indigo),
            ),
          ),
          InkWell(
            onTap: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => AccountScreen()));
            },
            child: ListTile(
              title: Text('My account', style: TextStyle(color: Colors.indigo)),
              leading: Icon(Icons.person, color: Colors.indigo),
            ),
          ),
          InkWell(
            onTap: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => CartScreen()));
            },
            child: ListTile(
              title: Text('My Orders', style: TextStyle(color: Colors.indigo)),
              leading: Icon(Icons.shopping_basket, color: Colors.indigo),
            ),
          ),
          InkWell(
            onTap: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => CategoryListScreen()));
            },
            child: ListTile(
              title: Text('Categoreis', style: TextStyle(color: Colors.indigo)),
              leading: Icon(Icons.dashboard, color: Colors.indigo),
            ),
          ),
          InkWell(
            onTap: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => FavouriteScreen()));
            },
            child: ListTile(
              title: Text('Favourites', style: TextStyle(color: Colors.indigo)),
              leading: Icon(Icons.favorite, color: Colors.indigo),
            ),
          ),
          InkWell(
            onTap: () {
              logout();
            },
            child: ListTile(
              title: Text('Log out', style: TextStyle(color: Colors.indigo)),
              leading: Icon(
                Icons.logout,
                color: Colors.indigo,
              ),
            ),
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
    var usrProfile = json.decode(preferences.getString("userProfile"));

    var res = await CallApi().authPostData(usrProfile['token'], 'logout');

    if (res.statusCode == 200) {
      Map<String, dynamic> response = json.decode(res.body);
      if (response['status']) {
        savePref();
        Navigator.of(context).pushAndRemoveUntil(
            MaterialPageRoute(builder: (context) => LoginScreen()),
            (Route<dynamic> route) => false);
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

  Future<User> getUser() async {
    Map<String, dynamic> res = await CallApi().getUserProfile();
    return User.fromJson(res);
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
