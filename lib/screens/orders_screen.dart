import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop_app/widgets/main_drawer.dart';

import '../widgets/order_item.dart';
import '../providers/orders.dart' show Orders;

class OrdersScreen extends StatelessWidget {
  static const routeName = '/orders';
  
  @override
  Widget build(BuildContext context) {
    final orderData = Provider.of<Orders>(context);
    return Scaffold(
      appBar: AppBar(
        title: Text('My Orders'),
      ),
      drawer: MainDrawer(),
      body: ListView.builder(
        itemBuilder: (ctx, i){
          return OrderItem(orderData.orders[i]);
        },
        itemCount: orderData.orders.length,
      ),
    );
  }
}
