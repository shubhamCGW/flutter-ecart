import 'package:flutter/material.dart';

class ItemCounterWidget extends StatefulWidget {
  final Function onAmountChanged;

  const ItemCounterWidget({Key key, this.onAmountChanged}) : super(key: key);

  // get groceryItem => null;

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
        getQuanitity(),
        SizedBox(width: 12),
        iconWidget(Icons.add,
            iconColor: Colors.indigo, onPressed: incrementAmount)
      ],
    );
  }

  Container getQuanitity() {
    return Container(
        width: 30,
        child: Center(
            child:
                getText(text: amount.toString(), fontSize: 18, isBold: true)));
  }

  void incrementAmount() {
    setState(() {
      amount = amount + 1;
      updateParent();
    });
  }

  void decrementAmount() {
    if (amount <= 1) return;
    setState(() {
      amount = amount - 1;
      updateParent();
    });
  }

  void getProductQuantity() {
    amount.toString();
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
