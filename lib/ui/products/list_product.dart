import 'package:flutter/material.dart';
import 'package:myproject_app/ui/shared/dialog_utils.dart';
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
        // showConfirmDialog(context, 'Are you sure detele');
        context.read<ProductsManager>().deleteProduct(product.id!);
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
    // return Dismissible(
    //   background: Container(
    //     color: Theme.of(context).colorScheme.error,
    //     alignment: Alignment.centerRight,
    //     padding: const EdgeInsets.only(right: 20),
    //     margin: const EdgeInsets.symmetric(
    //       horizontal: 15,
    //       vertical: 4,
    //     ),
    //     child: const Icon(
    //       Icons.delete,
    //       color: Colors.white,
    //       size: 40,
    //     ),
    //   ),
    //   direction: DismissDirection.endToStart,
    //   confirmDismiss: (direction) {
    //     return showConfirmDialog(
    //         context, 'Do you want to remove the item from the cart?');
    //   },
    //   onDismissed: (direction) {
    //     context.read<ProductsManager>().deleteProduct(productId);
    //   },
    // child: buildItemCart(),
    // );
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
