import 'package:flutter/material.dart';
import 'package:myproject_app/ui/cart/cart_manager.dart';
import 'package:provider/provider.dart';
import '../../models/cart_item.dart';
import '../shared/dialog_utils.dart';

class CartItemCard extends StatelessWidget {
  final String productId;
  final CartItem cardItem;

  const CartItemCard({
    required this.productId,
    required this.cardItem,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Dismissible(
      key: ValueKey(cardItem.id),
      background: Container(
        color: Theme.of(context).colorScheme.error,
        alignment: Alignment.centerRight,
        padding: const EdgeInsets.only(right: 20),
        margin: const EdgeInsets.symmetric(
          horizontal: 15,
          vertical: 4,
        ),
        child: const Icon(
          Icons.delete,
          color: Colors.white,
          size: 40,
        ),
      ),
      direction: DismissDirection.endToStart,
      confirmDismiss: (direction) {
        return showConfirmDialog(
            context, 'Do you want to remove the item from the cart?');
      },
      onDismissed: (direction) {
        context.read<CartManager>().removeItem(productId);
      },
      child: buildItemCart(),
    );
  }

  Widget buildItemCart() {
    return SizedBox(
      // margin: const EdgeInsets.symmetric(
      //   horizontal: 15,
      //   vertical: 4,
      // ),
      child: Padding(
        padding: const EdgeInsets.all(8),
        child: ListTile(
          leading: ClipRRect(
            child: Image.network(cardItem.imageUrl,
                width: 100, height: 200, fit: BoxFit.fill),
          ),
          title: Text(cardItem.title, style: TextStyle(fontSize: 18)),
          subtitle: Text(
            '\$${(cardItem.price)}',
            style: const TextStyle(fontSize: 16),
          ),
          trailing: Text('${cardItem.quantity} x'),
        ),
      ),
    );
  }
}
