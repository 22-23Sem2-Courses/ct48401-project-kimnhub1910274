import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

// import '../orders/orders_screen.dart';
// import '../products/user_products_screen.dart';
import '../auth/auth_manager.dart';

class AppDrawer extends StatelessWidget {
  const AppDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Column(
        children: <Widget>[
          AppBar(
            title: const Text(
              'Furniture',
              style: TextStyle(fontSize: 23),
            ),
            automaticallyImplyLeading: false,
          ),
          ListTile(
            leading: const Icon(Icons.home),
            title: const Text(
              'Home',
              style: TextStyle(fontSize: 17),
            ),
            onTap: () {
              Navigator.of(context).pushReplacementNamed('/');
            },
          ),
          const Divider(),
          ListTile(
            leading: const Icon(Icons.shop),
            title: const Text(
              'Orders',
              style: TextStyle(fontSize: 17),
            ),
            onTap: () {
              Navigator.of(context).pushReplacementNamed('/orders');
            },
          ),
          const Divider(),
          ListTile(
            leading: const Icon(Icons.edit),
            title: const Text(
              'Manager Products',
              style: TextStyle(fontSize: 17),
            ),
            onTap: () {
              Navigator.of(context).pushReplacementNamed('/admin-products');
            },
          ),
          const Divider(),
          ListTile(
            leading: const Icon(Icons.list),
            title: const Text(
              'List Favorites',
              style: TextStyle(fontSize: 17),
            ),
            onTap: () {
              Navigator.of(context).pushReplacementNamed('/list-favorites');
            },
          ),
          const Divider(),
          ListTile(
            leading: const Icon(Icons.exit_to_app),
            title: const Text(
              'Logout',
              style: TextStyle(fontSize: 17),
            ),
            onTap: () {
              Navigator.of(context)
                ..pop()
                ..pushReplacementNamed('/');
              context.read<AuthManager>().logout();
            },
          ),
        ],
      ),
    );
  }
}
