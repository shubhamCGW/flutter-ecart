import 'package:flutter/material.dart';
import 'package:flutter_auth/Screens/Account/accountScreen.dart';
import 'package:flutter_auth/Screens/Cart/cart.dart';
import 'package:flutter_auth/Screens/Category/CategoryList.dart';
import 'package:flutter_auth/screens/Dashboard/home_screen.dart';

// import '../favourite_screen.dart';

class NavigatorItem {
  final String label;
  final String iconPath;
  final int index;
  final Widget screen;

  NavigatorItem(this.label, this.iconPath, this.index, this.screen);
}

List<NavigatorItem> navigatorItems = [
  NavigatorItem("Shop", "assets/icons/shop_icon.svg", 0, HomeScreen()),
  NavigatorItem("Explore", "assets/icons/explore_icon.svg", 1, CategoryListScreen()),
  NavigatorItem("Cart", "assets/icons/cart_icon.svg", 2, CartScreen()),
  NavigatorItem("Account", "assets/icons/account_icon.svg", 3, AccountScreen()),
  // NavigatorItem(
  //     "Favourite", "assets/icons/favourite_icon.svg", 3, FavouriteScreen()),
  
];
