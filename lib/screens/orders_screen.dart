import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../widgets/main_drawer.dart';
import '../widgets/order_item.dart';
import '../providers/orders.dart' show Orders;

class OrdersScreen extends StatefulWidget {
  static const routeName = '/orders';

  @override
  _OrdersScreenState createState() => _OrdersScreenState();
}

class _OrdersScreenState extends State<OrdersScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('My Orders'),
      ),
      drawer: MainDrawer(),
      body: FutureBuilder(
        future: Provider.of<Orders>(context, listen: false).fetchAndSetOrders(),
        builder: (ctx, dataSnapshot) {
          if (dataSnapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else {
            if (dataSnapshot.error != null) {
              return Center(
                child: Text('An error occured!'),
              );
            } else {
              return Consumer<Orders>(
                builder: (ctx, orderData, child) {
                  return ListView.builder(
                    itemBuilder: (ctx, i) {
                      return OrderItem(orderData.orders[i]);
                    },
                    itemCount: orderData.orders.length,
                  );
                },
              );
            }
          }
        },
      ),
    );
  }
}
