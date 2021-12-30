import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_auth/api/api.dart';
import 'package:flutter_auth/components/Drawer.dart';

import 'Products/productDetail.dart';

class FavouriteScreen extends StatefulWidget {
  @override
  State<FavouriteScreen> createState() => _FavouriteScreenState();
}

class _FavouriteScreenState extends State<FavouriteScreen> {
  List myWishlist;
  final double width = 174;
  final double height = 200;
  final Color borderColor = Color(0xffE2E2E2);
  final double borderRadius = 18;

  showSnackbar(String msg) {
    var snackBar = new SnackBar(content: Text(msg));
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }

  getWishList() async {
    // var data = {'product_id': productId};

    var res = await CallApi().getDataWithHeader('getUserWishList');

    if (res.statusCode == 200) {
      var response = json.decode(res.body);
      if (response['status']) {
        // print(response['response']);
        setState(() {
          myWishlist = response['response'];
        });
      } else {
        print(response['response']);
      }
    } else {
      print("Please try again!");
    }
  }

  removeFromWishList(int productId) async {
    var data = {
      'product_id': productId,
    };

    var res = await CallApi().postDataWithHeader(data, 'removeFromWishList');

    if (res.statusCode == 200) {
      var response = json.decode(res.body);
      if (response['status']) {
        // print(response['response']);
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
        // print(response['response']);
        showSnackbar(response['message']);
      } else {
        showSnackbar(response['message']);
      }
    } else {
      print("Please try again!");
    }
  }

  getProductDetails(int productId) async {
    var data = {
      'product_id': productId,
    };

    var response =
        await CallApi().postDataWithHeader(data, 'getProductDetails');
    // print(response);
    if (response.statusCode == 200) {
      var res = json.decode(response.body.toString());
      if (res['status']) {
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => ProductDetailsScreen(res['response'])));
      } else {
        print(" ${response['error']}");
      }
    } else {
      print("Please try again!");
    }
  }

  @override
  void initState() {
    super.initState();
    getWishList();
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
            },
            child: Container(
              child: Icon(
                Icons.keyboard_arrow_left,
                color: Colors.white,
              ),
            ),
          ),
          title: Text(
            "My Wishlist",
            style: TextStyle(
                fontSize: 20, fontWeight: FontWeight.bold, color: Colors.white),
          )),
      body: myWishlist == null
          ? Center(child: CircularProgressIndicator())
          : SafeArea(
              child: SingleChildScrollView(
                // scrollDirection: Axis.vertical,
                child: Center(
                    child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Container(
                          margin: EdgeInsets.symmetric(vertical: 10),
                          height: size.height * (0.8),
                          child: GridView.builder(
                            gridDelegate:
                                SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 2,
                              mainAxisSpacing: 5,
                              crossAxisSpacing: 2,
                              childAspectRatio: 0.90,
                            ),
                            padding: EdgeInsets.symmetric(vertical: 10),
                            itemCount: myWishlist.length,
                            scrollDirection: Axis.vertical,
                            itemBuilder: (context, int index) {
                              final prod = myWishlist[index];
                              // print(prod.toString());
                              return GestureDetector(
                                onTap: () {
                                  prod['product_id'] == null
                                      ? Center(
                                          child: CircularProgressIndicator())
                                      : getProductDetails(prod['product_id']);
                                },
                                child: Container(
                                  width: width,
                                  height: height,
                                  decoration: BoxDecoration(
                                    border: Border.all(
                                      color: borderColor,
                                    ),
                                    borderRadius: BorderRadius.circular(
                                      borderRadius,
                                    ),
                                  ),
                                  child: Padding(
                                    padding: const EdgeInsets.symmetric(
                                      horizontal: 15,
                                      vertical: 15,
                                    ),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Expanded(
                                          child: Center(
                                            child: Container(
                                              child: Image.network(
                                                  prod['image']),
                                            ),
                                          ),
                                        ),
                                        SizedBox(
                                          height: 3,
                                        ),
                                        Text(
                                          prod['name'],
                                          style: TextStyle(
                                            fontSize: 16,
                                            fontWeight: FontWeight.bold,
                                            // color: Color(0xFF7C7C7C),
                                          ),
                                        ),
                                        SizedBox(
                                          height: 3,
                                        ),
                                        Text(
                                          prod['sub_desc'],
                                          style: TextStyle(
                                            fontSize: 14,
                                            fontWeight: FontWeight.bold,
                                            color: Color(0xFF7C7C7C),
                                          ),
                                        ),
                                        SizedBox(
                                          height: 5,
                                        ),
                                        Row(
                                          mainAxisSize: MainAxisSize.max,
                                          children: [
                                            Text(
                                              "\Rs. ${prod['price']} /-",
                                              style: TextStyle(
                                                fontSize: 18,
                                                fontWeight: FontWeight.bold,
                                              ),
                                            ),
                                          ],
                                        ),
                                        Expanded(
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              Expanded(
                                                child: TextButton(
                                                  child: Text(
                                                    'Add to Cart',
                                                    style:
                                                        TextStyle(fontSize: 10),
                                                  ),
                                                  style: TextButton.styleFrom(
                                                    primary: Colors.white,
                                                    backgroundColor:
                                                        Colors.indigo,
                                                    // onSurface: Colors.grey,
                                                  ),
                                                  onPressed: () {
                                                    print('Pressed');
                                                  },
                                                ),
                                              ),
                                              Expanded(
                                                child: IconButton(
                                                    onPressed: () {
                                                      if (removeFromWishList(
                                                          prod['id'])) {
                                                        setState(() {
                                                          Center(
                                                              child:
                                                                  CircularProgressIndicator());
                                                        });
                                                      }
                                                    },
                                                    icon: Icon(
                                                      Icons.delete,
                                                      color: Colors.indigo,
                                                    )),
                                              )
                                            ],
                                          ),
                                        )
                                      ],
                                    ),
                                  ),
                                ),
                              );
                            },
                          ),
                        ))
                  ],
                )),
              ),
            ),
      drawer: MainDrawer(),
    );
  }
}
