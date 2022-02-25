import 'package:flutter/foundation.dart';
import '../models/cart_item.dart';

class Cart with ChangeNotifier {
  Map<String, CartItem> _items = {};

  Map<String, CartItem> get items {
    return {..._items};
  }

  int get itemCount {
    return _items.length;
  }

  double get totalAmount {
    var total = 0.0;
    _items.forEach((key, cartItem) {
      total += cartItem.price * cartItem.quantity;
    });

    return total;
  }

  void addItem(String productId, double price, String title) {
     if (_items.containsKey(productId)) {
       _items.update(
           productId,
               (existingItem) => CartItem(
                   id: existingItem.id,
                   title: existingItem.title,
                   quantity: existingItem.quantity + 1,
                   price: price
               ));
     } else {
       _items.putIfAbsent(
           productId,
               () => CartItem(
                   id: DateTime.now().toString(),
                   title: title,
                   price: price,
                   quantity: 1
               ));
     }
     notifyListeners();
  }

  void removeItem(String productId) {
    _items.remove(productId);
    notifyListeners();
  }

  void clear() {
    _items = {};
    notifyListeners();
  }
}