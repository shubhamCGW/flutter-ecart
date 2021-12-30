import 'dart:convert';
import 'dart:ui';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_auth/Screens/Cart/cart.dart';
import 'package:flutter_auth/api/api.dart';
import 'package:flutter_auth/components/MainAppBar.dart';
import 'package:flutter_auth/components/itemCounterWidget.dart';
import 'package:flutter_auth/components/rounded_button.dart';

class ProductDetailsScreen extends StatefulWidget {
  final groceryItem;

  const ProductDetailsScreen(this.groceryItem);

  @override
  _ProductDetailsScreenState createState() => _ProductDetailsScreenState();
}

class _ProductDetailsScreenState extends State<ProductDetailsScreen> {
  int amount = 1;
  bool favorite = false;
  List products;

  showSnackbar(String msg) {
    var snackBar = new SnackBar(content: Text(msg));
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }

  addToWishList(int productId) async {
    var data = {'product_id': productId};

    var res = await CallApi().postDataWithHeader(data, 'addToWishListProduct');

    if (res.statusCode == 200) {
      var response = json.decode(res.body);
      if (response['status']) {
        print(response['response']);
        showSnackbar(response['message']);
      } else {
        showSnackbar(response['message']);
      }
    } else {
      print("Please try again!");
    }
  }

  addToCart(int productId, quantity) async {
    var data = {'product_id': productId, 'quantity': quantity};

    var res = await CallApi().postDataWithHeader(data, 'addToCart');

    if (res.statusCode == 200) {
      var response = json.decode(res.body);
      if (response['status']) {
        print(response['response']);
        showSnackbar(response['message']);
      } else {
        showSnackbar(response['message']);
      }
    } else {
      print("Please try again!");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MainAppBar(title:  "Product Detail's"),
      // appBar: AppBar(
      //   backgroundColor: Colors.indigo,
      //   elevation: 0.0,
      //   centerTitle: true,
      //   leading: GestureDetector(
      //     onTap: () {
      //       Navigator.pop(context);
      //     },
      //     child: Container(
      //       child: Icon(
      //         Icons.keyboard_arrow_left,
      //         color: Colors.white,
      //       ),
      //     ),
      //   ),
      //   title: Text(
      //     "Product Details",
      //     style: TextStyle(
      //         fontSize: 20, fontWeight: FontWeight.bold, color: Colors.white),
      //   ),
      //   actions: [
      //     IconButton(
      //         onPressed: () {
      //           Navigator.push(context,
      //               MaterialPageRoute(builder: (context) => SearchScreen()));
      //         },
      //         icon: Icon(Icons.search, color: Colors.white)),
      //     IconButton(
      //         onPressed: () {
      //           Navigator.push(context,
      //               MaterialPageRoute(builder: (context) => CartScreen()));
      //         },
      //         icon: Icon(Icons.shopping_cart, color: Colors.white)),
      //   ],
      // ),
      body: widget.groceryItem == null
          ? Center(child: CircularProgressIndicator())
          : SafeArea(
              child: SingleChildScrollView(
                child: Center(
                  child: Column(
                    children: [
                      getImageHeaderWidget(),
                      Container(
                        child: Column(
                          children: [
                            ListTile(
                              title: Text(
                                widget.groceryItem['name'],
                                // "",
                                style: TextStyle(
                                    fontSize: 18, fontWeight: FontWeight.bold),
                              ),
                              trailing: Padding(
                                padding: const EdgeInsets.only(
                                    bottom: 20.0, right: 45, left: 2),
                                child: InkWell(
                                  onTap: () {
                                    if (widget.groceryItem['favourite'] =
                                        true) {
                                      setState(() {
                                        addToWishList(widget.groceryItem['id']);
                                        favorite = !favorite;
                                      });
                                    }
                                  },
                                  child: Icon(
                                    favorite
                                        ? Icons.favorite
                                        : Icons.favorite_border,
                                    color: favorite
                                        ? Colors.indigo
                                        : Colors.blueGrey,
                                  ),
                                ),
                              ),
                              subtitle: Padding(
                                padding: EdgeInsets.only(top: 10),
                                child: Text(widget.groceryItem['sub_desc'],
                                    style: TextStyle(
                                        fontSize: 14,
                                        fontWeight: FontWeight.w600,
                                        color: Color(0xff7C7C7C))),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Row(
                                children: [
                                  ItemCounterWidget(
                                    onAmountChanged: (newAmount) {
                                      setState(() {
                                        amount = newAmount;
                                      });
                                    },
                                  ),
                                  Spacer(),
                                  Flexible(
                                    child: Text(
                                      "\Rs. ${getTotalPrice().toStringAsFixed(2)} /-",
                                      style: TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  )
                                ],
                              ),
                            ),
                            Row(
                              children: [
                                Center(
                                  child: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Container(
                                      width: MediaQuery.of(context).size.width *
                                          0.8,
                                      child: Center(
                                        child: Text(
                                          // "",
                                          widget.groceryItem['description'],
                                          style: TextStyle(
                                              color: Colors.black,
                                              fontWeight: FontWeight.normal),
                                        ),
                                      ),
                                    ),
                                  ),
                                )
                              ],
                            ),
                            RoundedButton(
                              text: "Add To Cart",
                              press: () {
                                addToCart(widget.groceryItem['id'],
                                    getProductQuantity());
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => CartScreen()),
                                );
                              },
                            )
                          ],
                        ),
                      )
                    ],
                  ),
                ),
              ),
            ),
    );
  }

  Widget getImageHeaderWidget() {
    return Container(
      height: 150,
      padding: EdgeInsets.symmetric(horizontal: 25, vertical: 25),
      width: double.maxFinite,
      decoration: BoxDecoration(
        // color:Color(0xffE2E2E2),
        borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(25),
          bottomRight: Radius.circular(25),
        ),
        // gradient: new LinearGradient(
        //     colors: [
        //       const Color(0xFF3366FF).withOpacity(0.1),
        //       const Color(0xFF3366FF).withOpacity(0.09),
        //     ],
        //     begin: const FractionalOffset(0.0, 0.0),
        //     end: const FractionalOffset(0.0, 1.0),
        //     stops: [0.0, 1.0],
        //     tileMode: TileMode.clamp),
      ),
      child: Image(
        image: NetworkImage(widget.groceryItem['image']),
      ),
    );
  }

  int getTotalPrice() {
    return amount * widget.groceryItem['price'];
  }

  int getProductQuantity() {
    return getTotalPrice() ~/ widget.groceryItem['price'];
  }
}
