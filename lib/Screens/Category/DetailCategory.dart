import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_auth/Screens/Cart/cart.dart';
import 'package:flutter_auth/api/api.dart';
import 'package:flutter_auth/components/MainAppBar.dart';
import 'package:flutter_auth/components/rounded_button.dart';
// import 'package:flutter_auth/models/SubCategory.dart';

// ignore: must_be_immutable
class DetailsPage extends StatefulWidget {
  final subCategory;
  DetailsPage(this.subCategory);

  @override
  _DetailsPageState createState() => _DetailsPageState();
}

class _DetailsPageState extends State<DetailsPage> {
  int amount = 1;
  bool favorite = false;
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
        showSnackbar(response['message']);
      } else {
        showSnackbar(response['error']);
      }
    } else {
      print("Please try again!");
    }
  }

  @override
  Widget build(BuildContext context) {
    if (widget.subCategory.length == 0) {
      return Scaffold(
        appBar: MainAppBar(title: "Product details"),
        body: SafeArea(
            child: Container(
          child: Center(child: Text("NO DATA FOUND")),
        )),
      );
    } else {
      return Scaffold(
        appBar: MainAppBar(title: "Product details"),
        body: SafeArea(
            child: SingleChildScrollView(
          child: Center(
            child: Column(
              children: [
                getProductImage(widget: widget),
                SizedBox(
                  height: 10,
                ),
                Container(
                  child: Column(
                    children: [
                      ListTile(
                        title: Text(
                          widget.subCategory['name'],
                          style: TextStyle(
                              fontSize: 18, fontWeight: FontWeight.bold),
                        ),
                        trailing: Padding(
                          padding: const EdgeInsets.only(
                              bottom: 20.0, right: 45, left: 2),
                          child: InkWell(
                            onTap: () {
                              if (widget.subCategory['favourite'] = true) {
                                setState(() {
                                  addToWishList(widget.subCategory['id']);
                                  favorite = !favorite;
                                });
                              }
                            },
                            child: Icon(
                              favorite ? Icons.favorite : Icons.favorite_border,
                              color: favorite ? Colors.indigo : Colors.blueGrey,
                            ),
                          ),
                        ),
                        subtitle: Padding(
                          padding: EdgeInsets.only(top: 10),
                          child: Text(widget.subCategory['sub_desc'],
                              style: TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w600,
                                  color: Color(0xff7C7C7C))),
                        ),
                      ),
                      Center(
                        child: Padding(
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
                              ),
                            ],
                          ),
                        ),
                      ),
                      Row(
                        children: [
                          Center(
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Container(
                                width: MediaQuery.of(context).size.width * 0.8,
                                child: Center(
                                  child: Text(
                                    widget.subCategory['description'],
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
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => CartScreen()),
                          );
                        },
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        )),
      );
    }
  }

  int getTotalPrice() {
    return amount * widget.subCategory['price'];
  }
}

class getProductImage extends StatelessWidget {
  const getProductImage({
    Key key,
    @required this.widget,
  }) : super(key: key);

  final DetailsPage widget;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 150,
      padding: EdgeInsets.symmetric(horizontal: 25, vertical: 25),
      width: double.maxFinite,

      // decoration: BoxDecoration(
      //   color: Colors.blue,
      //   borderRadius: BorderRadius.only(
      //     bottomLeft: Radius.circular(25),
      //     bottomRight: Radius.circular(25),
      //   ),
      //   gradient: new LinearGradient(
      //       colors: [
      //         const Color(0xFF3366FF).withOpacity(0.1),
      //         const Color(0xFF3366FF).withOpacity(0.09),
      //       ],
      //       begin: const FractionalOffset(0.0, 0.0),
      //       end: const FractionalOffset(0.0, 1.0),
      //       stops: [0.0, 1.0],
      //       tileMode: TileMode.clamp),
      // ),
      child: Image(
        image: NetworkImage(widget.subCategory['image']),
      ),
    );
  }
}

// class FavToggleBtn extends StatefulWidget {
//   const FavToggleBtn({Key key}) : super(key: key);

//   @override
//   _FavToggleBtnState createState() => _FavToggleBtnState();
// }

// class _FavToggleBtnState extends State<FavToggleBtn> {
//   bool favorite = false;
//   @override
//   Widget build(BuildContext context) {
//     return InkWell(
//       onTap: () {
//         setState(() {
//           favorite = !favorite;
//         });
//       },
//       child: Icon(
//         favorite ? Icons.favorite : Icons.favorite_border,
//         color: favorite ? Colors.indigo : Colors.blueGrey,
//       ),
//     );
//   }
// }

class ItemCounterWidget extends StatefulWidget {
  final Function onAmountChanged;

  const ItemCounterWidget({Key key, this.onAmountChanged}) : super(key: key);

  @override
  _ItemCounterWidgetState createState() => _ItemCounterWidgetState();
}

class _ItemCounterWidgetState extends State<ItemCounterWidget> {
  int amount = 1;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        iconWidget(Icons.remove,
            iconColor: Colors.grey[700], onPressed: decrementAmount),
        SizedBox(width: 12),
        Container(
            width: 30,
            child: Center(
                child: getText(
                    text: amount.toString(), fontSize: 18, isBold: true))),
        SizedBox(width: 12),
        iconWidget(Icons.add,
            iconColor: Colors.indigo, onPressed: incrementAmount)
      ],
    );
  }

  void incrementAmount() {
    setState(() {
      amount = amount + 1;
      updateParent();
    });
  }

  void decrementAmount() {
    if (amount <= 0) return;
    setState(() {
      amount = amount - 1;
      updateParent();
    });
  }

  void updateParent() {
    if (widget.onAmountChanged != null) {
      widget.onAmountChanged(amount);
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
        height: 45,
        width: 35,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(17),
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
