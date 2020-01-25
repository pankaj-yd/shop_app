import 'package:flutter/widgets.dart';

class CartItem {
  final String id;
  final String title;
  final int quantity;
  final double price;

  CartItem({
    @required this.title,
    @required this.id,
    @required this.price,
    @required this.quantity,
  });
}

class Cart with ChangeNotifier {
  Map<String, CartItem> _items = {};

  Map<String, CartItem> get items {
    return {..._items};
  }

  int get itemCount {
    int total = 0;
    _items.forEach((key, cartItem) {
      total += cartItem.quantity;
    });
    return total;
  }

  double get totalAmount {
    double total = 0;
    _items.forEach((key, cartItem) {
      total += cartItem.price * cartItem.quantity;
    });
    return total;
  }

  void addItem(
    String productId,
    double price,
    String title,
  ) {
    if (_items.containsKey(productId)) {
      // change quantity
      _items.update(
        productId,
        (existingCard) => CartItem(
          id: existingCard.id,
          title: existingCard.title,
          price: existingCard.price,
          quantity: existingCard.quantity + 1,
        ),
      );
    } else {
      _items.putIfAbsent(
        productId,
        () => CartItem(
          id: DateTime.now().toString(),
          title: title,
          price: price,
          quantity: 1,
        ),
      );
    }
    notifyListeners();
  }

  void removeItem(String productId) {
    _items.remove(productId);
    notifyListeners();
  }

  void clean(){
    _items = {};
    notifyListeners();
  }

  void removeSingleItem(String productId) {
    if(!_items.containsKey(productId)){
      return;
    }

    if (_items[productId].quantity > 1) {
      _items.update(
          productId,
          (prevItem) => CartItem(
                id: prevItem.id,
                title: prevItem.title,
                price: prevItem.price,
                quantity: prevItem.quantity - 1,
              ));
    } else {
      _items.remove(productId);
    }
    notifyListeners();
  }
}
