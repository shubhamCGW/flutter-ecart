import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class CallApi {
  // final String _url = 'http://127.0.0.1:8000/api/';
  // for android debug
  // final String _url = 'http://10.0.2.2/Ecart/api/';
  // for localhost
  // final String _url = 'http://localhost/Ecart/api/';
  //for build
  final String _url = 'http://192.168.1.6:8000/api/';

  postData(data, apiUrl) async {
    var fullUrl = _url + apiUrl;
    return await http.post(Uri.parse(fullUrl),
        body: jsonEncode(data), headers: _setHeaders());
  }

  postDataWithHeader(data, apiUrl) async {
    var fullUrl = _url + apiUrl;
    WidgetsFlutterBinding.ensureInitialized();
    SharedPreferences localStorage = await SharedPreferences.getInstance();
    var userProflie = json.decode(localStorage.getString('userProfile'));
    return await http
        .post(Uri.parse(fullUrl), body: jsonEncode(data), headers: {
      'Content-type': 'application/json',
      'Accept': 'application/json',
      'Authorization': 'Bearer ' + userProflie['token'],
    });
  }

  authPostData(data, apiUrl) async {
    // print("hello sourabh");
    // print(data);
    // print(apiUrl);
    var fullUrl = _url + apiUrl;
    return await http.post(Uri.parse(fullUrl), headers: {
      'Content-type': 'application/json',
      'Accept': 'application/json',
      'Authorization': 'Bearer ' + data,
    });
  }

  getData(apiUrl) async {
    var fullUrl = _url + apiUrl;
    return await http.get(Uri.parse(fullUrl), headers: _setHeaders());
  }

  getDataWithHeader(apiUrl) async {
    var fullUrl = _url + apiUrl;
    WidgetsFlutterBinding.ensureInitialized();
    SharedPreferences localStorage = await SharedPreferences.getInstance();
    var userProflie = json.decode(localStorage.getString('userProfile'));
    return await http.post(Uri.parse(fullUrl), headers: {
      'Content-type': 'application/json',
      'Accept': 'application/json',
      'Authorization': 'Bearer ' + userProflie['token'],
    });
  }

  _setHeaders() => {
        'Content-type': 'application/json',
        'Accept': 'application/json',
      };

  setHeadersWithBearerToken(token) => {
        'Content-type': 'application/json',
        'Accept': 'application/json',
        'Authorization': 'Bearer ' + token,
      };

  getToken() async {
    WidgetsFlutterBinding.ensureInitialized();
    SharedPreferences localStorage = await SharedPreferences.getInstance();
    var token = json.decode(localStorage.getString('userProfile'));
    return "?token=$token['token']";
  }

  getUserProfile() async {
    WidgetsFlutterBinding.ensureInitialized();
    SharedPreferences localStorage = await SharedPreferences.getInstance();
    var userProflie = json.decode(localStorage.getString('userProfile'));
    return userProflie as Map<String, dynamic>;
  }

  // getUserisLoogedIn() async {
  //   SharedPreferences localStorage = await SharedPreferences.getInstance();
  //   var userProflie = json.decode(localStorage.getString('userProfile'));
  //   return userProflie;
  // }

  getUserisLoggedIn() async {
    WidgetsFlutterBinding.ensureInitialized();
    SharedPreferences localStorage = await SharedPreferences.getInstance();
    var userProflie = json.decode(localStorage.getString('userProfile'));
    print(userProflie['token']);
    return userProflie['token'];
  }

  getAuthUserId() async {
    WidgetsFlutterBinding.ensureInitialized();
    SharedPreferences localStorage = await SharedPreferences.getInstance();
    var userProflie = json.decode(localStorage.getString('userProfile'));
    return userProflie['profile']['id'];
  }
}
