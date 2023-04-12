import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
// import 'package:myshop/ui/cart/cart_manager.dart';
// import 'package:myshop/ui/products/products_manager.dart';
import 'package:provider/provider.dart';
import '../../models/product.dart';
import '../products/products_manager.dart';

class ProductDetail extends StatelessWidget {
  static const routeName = '/product-detail';
  const ProductDetail(
    this.product, {
    super.key,
  });
  final Product product;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          // title: Text(product.title),
          ),
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            SizedBox(
                height: 300,
                width: double.infinity,
                child: Image.network(
                  product.imageUrl,
                  fit: BoxFit.cover,
                )),
            const SizedBox(height: 10),
            ListTile(
              title: Padding(
                padding: const EdgeInsets.only(
                  bottom: 3,
                ),
                child: Text(
                  product.title,
                  style: const TextStyle(
                      fontSize: 18, fontWeight: FontWeight.w600),
                ),
              ),
              subtitle: Text(
                '\$${product.price}',
                style: const TextStyle(
                  fontSize: 18,
                  color: Colors.red,
                ),
                softWrap: true,
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
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 18),
              width: double.infinity,
              child: Text(
                product.description,
                style: const TextStyle(
                  fontSize: 17,
                ),
                softWrap: true,
              ),
            ),
            const SizedBox(
              height: 30,
            ),
            ElevatedButton(
              onPressed: () {},
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: const [
                  Icon(
                    // <-- Icon
                    Icons.shopping_cart,
                    size: 24.0,
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  Text(
                    'Add to cart',
                    style: TextStyle(fontSize: 18),
                  ), // <-- Text
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
