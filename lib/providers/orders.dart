import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import './cart.dart';

class OrderItem {
  final String id;
  final double amount;
  final List<CartItem> products;
  final DateTime dateTime;

  OrderItem({
    @required this.id,
    @required this.amount,
    @required this.dateTime,
    @required this.products,
  });
}

class Orders with ChangeNotifier {
  final authToken;
  final userId;

  List<OrderItem> _orders = [];

  Orders(this.authToken, this._orders, this.userId);

  List<OrderItem> get orders {
    return [..._orders];
  }

  Future<void> fetchAndSetOrders() async {
    final url = 'https://my-shop-88874.firebaseio.com/orders/$userId.json?auth=$authToken';
    final response = await http.get(url);
    final extractedData = json.decode(response.body) as Map<String, dynamic>;

    if(extractedData == null){
      return;
    }

    final List<OrderItem> loadedOrders = [];
    // print(extractedData);
    extractedData.forEach((ordId, ordData) {
      loadedOrders.add(
        OrderItem(
          id: ordId,
          amount: ordData['amount'],
          dateTime: DateTime.parse(ordData['dateTime']),
          products: (ordData['products'] as List<dynamic>)
              .map((item) => CartItem(
                    title: item['title'],
                    id: item['id'],
                    price: item['price'],
                    quantity: item['quantity'],
                  ))
              .toList(),
        ),
      );
    });
    _orders = loadedOrders.reversed.toList();
    notifyListeners();
  }

  Future<void> addOrder(List<CartItem> cartProducts, double total) async {
    final url = 'https://my-shop-88874.firebaseio.com/orders/$userId.json?auth=$authToken';
    final timestamp = DateTime.now();
    try {
      final response = await http.post(
        url,
        body: json.encode({
          'amount': total,
          'dateTime': timestamp.toIso8601String(),
          'products': cartProducts
              .map((cartProd) => {
                    'id': cartProd.id,
                    'price': cartProd.price,
                    'quantity': cartProd.quantity,
                    'title': cartProd.title,
                  })
              .toList(),
        }),
      );
      _orders.insert(
          0,
          OrderItem(
            id: jsonDecode(response.body)['name'],
            amount: total,
            dateTime: timestamp,
            products: cartProducts,
          ));
      notifyListeners();
    } catch (error) {
      print(error);
    }
  }
}
