import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class Auth with ChangeNotifier {
  // String _token;
  // DateTime _expiry;
  // String _userId;
  bool _isAuthenticated = false;

  bool get isAuth {
    return _isAuthenticated;
  }

  Future<void> signup(String email, String password) async {
    var url = Uri.https("abc", "/unencodedPath");
    await http.post(url, body: json.encode({email: email, password: password}));
  }

  void login(String email, String password) {
    _isAuthenticated = true;
  }

  void register(String name, String email, String password) {
    print('Registering $name, $email');
  }
}
