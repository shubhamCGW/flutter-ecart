import 'package:flutter/material.dart';
import 'package:flutter_auth/Screens/Cart/cart.dart';
import 'package:flutter_auth/screens/explore_screen.dart';
import 'package:flutter_svg/svg.dart';

class OrderAcceptedScreen extends StatelessWidget {
  const OrderAcceptedScreen({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0.0,
        centerTitle: true,
        leading: GestureDetector(
          onTap: () {
            Navigator.pop(context);
          },
          child: Container(
            child: Icon(
              Icons.keyboard_arrow_left,
              color: Colors.indigo,
            ),
          ),
        ),
        actions: [
          IconButton(
              onPressed: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => SearchScreen()));
              },
              icon: Icon(Icons.search, color: Colors.indigo)),
          IconButton(
              onPressed: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => CartScreen()));
              },
              icon: Icon(Icons.shopping_cart, color: Colors.indigo)),
        ],
      ),
      body: SafeArea(
        child: Container(
          width: double.maxFinite,
          padding: EdgeInsets.symmetric(horizontal: 25),
          child: Column(
            children: [
              Spacer(
                flex: 10,
              ),
              SvgPicture.asset("assets/icons/order_accepted_icon.svg"),
              Spacer(
                flex: 8,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 40),
                child: Text(
                  "You Order Has Been Accepted",
                  textAlign: TextAlign.center,
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 28),
                ),
              ),
              Spacer(),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 40),
                child: Text(
                  "Your item has been placed and is on it's way to being processed",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      fontSize: 16,
                      color: Color(0xff7C7C7C),
                      fontWeight: FontWeight.w600),
                ),
              ),
              Spacer(
                flex: 2,
              ),
              // RoundedButton(
              //   text: "Track Order",
              //   press: () {},
              // ),
              // Spacer(
              //   flex: 6,
              // )
            ],
          ),
        ),
      ),
    );
  }
}
