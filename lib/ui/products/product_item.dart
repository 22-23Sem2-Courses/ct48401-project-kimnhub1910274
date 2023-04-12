import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import '../../ui/cart/cart_manager.dart';
import '../../ui/products/products_manager.dart';
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
                Container(
                  height: 150.0,
                  width: 300,
                  child: Ink.image(
                    image: NetworkImage(product.imageUrl),
                    fit: BoxFit.cover,
                  ),
                ),
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
                ButtonBar(
                  children: [
                    TextButton(
                      child: const Text(
                        'ADD TO CART',
                        style: TextStyle(fontWeight: FontWeight.w600),
                      ),
                      onPressed: () {
                        final cart = context.read<CartManager>();
                        cart.addItem(product);
                        ScaffoldMessenger.of(context)
                          ..hideCurrentSnackBar()
                          ..showSnackBar(
                            SnackBar(
                              content: const Text('Item added to cart'),
                              duration: const Duration(seconds: 2),
                              action: SnackBarAction(
                                label: 'UNDO',
                                onPressed: () {
                                  cart.removeSingleItem(product.id!);
                                },
                              ),
                            ),
                          );
                      },
                    ),
                  ],
                )
              ],
            )));
  }
}
