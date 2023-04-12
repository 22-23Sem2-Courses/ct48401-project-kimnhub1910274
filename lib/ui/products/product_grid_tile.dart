import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
//import 'package:myshop/ui/cart/cart_manager.dart';
//import 'package:myshop/ui/products/products_manager.dart';
import 'package:provider/provider.dart';

import '../../models/product.dart';
import 'product_detail.dart';
import '../products/products_manager.dart';

class ProductGridTile extends StatelessWidget {
  const ProductGridTile(
    this.product, {
    super.key,
  });
  final Product product;

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 5,
      clipBehavior: Clip.antiAlias,
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Container(
              child: GestureDetector(
                onTap: () {
                  Navigator.of(context).pushNamed(
                    ProductDetail.routeName,
                    arguments: product.id,
                  );
                },
                child: Image.network(
                  product.imageUrl,
                  fit: BoxFit.cover,
                  height: 110,
                ),
              ),
            ),
            ListTile(
              title: Text(product.title),
              subtitle: Text(
                '\$${product.price}',
                style: TextStyle(color: Colors.black.withOpacity(0.6)),
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
                      ctx.read<ProductsManager>().toggleFavoriteStatus(product);
                    },
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
  //   return ClipRRect(
  //     borderRadius: BorderRadius.circular(10),
  //     child: Card(
  //       child: SingleChildScrollView(
  //           child: Column(
  //         children: [
  //           Container(
  //             child: GestureDetector(
  //               onTap: () {
  //                 // Navigator.of(context).pushNamed(
  //                 //   ProductDetailScreen.routeName,
  //                 //   arguments: product.id,
  //                 // );
  //               },
  //               child: Image.network(
  //                 product.imageUrl,
  //                 fit: BoxFit.cover,
  //               ),
  //             ),
  //           ),
  //           ListTile(
  //             title: Text(product.title),
  //             trailing: ValueListenableBuilder<bool>(
  //               valueListenable: product.isFavoriteListenable,
  //               builder: (ctx, isFavorite, child) {
  //                 return IconButton(
  //                   icon: Icon(
  //                     isFavorite ? Icons.favorite : Icons.favorite_border,
  //                   ),
  //                   color: Theme.of(context).colorScheme.secondary,
  //                   onPressed: () {
  //                     // product.isFavorite = !isFavorite;
  //                     ctx.read<ProductsManager>().toggleFavoriteStatus(product);
  //                   },
  //                 );
  //               },
  //             ),
  //           )
  //         ],
  //       )),
  //     ),
  //   );
  // }

  Widget buildGridFooterBar(BuildContext context) {
    return GridTileBar(
      backgroundColor: Colors.black87,
      leading: ValueListenableBuilder<bool>(
        valueListenable: product.isFavoriteListenable,
        builder: (ctx, isFavorite, child) {
          return IconButton(
            icon: Icon(
              isFavorite ? Icons.favorite : Icons.favorite_border,
            ),
            color: Theme.of(context).colorScheme.secondary,
            onPressed: () {
              // product.isFavorite = !isFavorite;
              ctx.read<ProductsManager>().toggleFavoriteStatus(product);
            },
          );
        },
      ),
      title: Text(
        product.title,
        textAlign: TextAlign.center,
      ),
      trailing: IconButton(
        icon: const Icon(
          Icons.shopping_cart,
        ),
        onPressed: () {
          //  final cart = context.read<CartManager>();
          //  cart.addItem(product);
          ScaffoldMessenger.of(context)
            ..hideCurrentSnackBar()
            ..showSnackBar(
              SnackBar(
                content: const Text('Item added to cart'),
                duration: const Duration(seconds: 2),
                action: SnackBarAction(
                  label: 'UNDO',
                  onPressed: () {
                    //   cart.removeSingleItem(product.id!);
                  },
                ),
              ),
            );
        },
        color: Theme.of(context).colorScheme.secondary,
      ),
    );
  }
}
