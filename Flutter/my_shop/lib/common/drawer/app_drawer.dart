import 'package:flutter/material.dart';
import 'package:my_shop/providers/auth_provider.dart';
import 'package:provider/provider.dart';

import '../../common/routes/routes.dart';

class AppDrawer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Column(
        children: [
          AppBar(
            title: Text('Hello Friend!'),
            automaticallyImplyLeading: false,
          ),
          Divider(),
          ListTile(
            leading: Icon(Icons.shop),
            title: Text('Shop'),
            onTap: () {
              Navigator.of(context).pop();
              Navigator.of(context).pushReplacementNamed(RouteNames.root.routePath);
            },
          ),
          Divider(),
          ListTile(
            leading: Icon(Icons.payment),
            title: Text('Orders'),
            onTap: () {
              Navigator.of(context).pushReplacementNamed(RouteNames.orders.routePath);
            },
          ),
          Divider(),
          ListTile(
            leading: Icon(Icons.edit),
            title: Text('Manage Products'),
            onTap: () {
              Navigator.of(context).pushReplacementNamed(RouteNames.userProducts.routePath);
            },
          ),
          Divider(),
          ListTile(
            leading: Icon(Icons.exit_to_app),
            title: Text('Logout'),
            onTap: () {
              // Navigator.of(context).pushReplacementNamed(RouteNames.userProducts.routePath);
              Navigator.of(context).pop();
              Provider.of<AuthProvider>(context, listen: false).logout();
            },
          ),
        ],
      ),
    );
  }
}
