import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import '../models/product_color.dart';
import '../models/product_photo.dart';
import '../models/http_exception.dart';

import 'product.dart';

class Products with ChangeNotifier {
  final String? token;
  final String? userId;
  final baseURl = 'https://10.0.2.2:44302/api/store/';
  List<Product>? _items = [];

  Products(this.token, this.userId, this._items);

  List<Product> get items {
    return [..._items!];
  }

  List<Product> get favoriteItems {
    return _items!.where((prod) => prod.isFavourite).toList();
  }

  Product findById(String id) {
    return _items!.firstWhere((p) => p.id == id);
  }

  Future<void> getProducts() async {
    var url = Uri.parse(baseURl + 'get-products/$userId');

    try {
      final response = await http.get(
          url,
          headers: {
            HttpHeaders.contentTypeHeader: 'application/json',
            HttpHeaders.acceptHeader: 'application/json',
            HttpHeaders.authorizationHeader: "Bearer $token"
          });
      final productList = json.decode(response.body) as List<dynamic>;
      final List<Product> loadedProducts = [];

      
      for (var productData in productList) {
        loadedProducts.add(Product(
            id: productData['id'].toString(),
            title: productData['title'],
            description: productData['description'],
            price: productData['price'],
            isFavourite: productData['isFavorite'],
            photos: (productData['photos'] as List<dynamic>).map((photo) =>  ProductPhoto(
                id: photo['id'],
                url: photo['url'],
                dateAdded: DateTime.parse(photo['dateAdded']),
                productId: photo['productId']
            )).toList(),
            colors: (productData['colors'] as List<dynamic>).map((color) =>  ProductColor(
                id: color['id'],
                colorCode: color['colorCode'],
                dateAdded: DateTime.parse(color['dateAdded']),
                productId: color['productId']
            )).toList()
        ));
      }

      _items = loadedProducts;
    } catch (error) {
      // log error in the database with the user id
      rethrow;
    }
  }

  Future<void> addProduct(Product product) async {
    var url = Uri.parse(baseURl + 'add-product');

    try {
      final response = await http.post(
          url,
          headers: {
            HttpHeaders.contentTypeHeader: 'application/json',
            HttpHeaders.acceptHeader: 'application/json',
            HttpHeaders.authorizationHeader: "Bearer $token"
          },
          body: json.encode({
            'title': product.title,
            'description': product.description,
            //'imageUrl': product.imageUrl,
            'price': product.price
          }));

      final newProduct = Product (
          title: product.title,
          description: product.description,
          price: product.price,
          //imageUrl: product.imageUrl,
          id: json.decode(response.body)['id'].toString(),
          photos: [],
          colors: []
      );

      _items!.add(newProduct);
      notifyListeners();
    } catch (error) {
      // log the error with the error code, error message and the user id to the database.
      print(error.toString());
      rethrow;
    }
  }

  Future<void> updateProduct(String id, Product product)  async{
    final prodIndex = _items!.indexWhere((prod) => prod.id == id);

    // Remember to include try catch
    if(prodIndex >= 0 ) {
      var url = Uri.parse(baseURl + 'update-product');

      await http.patch(
          url,
          headers: {
            HttpHeaders.contentTypeHeader: 'application/json',
            HttpHeaders.acceptHeader: 'application/json',
            HttpHeaders.authorizationHeader: "Bearer $token"
          },
          body: json.encode({
            'id': product.id,
            'title': product.title,
            'description': product.description,
            //'imageUrl': product.imageUrl,
            'price': product.price
          }));

      _items![prodIndex] = product;
      notifyListeners();
    } else {
      print('...');
    }
  }

  Future<void> deleteProduct(String id) async {
    var url = Uri.parse(baseURl + 'delete-product/$id');
    final tempProductIndex = _items!.indexWhere((prod) => prod.id == id);
    var tempProduct = _items![tempProductIndex];
    _items!.removeAt(tempProductIndex);

    notifyListeners();

    final response = await http.delete(
        url,
        headers: {
          HttpHeaders.contentTypeHeader: 'application/json',
          HttpHeaders.acceptHeader: 'application/json',
          HttpHeaders.authorizationHeader: "Bearer $token"
        });

    if (response.statusCode >= 400) {
      _items!.insert(tempProductIndex, tempProduct);
      notifyListeners();
      throw HttpException('Could not delete product.');
    }
  }
}