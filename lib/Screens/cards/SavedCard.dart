import 'package:flutter/material.dart';
import 'package:flutter_auth/components/rounded_button.dart';
import 'package:flutter_svg/svg.dart';

import 'AddCard.dart';

class SavedCards extends StatelessWidget {
  const SavedCards({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(backgroundColor: Colors.indigo,
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
          "Saved Card",
          style: TextStyle(
              fontSize: 20, fontWeight: FontWeight.bold, color: Colors.white),
        ),),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Container(
            child: Column(
              children: [
                SizedBox(
                  height: 10,
                ),
                Center(
                  child: Container(
                    width: 200,
                    height: 100,
                    child: SvgPicture.asset("assets/icons/CreditCard.svg"),
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Text(
                    "SAVE YOUR CREDIT/DEBIT CARDS",
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Center(
                    child: Text(
                      "It's Convenient to pay with saved cards." +
                          "Your Card information will be " +
                          "secure we use 128-bit encryption.",
                      style: TextStyle(
                          fontSize: 14, fontWeight: FontWeight.normal),
                    ),
                  ),
                ),
                SizedBox(
                  height: 5,
                ),
                RoundedButton(
                    text: "Add Card",
                    press: () {
                      Navigator.push(context,
                          MaterialPageRoute(builder: (context) => AddCard()));
                    })
              ],
            ),
          ),
        ),
      ),
    );
  }
}
