import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'list_product.dart';
import 'products_manager.dart';
import '../shared/app_drawer.dart';
import 'edit_product.dart';

class AdminProductsScreen extends StatelessWidget {
  static const routeName = '/admin-products';
  const AdminProductsScreen({super.key});

  Future<void> _refreshProducts(BuildContext context) async {
    await context.read<ProductsManager>().fetchProducts(true);
  }

  @override
  Widget build(BuildContext context) {
    // final productManager = ProductsManager();
    return Scaffold(
      appBar: AppBar(
        title: const Text('Your Products'),
        actions: <Widget>[
          buildAddButton(context),
        ],
      ),
      drawer: const AppDrawer(),
      body: FutureBuilder(
        future: _refreshProducts(context),
        builder: (ctx, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
          return RefreshIndicator(
            child: buildUserProductListView(),
            onRefresh: () => _refreshProducts(context),
          );
        },
      ),
    );
  }

  Widget buildUserProductListView() {
    return Consumer<ProductsManager>(
      builder: (ctx, productsManager, child) {
        print(productsManager.itemCount);
        return ListView.builder(
          itemCount: productsManager.itemCount,
          itemBuilder: (ctx, i) => Column(
            children: [
              AdminProductListTile(
                productsManager.items[i],
              ),
              const Divider(),
            ],
          ),
        );
      },
    );
  }

  Widget buildAddButton(BuildContext context) {
    return IconButton(
      onPressed: () {
        Navigator.of(context).pushNamed(
          EditProductScreen.routeName,
        );
      },
      icon: const Icon(Icons.add),
    );
  }
}
