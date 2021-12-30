import 'dart:convert';

import 'package:badges/badges.dart';
import 'package:flutter/material.dart';
import 'package:flutter_auth/api/api.dart';
import '../constants.dart';
import 'Cart/cart.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({Key key}) : super(key: key);

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  bool isSearching = false;
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
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.indigo,
        elevation: 0.0,
        centerTitle: true,
        leading: GestureDetector(
          onTap: () {
            Navigator.pop(context);
            // Navigator.push(context,
            //     MaterialPageRoute(builder: (context) => CustomBottonNavBar()));
          },
          child: Container(
            child: Icon(
              Icons.arrow_back,
              color: Colors.white,
            ),
          ),
        ),
        title: Container(
          margin: EdgeInsets.symmetric(vertical: 10),
          padding: EdgeInsets.symmetric(horizontal: 20, vertical: 5),
          width: size.width * 0.8,
          height: 30,
          decoration: BoxDecoration(
            color: kPrimaryLightColor,
            borderRadius: BorderRadius.circular(0),
          ),
          child: TextField(
            cursorColor: Colors.indigo[200],
            decoration: InputDecoration(
              icon: Icon(
                Icons.search,
                color: Colors.indigo[200],
              ),
              hintText: "Search",
              border: InputBorder.none,
            ),
          ),
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
      ),
      // drawer: MainDrawer(),
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
