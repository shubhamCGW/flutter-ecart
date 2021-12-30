import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_auth/Screens/explore_screen.dart';
import 'package:flutter_auth/api/api.dart';
import 'package:flutter_auth/components/rounded_button.dart';
import 'CheckoutBottomSheet.dart';

class CartScreen extends StatefulWidget {
  @override
  State<CartScreen> createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  final double height = 110;
  final Color borderColor = Color(0xffE2E2E2);
  final double borderRadius = 18;
  int amount = 1;
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
        print(response['error']);
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
    // print(myCart.toString());
    return 
    Scaffold(
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
          "My Cart",
          style: TextStyle(
              fontSize: 20, fontWeight: FontWeight.bold, color: Colors.white),
        ),
        actions: [
          IconButton(
              onPressed: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => SearchScreen()));
              },
              icon: Icon(Icons.search, color: Colors.white)),
        ],
      ),
      body: myCart == null? Text(" Your Cart is empty"):
      SafeArea(
        child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Center(
                  child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
              getCartItems(),
              Divider(
                thickness: 2,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Total (${getProductQuantity().toString()} items)",
                    style: TextStyle(fontWeight: FontWeight.w700, fontSize: 16),
                  ),
                  Text(
                    "\Rs. ${getTotalPrice().toStringAsFixed(2)} /-",
                    style: TextStyle(fontWeight: FontWeight.w700, fontSize: 14),
                  )
                ],
              ),
              SizedBox(
                height: 5,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "+Taxes",
                    style: TextStyle(
                        fontWeight: FontWeight.w500,
                        fontSize: 14,
                        color: Colors.grey),
                  ),
                  Text(
                    "\Rs.${getTotalTaxProductPrice().toStringAsFixed(2)}/-",
                    style: TextStyle(
                        fontWeight: FontWeight.w500,
                        fontSize: 12,
                        color: Colors.grey),
                  )
                ],
              ),
              SizedBox(
                height: 5,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "+Delivery Charges",
                    style: TextStyle(
                        fontWeight: FontWeight.w500,
                        fontSize: 14,
                        color: Colors.grey),
                  ),
                  Text(
                    "\Rs 50/-",
                    style: TextStyle(
                        fontWeight: FontWeight.w500,
                        fontSize: 12,
                        color: Colors.grey),
                  )
                ],
              ),
              SizedBox(
                height: 5,
              ),
              // Row(
              //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
              //   children: [
              //     Text(
              //       "Discounts",
              //       style: TextStyle(
              //           fontWeight: FontWeight.bold,
              //           fontSize: 14,
              //           color: Colors.black),
              //     ),
              //     Text(
              //       "-\Rs. 6.1/-",
              //       style: TextStyle(
              //           fontWeight: FontWeight.bold,
              //           fontSize: 12,
              //           color: Colors.black),
              //     )
              //   ],
              // ),
              SizedBox(
                height: 5,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Total Payable",
                    style: TextStyle(
                      fontWeight: FontWeight.w700,
                      fontSize: 16,
                    ),
                  ),
                  Text(
                    "\Rs.${getTotalAmount().toStringAsFixed(2)}/-",
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 14,
                        color: Colors.black),
                  )
                ],
              ),
              Divider(
                thickness: 2,
              ),
              // SizedBox(
              //   height: 25,
              // ),
              getCheckoutButton(context)
          ],
        )),
            )),
      ),
    );
  }

  Widget getCartItems() {
    Size size = MediaQuery.of(context).size;
    return Container(
        margin: EdgeInsets.symmetric(vertical: 10),
        height: size.height*(0.3),
        width: double.infinity,
        child: myCart == null
            ? Center(child: Container(child: Column(children: [
              CircularProgressIndicator(),
              // Text("YOUR CART IS EMPTY")
            ],)),
            )
            : ListView.builder(
                itemCount: myCart.length,
                scrollDirection: Axis.vertical,
                itemBuilder: (context, index) {
                  final cart = myCart[index];
                  return
                      Container(
                          child: Row(
                    children: [
                      Flexible(
                        child: Container(
                          height: 100,
                          width: 100,
                          decoration: BoxDecoration(
                              image: DecorationImage(
                                  image:
                                      NetworkImage(cart['image']))),
                        ),
                      ),
                      SizedBox(
                        width: 10,
                      ),
                      Flexible(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              cart['name'],
                              style: TextStyle(
                                  fontSize: 16, fontWeight: FontWeight.w600),
                            ),
                            SizedBox(height: 3),
                            Text(
                              cart['sub_desc'],
                              style: TextStyle(fontSize: 12),
                            ),
                            SizedBox(height: 5),
                            Row(
                              children: [
                                SizedBox(height: 5),
                                Text(
                                  "\Rs. ${cart['amount']} /-",
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      color: Colors.black),
                                  textAlign: TextAlign.center,
                                ),
                              ],
                            ),
                            Center(
                              child: Row(
                                children: [
                                  Icon(
                                    Icons.delete,
                                    color: Colors.indigo[850],
                                    size: 25,
                                  ),
                                ],
                              ),
                            )
                          ],
                        ),
                      ),
                      SizedBox(
                        width: 3,
                      ),
                      Flexible(
                        child: Row(
                          children: [
                            ItemCounterWidgetForCart(
                              count: cart['quantity'],
                              onAmountChanged: (newAmount) {
                                setState(() {
                                  cart['amount'] =
                                      cart['price'] * newAmount;
                                });
                              },
                            ),
                          ],
                        ),
                      ),
                    ],
                  ));
                }));
    // SizedBox(
    //   height: 7,
    // ),
    // Divider(
    //   thickness: 2,
    // ),
    // Row(
    //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
    //   children: [
    //     Text(
    //       "Total (${getProductQuantity().toString()} items)",
    //       style: TextStyle(fontWeight: FontWeight.w700, fontSize: 16),
    //     ),
    //     Text(
    //       "\Rs. ${getTotalPrice().toStringAsFixed(2)} /-",
    //       style: TextStyle(fontWeight: FontWeight.w700, fontSize: 14),
    //     )
    //   ],
    // ),
    // SizedBox(
    //   height: 5,
    // ),
    // Row(
    //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
    //   children: [
    //     Text(
    //       "+Taxes",
    //       style: TextStyle(
    //           fontWeight: FontWeight.w500,
    //           fontSize: 14,
    //           color: Colors.grey),
    //     ),
    //     Text(
    //       "\Rs.${getTotalTaxProductPrice().toStringAsFixed(2)}/-",
    //       style: TextStyle(
    //           fontWeight: FontWeight.w500,
    //           fontSize: 12,
    //           color: Colors.grey),
    //     )
    //   ],
    // ),
    // SizedBox(
    //   height: 5,
    // ),
    // Row(
    //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
    //   children: [
    //     Text(
    //       "+Delivery Charges",
    //       style: TextStyle(
    //           fontWeight: FontWeight.w500,
    //           fontSize: 14,
    //           color: Colors.grey),
    //     ),
    //     Text(
    //       "\Rs 50/-",
    //       style: TextStyle(
    //           fontWeight: FontWeight.w500,
    //           fontSize: 12,
    //           color: Colors.grey),
    //     )
    //   ],
    // ),
    // SizedBox(
    //   height: 5,
    // ),
    // Row(
    //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
    //   children: [
    //     Text(
    //       "Discounts",
    //       style: TextStyle(
    //           fontWeight: FontWeight.bold,
    //           fontSize: 14,
    //           color: Colors.black),
    //     ),
    //     Text(
    //       "-\Rs. 6.1/-",
    //       style: TextStyle(
    //           fontWeight: FontWeight.bold,
    //           fontSize: 12,
    //           color: Colors.black),
    //     )
    //   ],
    // ),
    // SizedBox(
    //   height: 5,
    // ),
    // Row(
    //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
    //   children: [
    //     Text(
    //       "Total Payable",
    //       style: TextStyle(
    //         fontWeight: FontWeight.w700,
    //         fontSize: 16,
    //       ),
    //     ),
    //     Text(
    //       "\Rs.${getTotalAmount().toStringAsFixed(2)}/-",
    //       style: TextStyle(
    //           fontWeight: FontWeight.bold,
    //           fontSize: 14,
    //           color: Colors.black),
    //     )
    //   ],
    // ),
    // Divider(
    //   thickness: 2,
    // ),
    // // SizedBox(
    // //   height: 25,
    // // ),
    // getCheckoutButton(context)
    //   ],
    // );
  }

  Widget getCheckoutButton(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 25, vertical: 20),
      child: Center(
        child: RoundedButton(
          text: "Check Out",
          press: () {
            showBottomSheet(context);
          },
        ),
      ),
    );
  }

  Widget getButtonPriceWidget() {
    return Container(
      padding: EdgeInsets.all(2),
      decoration: BoxDecoration(
        color: Colors.indigo,
        borderRadius: BorderRadius.circular(4),
      ),
      child: Text(
        "\$12.96",
        style: TextStyle(fontWeight: FontWeight.w600),
      ),
    );
  }

  void showBottomSheet(context) {
    showModalBottomSheet(
        context: context,
        isScrollControlled: true,
        backgroundColor: Colors.transparent,
        builder: (BuildContext bc) {
          return CheckoutBottomSheet();
        });
  }

  int getProductQuantity() {
    var totalQty = 0;
    if (myCart == null) {
      Center(child: CircularProgressIndicator());
    } else {
      for (var i = 0; i < myCart.length; i++) {
        totalQty = totalQty + myCart[i]['quantity'];
      }
    }
    return totalQty;
  }

  double getTotalPrice() {
    double totalprice = 0;
    if (myCart == null) {
      Center(child: CircularProgressIndicator());
    } else {
      for (var i = 0; i < myCart.length; i++) {
        totalprice = totalprice + myCart[i]['amount'];
      }
    }
    return totalprice;
  }

  double getProductPrice() {
    double price = 0;
    if (myCart == null) {
      Center(child: CircularProgressIndicator());
    } else {
      for (var i = 0; i < myCart.length; i++) {
        price = amount * myCart[i]['price'];
      }
    }
    return price;
  }

  double getTaxPrice() {
    double tax = 0;
    if (myCart == null) {
      Center(child: CircularProgressIndicator());
    } else {
      for (var i = 0; i < myCart.length; i++) {
        tax = 0.18 * myCart[i]['price'];
      }
    }
    return tax;
  }

  double getTotalTaxProductPrice() {
    double taxPrice = 0;

    taxPrice = getTotalPrice() * 0.18;
    return taxPrice;
  }

  double getTotalAmount() {
    return getTotalPrice() + getTotalTaxProductPrice() + 0;
  }
  // @override
  // void dispose() {
  //   super.dispose();
  //   getCartList();
  // }
}

