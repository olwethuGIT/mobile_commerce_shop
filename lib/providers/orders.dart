import 'package:flutter/foundation.dart';
import '../models/order_item.dart';
import '../models/cart_item.dart';

class Orders with ChangeNotifier {
  final List<OrderItem> _orders = [];

  List<OrderItem> get orders {
    return [..._orders];
  }

  void addOrder(List<CartItem> cart, double total) {
    _orders.insert(0, OrderItem(
      id: DateTime.now().toString(),
      amount: total,
      dateTime: DateTime.now(),
      products: cart
    ));
    notifyListeners();
  }


}