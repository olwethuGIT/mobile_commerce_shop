import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import '../models/http_exception.dart';

class Auth with ChangeNotifier {
  final baseURl = 'https://10.0.2.2:44302/api/auth/';
  String? _token;
  DateTime? _expiryDate;
  String? _userId;

  bool get isAuth {
    return token != null;
  }

  String? get token {
    if (_expiryDate != null && _expiryDate!.isAfter(DateTime.now()) && _token != null) {
      return _token;
    }

    return null;
  }

  String? get userId {
    return _userId;
  }

  Future<void> _authenticate(String email, String password, Uri url) async {
    try {
      final response = await http.post(
          url,
          headers: {'Content-Type': 'application/json'},
          body: json.encode({
            'username': email,
            'password': password
          })
      );

      if (response.statusCode >= 400) {
        throw HttpException(response.body);
      }

      final responseData = json.decode(response.body);

      _token = responseData['token'];
      _userId = responseData['username'];
      _expiryDate = DateTime.parse(responseData['tokenExpiry']);
      notifyListeners();
    } catch (error) {
      rethrow;
    }
  }

  Future<void> signUp(String email, String password) async {
    var url = Uri.parse(baseURl + 'register');
    return _authenticate(email, password, url);
  }

  Future<void> login(String email, String password) async {
    var url = Uri.parse(baseURl + 'login');
    return _authenticate(email, password, url);
  }
}