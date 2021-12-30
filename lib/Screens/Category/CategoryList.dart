import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_auth/api/api.dart';
import 'package:flutter_auth/components/MainAppBar.dart';

import 'SelectedCategories.dart';

class CategoryListScreen extends StatefulWidget {
  @override
  State<CategoryListScreen> createState() => _CategoryListScreenState();
}

class _CategoryListScreenState extends State<CategoryListScreen> {
  List categories;
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
        print(response['response']);
      }
    } else {
      print("Please try again!");
    }
  }

  @override
  void initState() {
    getCartList();
    getCategories();
    super.initState();
  }

  getCategories() async {
    var response = await CallApi().getData('getCategories');

    if (response.statusCode == 200) {
      var res = json.decode(response.body.toString());
      if (res['status']) {
        setState(() {
          categories = res['response'];
        });
      } else {
        print(" ${response['error']}");
      }
    } else {
      print("Please try again!");
    }
  }

  getProductByCategories(int categoryId, String catName) async {
    var data = {
      'category_id': categoryId,
    };
    var response = await CallApi().postData(data, 'getProductsByCategory');

    if (response.statusCode == 200) {
      var res = json.decode(response.body.toString());
      if (res['status']) {
        // print(res['response']);
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => SelectedCategoires(res['response'],catName)));
      } else {
        print(" ${response['error']}");
      }
    } else {
      print("Please try again!");
    }
  }

  // @override
  // void dispose() {
  //   getCartList();
  //   getCategories();
  //   super.dispose();
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MainAppBar(title: "Find Products"),
      // drawer: MainDrawer(),
      body: SafeArea(
          child: Column(
        children: [
          Expanded(
              child: Container(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Expanded(
                    child: categories == null
                        ? Center(child: CircularProgressIndicator())
                        : ListView.builder(
                            padding: EdgeInsets.only(bottom: 40, top: 60),
                            itemCount: categories.length,
                            itemBuilder: (BuildContext context, int index) {
                              final cat = categories[index];
                              return GestureDetector(
                                onTap: () {
                                  getProductByCategories(cat['id'],cat['name']);
                                },
                                child: Container(
                                  margin: EdgeInsets.all(20),
                                  height: 150,
                                  child: Stack(
                                    children: [
                                      Positioned.fill(
                                          child: ClipRRect(
                                              borderRadius:
                                                  BorderRadius.circular(20),
                                              child: Image.network(cat['image'],
                                                  fit: BoxFit.fill))),
                                      Positioned(
                                        bottom: 0,
                                        left: 0,
                                        right: 0,
                                        child: Container(
                                          height: 120,
                                          decoration: BoxDecoration(
                                              borderRadius: BorderRadius.only(
                                                bottomLeft: Radius.circular(20),
                                                bottomRight:
                                                    Radius.circular(20),
                                              ),
                                              gradient: LinearGradient(
                                                  begin: Alignment.bottomCenter,
                                                  end: Alignment.topCenter,
                                                  colors: [
                                                    Colors.black
                                                        .withOpacity(0.7),
                                                    Colors.transparent
                                                  ])),
                                        ),
                                      ),
                                      Positioned(
                                        bottom: 0,
                                        child: Padding(
                                          padding: const EdgeInsets.all(10),
                                          child: Row(
                                            children: [
                                              Text(cat['name'],
                                                  style: TextStyle(
                                                      color: Colors.white,
                                                      fontSize: 25))
                                            ],
                                          ),
                                        ),
                                      )
                                    ],
                                  ),
                                ),
                              );
                            }))
              ],
            ),
          ))
        ],
      )),
    );
  }
}
