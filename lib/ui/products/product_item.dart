import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
// import 'package:myshop/ui/cart/cart_manager.dart';
// import 'package:myshop/ui/products/products_manager.dart';
import 'package:provider/provider.dart';

import '../../models/product.dart';
import '../products/products_manager.dart';

class ProductItem extends StatelessWidget {
  const ProductItem(
    this.product, {
    super.key,
  });
  final Product product;

  @override
  Widget build(BuildContext context) {
    return Container(
        child: Card(
            margin: const EdgeInsets.all(10),
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
            clipBehavior: Clip.antiAliasWithSaveLayer,
            elevation: 5,
            child: Column(
              children: <Widget>[
                ListTile(
                  title: Padding(
                    padding: const EdgeInsets.only(
                      bottom: 3,
                    ),
                    child: Text(
                      product.title,
                      style: const TextStyle(fontSize: 18),
                    ),
                  ),
                  subtitle: Text(
                    '\$${product.price}',
                    style: const TextStyle(
                      color: Colors.grey,
                      fontSize: 16,
                    ),
                  ),
                  trailing: ValueListenableBuilder<bool>(
                    valueListenable: product.isFavoriteListenable,
                    builder: (ctx, isFavorite, child) {
                      return IconButton(
                        icon: Icon(
                          isFavorite ? Icons.favorite : Icons.favorite_border,
                        ),
                        color: Theme.of(context).colorScheme.error,
                        onPressed: () {
                          // product.isFavorite = !isFavorite;
                          ctx
                              .read<ProductsManager>()
                              .toggleFavoriteStatus(product);
                        },
                      );
                    },
                  ),
                ),
                Container(
                  height: 100.0,
                  width: 300,
                  child: Ink.image(
                    image: NetworkImage(product.imageUrl),
                    fit: BoxFit.cover,
                  ),
                ),
                Container(
                  // padding: EdgeInsets.all(5.0),
                  alignment: Alignment.centerLeft,
                ),
                ButtonBar(
                  children: [
                    TextButton(
                      child: const Text(
                        'ADD TO CART',
                        style: TextStyle(fontWeight: FontWeight.w600),
                      ),
                      onPressed: () {/* ... */},
                    ),
                  ],
                )
              ],
            )));
  }
}
