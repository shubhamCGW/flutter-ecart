import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_auth/Screens/Cart/cart.dart';
import 'package:flutter_auth/Screens/explore_screen.dart';
import 'package:badges/badges.dart';
import 'package:flutter_auth/api/api.dart';

class MainAppBar extends StatefulWidget implements PreferredSizeWidget {
  final String title;
  const MainAppBar({Key key, @required this.title}) : super(key: key);

  @override
  _MainAppBarState createState() => _MainAppBarState();

  @override
  Size get preferredSize => new Size.fromHeight(60);
}

class _MainAppBarState extends State<MainAppBar> {
  List myCart;

  showSnackbar(String msg) {
    var snackBar = new SnackBar(content: Text(msg));
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }

  getCartList() async {
    // var data = {'product_id': productId};

    var res = await CallApi().getDataWithHeader('getCartList');

    if (res.statusCode == 200) {
      var response = json.decode(res.body);
      if (response['status']) {
        // print(response['response']);
        setState(() {
          myCart = response['response'];
        });
        // showSnackbar(response['message']);
      } else {
        print(response['response']);
      }
    } else {
      print("Please try again!");
    }
  }

  @override
  void initState() {
    super.initState();
    getCartList();
  }

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: Colors.indigo,
      elevation: 0.0,
      // centerTitle: true,
      automaticallyImplyLeading: false,
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
        widget.title,
        style: TextStyle(fontSize: 20, color: Colors.white),
      ),
      actions: [
        IconButton(
            onPressed: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => SearchScreen()));
            },
            icon: Icon(Icons.search, color: Colors.white)),
        _shoppingCartBadge()
      ],
    );
  }

  Widget _shoppingCartBadge() {
    return Badge(
      position: BadgePosition.topEnd(top: 0, end: 3),
      badgeContent: myCart == null
          ? Text(
              "0",
              style: TextStyle(color: Colors.white),
            )
          : Text(
              myCart.length.toString(),
              style: TextStyle(color: Colors.white),
            ),
      child: IconButton(
          icon: Icon(Icons.shopping_cart, color: Colors.white),
          onPressed: () {
            Navigator.push(
                context, MaterialPageRoute(builder: (context) => CartScreen()));
          }),
    );
  }
}
