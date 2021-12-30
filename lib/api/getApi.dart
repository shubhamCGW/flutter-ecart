 import 'dart:convert';

import 'api.dart';

getProducts() async {
    var response = await CallApi().getData('getProducts');

    if (response.statusCode == 200) {
      var res = json.decode(response.body.toString());
      if (res['status']) {
        // setState(() {
        //   products = res['response'];
        // });
      } else {
        print(" ${response['error']}");
      }
    } else {
      print("Please try again!");
    }
  }

  getCategories() async {
    var response = await CallApi().getData('getCategories');

    if (response.statusCode == 200) {
      var res = json.decode(response.body.toString());
      if (res['status']) {
        // setState(() {
        //   categories = res['response'];
        // });
      } else {
        print(" ${response['error']}");
      }
    } else {
      print("Please try again!");
    }
  }
