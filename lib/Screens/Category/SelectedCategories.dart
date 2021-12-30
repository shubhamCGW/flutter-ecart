import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_auth/Screens/Category/DetailCategory.dart';
import 'package:flutter_auth/api/api.dart';
import 'package:flutter_auth/components/MainAppBar.dart';
import 'package:flutter_auth/constants.dart';

// ignore: must_be_immutable
class SelectedCategoires extends StatefulWidget {
  final catName;
  List selectedCategory;
  SelectedCategoires(this.selectedCategory,this.catName);

  @override
  State<SelectedCategoires> createState() => _SelectedCategoiresState();
}

class _SelectedCategoiresState extends State<SelectedCategoires> {
  getProductDetails(int productId) async {
    var data = {
      'product_id': productId,
    };
    var response =
        await CallApi().postDataWithHeader(data, 'getProductDetails');

    if (response.statusCode == 200) {
      var res = json.decode(response.body.toString());
      if (res['status']) {
        print(res['response']);
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => DetailsPage(res['response'])));
      } else {
        print(" ${response['error']}");
      }
    } else {
      print("Please try again!");
    }
  }

  @override
  Widget build(BuildContext context) {
    if (widget.selectedCategory.length == 0) {
      return Scaffold(
        appBar: MainAppBar(title: widget.catName),
        body: SafeArea(
            child: Container(
          child: Center(child: Text("NO DATA FOUND")),
        )),
      );
    } else {
      return Scaffold(
        appBar: MainAppBar(title:  widget.catName),
        body: SafeArea(
          child: Container(
              child: Column(children: [
            SizedBox(
              height: 10,
            ),
            Expanded(
              child: Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: kDefaultPadding),
                  child: GridView.builder(
                      itemCount: widget.selectedCategory.length,
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        mainAxisSpacing: 5,
                        crossAxisSpacing: 2,
                        childAspectRatio: 0.90,
                      ),
                      itemBuilder: (context, index) => GestureDetector(
                            onTap: () {
                              getProductDetails(
                                  widget.selectedCategory[index]['id']);
                            },
                            child: Container(
                              padding: EdgeInsets.symmetric(
                                horizontal: 2,
                              ),
                              height: 150,
                              width: 350,
                              decoration: BoxDecoration(
                                border: Border.all(
                                  color: Color(0xffE2E2E2),
                                ),
                                borderRadius: BorderRadius.circular(
                                  18,
                                ),
                              ),
                              child: Column(
                                children: <Widget>[
                                  Expanded(
                                    child: Container(
                                      padding: EdgeInsets.all(kDefaultPadding),
                                      child: Hero(
                                          tag:
                                              "${widget.selectedCategory[index]['image']}",
                                          child: Image(
                                            image: NetworkImage(
                                                widget.selectedCategory[index]
                                                    ['image']),
                                          )),
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.symmetric(
                                        vertical: kDefaultPadding / 4),
                                    child: Text(
                                      widget.selectedCategory[index]['name'],
                                      style: TextStyle(
                                          color: Colors.black,
                                          fontSize: 18,
                                          fontWeight: FontWeight.bold),
                                    ),
                                  ),
                                  Text(
                                    "\Rs. ${widget.selectedCategory[index]['price']} /-",
                                    style: TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.bold),
                                  ),
                                  SizedBox(
                                    height: 10,
                                  )
                                ],
                              ),
                            ),
                          ))),
            ),
          ])),
        ),
      );
    }
  }
}
