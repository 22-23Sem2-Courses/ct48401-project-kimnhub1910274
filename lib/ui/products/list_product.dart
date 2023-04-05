import 'package:flutter/material.dart';
import '/ui/products/products_manager.dart';
import 'package:provider/provider.dart';
import '../../models/product.dart';
import 'edit_product.dart';
// import '../screen.dart';

class AdminProductListTile extends StatelessWidget {
  final Product product;
  const AdminProductListTile(this.product, {super.key});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(product.title),
      leading: CircleAvatar(
        backgroundImage: NetworkImage(product.imageUrl),
      ),
      trailing: SizedBox(
        width: 100,
        child: Row(
          children: <Widget>[
            buildEditButton(context),
            buildDeleteButton(context),
          ],
        ),
      ),
    );
  }

  Widget buildDeleteButton(BuildContext context) {
    return IconButton(
      icon: const Icon(Icons.delete),
      onPressed: () {
        //  context.read<ProductsManager>().deleteProduct(product.id!);
        ScaffoldMessenger.of(context)
          ..hideCurrentSnackBar()
          ..showSnackBar(
            const SnackBar(
              content: Text(
                'Product deleted',
                textAlign: TextAlign.center,
              ),
            ),
          );
      },
      color: Theme.of(context).colorScheme.error,
    );
  }

  Widget buildEditButton(BuildContext context) {
    return IconButton(
      onPressed: () {
        Navigator.of(context)
            .pushNamed(EditProductScreen.routeName, arguments: product.id);
      },
      icon: const Icon(Icons.edit),
      color: Theme.of(context).primaryColor,
    );
  }
}