// ignore: must_be_immutable
class ItemCounterWidgetForCart extends StatefulWidget {
  final Function onAmountChanged;
  int count;

  ItemCounterWidgetForCart(
      {Key key, this.onAmountChanged, @required this.count})
      : super(key: key);

  // get groceryItem => null;

  @override
  _ItemCounterWidgetForCartState createState() =>
      _ItemCounterWidgetForCartState();
}

class _ItemCounterWidgetForCartState extends State<ItemCounterWidgetForCart> {
  int amount;

  @override
  Widget build(BuildContext context) {
    // amount = widget.count;
    return Row(
      children: [
        iconWidget(Icons.remove,
            iconColor: Colors.grey[700], onPressed: decrementAmount),
        SizedBox(width: 12),
        widget.count == null
            ? Container(
                width: 30,
                child: Center(
                    child: getText(text: ("demo"), fontSize: 18, isBold: true)))
            : Container(
                width: 30,
                child: Center(
                    child: getText(
                        text: widget.count.toString(),
                        fontSize: 18,
                        isBold: true))),
        SizedBox(width: 12),
        iconWidget(Icons.add,
            iconColor: Colors.indigo, onPressed: incrementAmount)
      ],
    );
  }

  void incrementAmount() {
    setState(() {
      widget.count++;
      updateParent();
    });
  }

  void decrementAmount() {
    if (widget.count <= 1) return;
    setState(() {
      widget.count--;
      updateParent();
    });
  }

  void getProductQuantity() {
    widget.count.toString();
  }

  void updateParent() {
    if (widget.onAmountChanged != null) {
      widget.onAmountChanged(widget.count);
    }
  }

  Widget iconWidget(IconData iconData, {Color iconColor, onPressed}) {
    return GestureDetector(
      onTap: () {
        if (onPressed != null) {
          onPressed();
        }
      },
      child: Container(
        // height: 45,
        // width: 27,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(0),
          border: Border.all(
            color: Color(0xffE2E2E2),
          ),
        ),
        child: Center(
          child: Icon(
            iconData,
            color: iconColor ?? Colors.black,
            size: 25,
          ),
        ),
      ),
    );
  }

  Widget getText(
      {String text,
      double fontSize,
      bool isBold = false,
      color = Colors.black}) {
    return Text(
      text,
      style: TextStyle(
        fontSize: fontSize,
        fontWeight: isBold ? FontWeight.bold : FontWeight.normal,
        color: color,
      ),
    );
  }
  
}
