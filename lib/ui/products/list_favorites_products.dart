import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../shared/app_drawer.dart';
import 'product_grid_tile.dart';
import 'products_manager.dart';
import '../../models/product.dart';

class ListFavoritesProducts extends StatelessWidget {
  static const routeName = '/list-favorites';
  const ListFavoritesProducts({super.key});

  @override
  Widget build(BuildContext context) {
    final products = context.select<ProductsManager, List<Product>>(
        (productsManager) => productsManager.favoriteItems);

    return Scaffold(
        appBar: AppBar(
          title: const Text('List Favorites'),
        ),
        drawer: const AppDrawer(),
        body: Container(
          child: GridView.builder(
            padding: const EdgeInsets.all(10.0),
            itemCount: products.length,
            itemBuilder: (ctx, i) => ProductGridTile(products[i]),
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              //  childAspectRatio: 3 / 2,
              //  crossAxisSpacing: 10,
              mainAxisSpacing: 10,
            ),
          ),
        ));
  }
}
