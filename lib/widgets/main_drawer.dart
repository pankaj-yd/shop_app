import 'package:flutter/material.dart';
import 'package:shop_app/screens/orders_screen.dart';

class MainDrawer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Column(
        children: <Widget>[
          AppBar(
            title: Text('Hello!'),
            automaticallyImplyLeading: false,
          ),
          Divider(),
          ListTile(
            leading: Icon(
              Icons.shop,
              size: 30,
            ),
            title: Text(
              'Go to Shop',
              style: TextStyle(
                fontFamily: 'Lato',
                fontSize: 20,
              ),
            ),
            onTap: () {
              Navigator.of(context).pushReplacementNamed("/");
            },
          ),
          Divider(),
          ListTile(
            leading: Icon(
              Icons.payment, 
              size: 30,
            ),
            title: Text(
              'Go to Orders',
              style: TextStyle(
                fontFamily: 'Lato',
                fontSize: 20,
              ),
            ),
            onTap: () {
              Navigator.of(context)
                  .pushReplacementNamed(OrdersScreen.routeName);
            },
          ),
        ],
      ),
    );
  }
}
