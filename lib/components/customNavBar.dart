import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_auth/Screens/Account/accountScreen.dart';
import 'package:flutter_auth/Screens/Category/CategoryList.dart';
import 'package:flutter_auth/Screens/Dashboard/home_screen.dart';
import 'package:flutter_auth/Screens/explore_screen.dart';
import 'package:flutter_auth/Screens/favoriteScreen.dart';

class CustomBottonNavBar extends StatefulWidget {
  const CustomBottonNavBar({
    Key key,
  }) : super(key: key);

  @override
  State<CustomBottonNavBar> createState() => _CustomBottonNavBarState();
}

class _CustomBottonNavBarState extends State<CustomBottonNavBar> {
  @override
  Widget build(BuildContext context) {
    return CupertinoTabScaffold(
        tabBar: CupertinoTabBar(
          inactiveColor: Colors.black,
          items: [
            BottomNavigationBarItem(icon: Icon(Icons.home), label: "Home",),
            BottomNavigationBarItem(
                icon: Icon(Icons.explore), label: "Explore"),
            BottomNavigationBarItem(
                icon: Icon(Icons.favorite), label: "Favorite"),
            BottomNavigationBarItem(
                icon: CircleAvatar(
                  radius: 14,
                  backgroundImage: AssetImage("assets/images/profile_pic.png"),
                ),
                label: "Account"),
          ],
        ),
        tabBuilder: (BuildContext context, index) {
          switch (index) {
            case 0:
              return CupertinoTabView(
                builder: (context) {
                  return CupertinoPageScaffold(child: HomeScreen());
                },
              );
            case 1:
              return CupertinoTabView(
                builder: (context) {
                  return CupertinoPageScaffold(child: CategoryListScreen());
                },
              );
            case 2:
              return CupertinoTabView(
                builder: (context) {
                  return CupertinoPageScaffold(child: FavouriteScreen());
                },
              );
            case 3:
              return CupertinoTabView(
                builder: (context) {
                  return CupertinoPageScaffold(child: AccountScreen());
                },
              );
            case 4:
              return CupertinoTabView(
                builder: (context) {
                  return CupertinoPageScaffold(child: SearchScreen());
                },
              );
            default:
              return HomeScreen();
          }
        });
    // return Scaffold(
    //   body: Center(
    //       child: IndexedStack(
    //     index: _selectedIndex,
    //     children: _items,
    //   )),
      // bottomNavigationBar: BottomNavigationBar(
      //   type: BottomNavigationBarType.fixed,
      //   currentIndex: _selectedIndex,
      //   onTap: (value) {
      //     setState(() {
      //       _selectedIndex = value;
      //     });
      //   },
      //   items: [
      //     BottomNavigationBarItem(icon: Icon(Icons.home), label: "Home"),
      //     BottomNavigationBarItem(icon: Icon(Icons.explore), label: "Explore"),
      //     BottomNavigationBarItem(
      //         icon: Icon(Icons.favorite), label: "Favorite"),
      //     BottomNavigationBarItem(
      //         icon: CircleAvatar(
      //           radius: 14,
      //           backgroundImage: AssetImage("assets/images/profile_pic.png"),
      //         ),
      //         label: "Account"),
      //     //   BottomNavigationBarItem(icon: Icon(Icons.home), label: "Noti"),
      //   ],
      // ),
    // );
  }
}
