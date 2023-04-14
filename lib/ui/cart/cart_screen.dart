import 'package:flutter/material.dart';
import 'package:myproject_app/ui/orders/order_manager.dart';
import 'package:provider/provider.dart';
import 'cart_item_card.dart';
import 'cart_manager.dart';

class CartScreen extends StatelessWidget {
  static const routeName = '/cart';
  const CartScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final cart = context.watch<CartManager>();

    return Scaffold(
      appBar: AppBar(
        title: const Text('My Cart'),
      ),
      body: Column(
        children: <Widget>[
          const SizedBox(
            height: 10,
          ),
          Expanded(
            child: buildCartDetail(cart),
          ),
          buildCartSummary(cart, context),
        ],
      ),
    );
  }

  Widget buildCartDetail(CartManager cart) {
    return ListView(
      children: cart.productEntries
          .map(
            (entry) => CartItemCard(
              productId: entry.key,
              cardItem: entry.value,
            ),
          )
          .toList(),
    );
  }

  Widget buildCartSummary(CartManager cart, BuildContext context) {
    return Container(
      // margin: const EdgeInsets.symmetric(
      //   horizontal: 15,
      // ),
      decoration: new BoxDecoration(boxShadow: [
        new BoxShadow(
            color: Color.fromARGB(255, 222, 222, 222), blurRadius: 5.0)
      ]),
      child: Card(
        child: Column(
          children: <Widget>[
            ListTile(
              leading: Text(
                '${cart.productCount} items',
                style: const TextStyle(fontSize: 18),
              ),
              trailing: Text(
                'Total \$${cart.totalAmount.toStringAsFixed(2)}',
                style: const TextStyle(fontSize: 18),
              ),
            ),
            const Divider(),
            ElevatedButton(
              onPressed: cart.totalAmount <= 0
                  ? null
                  : () {
                      context.read<OrdersManager>().addOrder(
                            cart.products,
                            cart.totalAmount,
                          );
                      cart.clear();
                    },
              style: ElevatedButton.styleFrom(
                  backgroundColor: Color.fromRGBO(224, 139, 139, 1),
                  minimumSize: const Size.fromHeight(40)),
              child: const Text(
                'CHECK OUT',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 18,
                ),
              ),
            ),
          ],
        ),
      ),
    );
    // return Card(
    //   margin: const EdgeInsets.all(15),
    //   child: Padding(
    //     padding: const EdgeInsets.all(8),
    //     child: Column(
    //       mainAxisAlignment: MainAxisAlignment.spaceBetween,
    //       children: <Widget>[
    //         Chip(
    //           label: Text(
    //             '${cart.productCount} items',
    //             style: const TextStyle(
    //                 color: Color.fromARGB(255, 86, 83, 83), fontSize: 16),
    //           ),
    //           backgroundColor: Colors.white,
    //         ),
    //         const Spacer(),
    //         Chip(
    //           label: Text(
    //             '\$${cart.totalAmount.toStringAsFixed(2)}',
    //             style: TextStyle(
    //               color: Theme.of(context).primaryTextTheme.titleLarge?.color,
    //             ),
    //           ),
    //           backgroundColor: Theme.of(context).primaryColor,
    //         ),
    //         const Divider(),
    //         TextButton(
    //           onPressed: cart.totalAmount <= 0
    //               ? null
    //               : () {
    //                   context.read<OrdersManager>().addOrder(
    //                         cart.products,
    //                         cart.totalAmount,
    //                       );
    //                   cart.clear();
    //                 },
    //           style: TextButton.styleFrom(
    //             textStyle: TextStyle(color: Theme.of(context).primaryColor),
    //           ),
    //           child: const Text('CHECK OUT'),
    //         ),
    //       ],
    //     ),
    //   ),
    // );
  }
}
