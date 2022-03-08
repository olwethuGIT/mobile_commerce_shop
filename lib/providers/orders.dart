import 'dart:convert';
import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import '../models/order_item.dart';
import '../models/cart_item.dart';

class Orders with ChangeNotifier {
  final baseURl = 'https://10.0.2.2:44302/api/store/';
  List<OrderItem> _orders = [];
  final String? token;
  final String? userId;

  Orders(this.token, this.userId,this._orders);

  List<OrderItem> get orders {
    return [..._orders];
  }

 Future<void> getOrders() async {
   var url = Uri.parse(baseURl + 'get-orders/$userId');

   try {
     final response =  await http.get(
         url,
         headers: {
           HttpHeaders.contentTypeHeader: 'application/json',
           HttpHeaders.acceptHeader: 'application/json',
           HttpHeaders.authorizationHeader: "Bearer $token"
         });

     final orderList = json.decode(response.body) as List<dynamic>;
     final List<OrderItem> loadedProducts = [];

     if (orderList == null) {
       return;
     }

     for (var productData in orderList) {
       loadedProducts.add(OrderItem(
           id: productData['id'].toString(),
           amount: productData['amount'],
           dateTime: DateTime.parse(productData['createdAt']),
           products: (productData['products'] as List<dynamic>).map((cartItem) =>  CartItem(
               id: cartItem['id'],
               title: cartItem['title'],
               price: cartItem['price'],
               quantity: cartItem['quantity']
             )).toList()
       ));
     }

     _orders = loadedProducts.reversed.toList();
     notifyListeners();
   } catch (error) {
     // log error in the database with the user id
     rethrow;
   }
 }

  Future<void> addOrder(List<CartItem> cartProducts, double total) async {
    var url = Uri.parse(baseURl + 'add-order');
    final timeStamp = DateTime.now();
    var body = json.encode({
      'amount': total,
      'createdAt': timeStamp.toIso8601String(),
      'products': cartProducts.map((cart) => {
        'id': cart.id,
        'title': cart.title,
        'quantity': cart.quantity,
        'price': cart.price,
        'username': userId
      }).toList()});

    try {
      await http.post(
          url,
          headers: {
            HttpHeaders.contentTypeHeader: 'application/json',
            HttpHeaders.acceptHeader: 'application/json',
            HttpHeaders.authorizationHeader: "Bearer $token"
          },
          body: body
      ).then((response) {

        print(response.body);
      });
    } catch (error) {
      print(error.toString());
    }
    // _orders.insert(0, OrderItem(
    //   id: json.decode(response.body)['id'],
    //   amount: total,
    //   dateTime: timeStamp,
    //   products: cartProducts
    // ));
    notifyListeners();
  }
}