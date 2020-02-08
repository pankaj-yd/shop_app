import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../helpers/customRoute.dart';

import '../screens/orders_screen.dart';
import '../screens/user_products_screen.dart';
import '../providers/auth.dart';

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
              // size: 30,
            ),
            title: Text(
              'Go to Shop',
              style: TextStyle(
                fontFamily: 'Lato',
                // fontSize: 20,
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
              // size: 30,
            ),
            title: Text(
              'Go to Orders',
              style: TextStyle(
                fontFamily: 'Lato',
                // fontSize: 20,
              ),
            ),
            onTap: () {
              // Navigator.of(context)
              //     .pushReplacementNamed(OrdersScreen.routeName);
              Navigator.of(context).pushReplacement(CustomRoute(
                builder: (ctx) => OrdersScreen(),
              ));
            },
          ),
          Divider(),
          ListTile(
            leading: Icon(
              Icons.edit, 
              // size: 30,
            ),
            title: Text(
              'Manage Products',
              style: TextStyle(
                fontFamily: 'Lato',
                // fontSize: 20,
              ),
            ),
            onTap: () {
              Navigator.of(context)
                  .pushReplacementNamed(UserProductsScreen.routeName);
            },
          ),
          Divider(),
          ListTile(
            leading: Icon(
              Icons.exit_to_app, 
              // size: 30,
            ),
            title: Text(
              'Log out',
              style: TextStyle(
                fontFamily: 'Lato',
                // fontSize: 20,
              ),
            ),
            onTap: () {
              Navigator.of(context).pop();
              // Navigator.of(context).pushReplacementNamed('/');
              Provider.of<Auth>(context, listen:false).logout();
            },
          ),
        ],
      ),
    );
  }
}
