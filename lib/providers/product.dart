import 'dart:convert';
import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;

class Product with ChangeNotifier {
  final String id;
  final String title;
  final String description;
  final double price;
  final String imageUrl;
  late bool isFavourite;

  Product({
    required this.id,
    required this.title,
    required this.description,
    required this.price,
    required this.imageUrl,
    this.isFavourite = false
  });

  Future<void> toggleFavouriteStatus(String? token, String? userId) async {
    var url = Uri.parse('https://10.0.2.2:44302/api/store/toggle-product-favorite-status');
    final oldStatus = isFavourite;
    isFavourite = !isFavourite;
    notifyListeners();

    try{
      final response = await http.put(
          url,
          headers: {
            HttpHeaders.contentTypeHeader: 'application/json',
            HttpHeaders.acceptHeader: 'application/json',
            HttpHeaders.authorizationHeader: "Bearer $token"
          },
          body: json.encode({
            'username': userId,
            'productId': id,
            'isFavorite': isFavourite
          }));

      if (response.statusCode >= 400) {
        isFavourite = oldStatus;
        notifyListeners();
      }
    } catch(error) {
      isFavourite = oldStatus;
      notifyListeners();
    }

    notifyListeners();
  }
}