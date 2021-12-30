import 'package:flutter/material.dart';
import 'package:flutter_auth/components/rounded_button.dart';
import 'package:flutter_auth/components/rounded_input_field.dart';

class SearchBarWidget extends StatelessWidget {
  final String searchIcon = "assets/icons/search_icon.svg";

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Column(
            children: [
              RoundedInputField(
                icon: Icons.search,
                hintText: "Search here",
              ),
              RoundedButton(
                text: "Go",
                press: (){},
              )
            ],
          ),

        ],
      ),
    );
  }
}
