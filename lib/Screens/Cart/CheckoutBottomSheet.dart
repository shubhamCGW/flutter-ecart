import 'package:flutter/material.dart';
import 'package:flutter_auth/Screens/Account/components/profile_menu.dart';
import 'package:flutter_auth/Screens/RazorPay/RazorPayScreen.dart';
import 'package:flutter_auth/common_widget/appText.dart';
import 'package:flutter_auth/components/rounded_button.dart';

import 'OrderAccept.dart';

class CheckoutBottomSheet extends StatefulWidget {
  @override
  _CheckoutBottomSheetState createState() => _CheckoutBottomSheetState();
}

class _CheckoutBottomSheetState extends State<CheckoutBottomSheet> {
  bool istotalPrice = false;
  bool isAmmount = false;
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Container(
        padding: EdgeInsets.symmetric(
          horizontal: 25,
          vertical: 30,
        ),
        decoration: BoxDecoration(
            color: Colors.indigo[50],
            borderRadius: BorderRadius.vertical(top: Radius.circular(20))),
        child: new Wrap(
          children: <Widget>[
            Row(
              children: [
                AppText(
                  text: "Checkout",
                  fontSize: 24,
                  fontWeight: FontWeight.w600,
                  color: Colors.indigo,
                ),
                Spacer(),
                GestureDetector(
                    onTap: () {
                      Navigator.pop(context);
                    },
                    child: Icon(
                      Icons.close,
                      size: 25,
                      color: Colors.indigo,
                    ))
              ],
            ),
            SizedBox(
              height: 45,
            ),
            // getDivider(),
            // checkoutRow("Delivery", trailingText: "Select Method"),
            getDivider(),
            ProfileMenu(
              text: "Payment",
              icon: "",
              press: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => RazorPayScreen()));
              },
            ),
            getDivider(),
            checkoutRow(
              "Total Cost",
              trailingText: "\Rs.13.97/-",
            ),
            getDivider(),
            SizedBox(
              height: 30,
            ),
            termsAndConditionsAgreement(context),
            Container(
                margin: EdgeInsets.only(
                  top: 10,
                  bottom: 25,
                ),
                child: RoundedButton(
                  text: "Place Order",
                  press: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) {
                      return OrderAcceptedScreen();
                    }));
                  },
                )),
          ],
        ),
      ),
    );
  }

  Widget getDivider() {
    return Divider(
      thickness: 1,
      color: Colors.indigo,
    );
  }

  Widget termsAndConditionsAgreement(BuildContext context) {
    return RichText(
      text: TextSpan(
          text: 'By placing an order you agree to our',
          style: TextStyle(
            color: Color(0xFF7C7C7C),
            fontSize: 14,
            fontFamily: Theme.of(context).textTheme.bodyText1.fontFamily,
            fontWeight: FontWeight.w600,
          ),
          children: [
            TextSpan(
                text: " Terms",
                style: TextStyle(
                    color: Colors.black, fontWeight: FontWeight.bold)),
            TextSpan(text: " And"),
            TextSpan(
                text: " Conditions",
                style: TextStyle(
                    color: Colors.black, fontWeight: FontWeight.bold)),
          ]),
    );
  }

  Widget checkoutRow(String label,
      {String trailingText, Widget trailingWidget}) {
    return Container(
      margin: EdgeInsets.symmetric(
        vertical: 15,
      ),
      child: Row(
        children: [
          AppText(
            text: label,
            fontSize: 18,
            color: Colors.indigo[600],
            fontWeight: FontWeight.w600,
          ),
          Spacer(),
          trailingText == null
              ? trailingWidget
              : AppText(
                  text: trailingText,
                  fontSize: 16,
                  color: Colors.indigo[300],
                  fontWeight: FontWeight.w600,
                ),
          SizedBox(
            width: 20,
          ),
          !isAmmount
              ? Icon(
                  Icons.arrow_forward_ios,
                  size: 20,
                )
              : Text("\u20B9")
        ],
      ),
    );
  }

  // void onPlaceOrderClicked() {
  //   Navigator.pop(context);
  //   showDialog(context: context, child: OrderFailedDialogue());
  // }
}
