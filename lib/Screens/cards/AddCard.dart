import 'package:flutter/material.dart';
import 'package:flutter_auth/components/input_feild.dart';
import 'package:flutter_auth/components/rounded_button.dart';


class AddCard extends StatefulWidget {
  const AddCard({Key key}) : super(key: key);

  @override
  _AddCardState createState() => _AddCardState();
}

class _AddCardState extends State<AddCard> {
  @override
  Widget build(BuildContext context) {
    // Size size = MediaQuery.of(context).size;
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
          "Add Card",
          style: TextStyle(
              fontSize: 20, fontWeight: FontWeight.bold, color: Colors.white),
        ),),
      body: SafeArea(
          child: Center(
        child: Container(
            child: Padding(
              padding: const EdgeInsets.all(24.0),
              child: ListView(
          children: [
              SizedBox(
                height: 5,
              ),
              Text(
                "Add New Credit/Debit Card",
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              InputField(
                hintText: "Card Number",
                icon: Icons.credit_card,
              ),
              InputField(
                hintText: "Card Name",
                icon: Icons.person,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: InputField(
                      hintText: "Month",
                      icon: Icons.calendar_today,
                    ),
                  ),
                  Expanded(
                    child: InputField(
                      hintText: "Year",
                      icon: Icons.calendar_today,
                    ),
                  ),
                ],
              ),
              RoundedButton(
                text: "SAVE",
                press: () {},
              )
          ],
        ),
            )),
      )),
    );
  }
}
