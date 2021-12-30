import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_auth/Screens/Products/productDetail.dart';
import 'package:flutter_auth/api/api.dart';
import 'package:flutter_auth/components/MainAppBar.dart';

class SeeAllProdList extends StatefulWidget {
  const SeeAllProdList({Key key}) : super(key: key);

  @override
  State<SeeAllProdList> createState() => _SeeAllProdListState();
}

class _SeeAllProdListState extends State<SeeAllProdList> {
  List products;
  int productID;
  final double width = 174;

  final double height = 200;

  final Color borderColor = Color(0xffE2E2E2);

  final double borderRadius = 18;

  getProducts() async {
    var response = await CallApi().getData('getProducts');

    if (response.statusCode == 200) {
      var res = json.decode(response.body.toString());
      if (res['status']) {
        setState(() {
          products = res['response'];
        });
      } else {
        print(" ${response['error']}");
      }
    } else {
      print("Please try again!");
    }
  }

  @override
  void initState() {
    getProducts();
    super.initState();
  }


  getProductDetails(int productId) async {
    var data = {
      'product_id': productId,
    };

    var response =
        await CallApi().postDataWithHeader(data, 'getProductDetails');
  
    if (response.statusCode == 200) {
      var res = json.decode(response.body.toString());
        // print(response['response']);
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
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: MainAppBar(title: "All Products"),
      // AppBar(
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
      //     "All Products",
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
      // )
      body: products == null
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
                            itemCount: products.length,
                            scrollDirection: Axis.vertical,
                            itemBuilder: (context, int index) {
                              final prod = products[index];
                              return GestureDetector(
                                onTap: () {
                                  prod['id'] == null
                                      ? Center(
                                          child: CircularProgressIndicator())
                                      : getProductDetails(prod['id']);
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
                                              child:
                                                  Image.network(prod['image']),
                                            ),
                                          ),
                                        ),
                                        SizedBox(
                                          height: 20,
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
                                          height: 12,
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
                                              "\Rs. ${prod['price'].toStringAsFixed(2)} /-",
                                              style: TextStyle(
                                                fontSize: 18,
                                                fontWeight: FontWeight.bold,
                                              ),
                                            ),
                                          ],
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
    );
  }
}
