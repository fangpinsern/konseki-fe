import 'dart:io';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:konseki_app/models/http_exceptions.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Auth with ChangeNotifier {
  String _idtoken = "";
  String _email = "";
  String _refreshToken = "";
  DateTime _expiryDate = DateTime.now();
  String _localId = "";
  String _name = "";

  final String _APIKey = "AIzaSyDdRiul6T45MvsKtKcMMbqfdxnc-zxpKlU";
  final String backendURL = '10.0.2.2:8080';

  bool get isAuth {
    print("this is $_idtoken");
    return _idtoken != "";
  }

  String get token {
    if (_expiryDate.isAfter(DateTime.now()) && _idtoken != "") {
      return _idtoken;
    }
    return "";
  }

  String get name {
    if (_name != "") {
      return _name;
    }
    return "";
  }

  Future<void> _authenticate(
      String email, String password, String name, String urlSegment) async {
    try {
      var url = Uri.parse(
          "https://identitytoolkit.googleapis.com/v1/accounts:$urlSegment?key=$_APIKey");
      var response = await http.post(
        url,
        body: json.encode(
          {
            "email": email,
            "password": password,
            "returnSecureToken": true,
          },
        ),
      );

      final responseData = json.decode(response.body);

      if (responseData['error'] != null) {
        throw HttpException(responseData['error']['message']);
      }
      _idtoken = responseData['idToken'];
      _localId = responseData['localId'];
      _email = responseData['email'];
      _refreshToken = responseData['refreshToken'];
      _expiryDate = DateTime.now()
          .add(Duration(seconds: int.parse(responseData['expiresIn'])));

      if (urlSegment == "signUp") {
        var url1 = Uri.http(backendURL, "/register");
        var response1 = await http.post(
          url1,
          headers: {
            "Authorization": "Bearer $_idtoken",
          },
          body: json.encode(
            {
              "name": name,
            },
          ),
        );

        final responseData1 = json.decode(response1.body);
        print(responseData1);
      }

      var url2 = Uri.http(backendURL, "/profile");
      var response2 = await http.get(
        url2,
        headers: {
          "Authorization": "Bearer $_idtoken",
        },
      );

      final profileData = json.decode(response2.body);
      print(profileData);

      _name = profileData['name'];

      notifyListeners();
      final prefs = await SharedPreferences.getInstance();
      final userData = json.encode({
        'idToken': _idtoken,
        'localId': _localId,
        'email': _email,
        'refreshToken': _refreshToken,
        'expiryDate': _expiryDate.toIso8601String(),
        'name': _name,
      });
      prefs.setString('userData', userData);
    } catch (err) {
      throw err;
    }
  }

  Future<void> signup(String name, String email, String password) async {
    return _authenticate(email, password, name, "signUp");
  }

  Future<void> login(String email, String password) async {
    return _authenticate(email, password, "", "signInWithPassword");
  }

  Future<bool> tryAutoLogin() async {
    // print("iamhere");
    final prefs = await SharedPreferences.getInstance();
    final data = prefs.getString("userData");
    if (data == null) {
      return false;
    }
    final extractedUserData = json.decode(data);
    final expiryDate = DateTime.parse(extractedUserData['expiryDate']);
    if (expiryDate.isBefore(DateTime.now())) {
      return false;
    }

    _idtoken = extractedUserData['idToken'];
    _localId = extractedUserData['localId'];
    _email = extractedUserData['email'];
    _refreshToken = extractedUserData['refreshToken'];
    _expiryDate = expiryDate;
    _name = extractedUserData['name'];

    // prefs.remove('userData');

    notifyListeners();
    // print("iamhere");
    return true;
    // return await _authenticate(email, password, "", "signInWithPassword");
  }

  // void login(String email, String password) {
  //   _isAuthenticated = true;
  // }

  // void register(String name, String email, String password) {
  //   print('Registering $name, $email');
  // }
}
