import 'package:flutter/material.dart';
import 'package:flutter_auth/Screens/Cart/cart.dart';
import 'package:flutter_auth/components/customNavBar.dart';
import 'package:flutter_auth/screens/explore_screen.dart';

class AppBarScreen extends StatelessWidget {
  const AppBarScreen({ Key key }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          backgroundColor: Colors.indigo,
          elevation: 0.0,
          centerTitle: true,
          leading: GestureDetector(
            onTap: () {
              Navigator.push(
                context, MaterialPageRoute(builder: (context) => CustomBottonNavBar()));
            },
            child: Container(
              child: Icon(
                Icons.keyboard_arrow_left,
                color: Colors.white,
              ),
            ),
          ),
          title: Text("Account"),
          actions: [
            IconButton(
                onPressed: () {
                  Navigator.push(
                context, MaterialPageRoute(builder: (context) => SearchScreen()));
                },
                icon: Icon(Icons.search, color: Colors.white)),
            IconButton(
                onPressed: () {
                  Navigator.push(
                context, MaterialPageRoute(builder: (context) => CartScreen()));
                },
                icon: Icon(Icons.shopping_cart, color: Colors.white)),
          ],
        ),
    );
  }
}