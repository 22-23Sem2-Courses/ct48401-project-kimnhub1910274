import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../products/product_grid_tile.dart';
import '../products/products_manager.dart';

import '../../models/product.dart';

class SearchScreen extends StatefulWidget {
  // static const routeName = '/';
  const SearchScreen({super.key});

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  TextEditingController controller = TextEditingController();

  @override
  void initState() {
    // products = context.select<ProductsManager, List<Product>>(
    //     (productsManager) => productsManager.items);
    // all = List.from(products);
    super.initState();
  }

  void updateList(String value) {
    List results = [];
    // final sug = all.where((product) {
    //   final title = product.title.toLowerCase();
    //   final input = value.toLowerCase();
    //   return title.contains(input);
    // }).toList();
    if (value.isEmpty) {
      // if the search field is empty or only contains white-space, we'll display all users
      //    results = products;
    } else {
      // results = products
      //     .where((product) =>
      //         product.title.toLowerCase().contains(value.toLowerCase()))
      //     .toList();
      // print('First text field: $results');
      // setState(() => products = results);
    }
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // List products = context.select<ProductsManager, List<Product>>(
    //     (productsManager) => productsManager.items);

    return Scaffold(
        appBar: AppBar(
          title: const Text('Search'),
        ),
        body: Column(
          children: <Widget>[
            Container(
                margin: const EdgeInsets.fromLTRB(16, 16, 16, 16),
                child: TextFormField(
                  controller: controller,
                  autofocus: true,
                  decoration: InputDecoration(
                      prefixIcon: const Icon(Icons.search),
                      hintText: 'Search...',
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(20),
                          borderSide: const BorderSide(color: Colors.blue))),
                  onChanged: (value) => updateList(value),
                  // onChanged: (text) {
                  //   print('First text field: $text');
                  // },
                )),
            // Expanded(
            //   child: ListView.builder(
            //     padding: const EdgeInsets.all(10.0),
            //     itemCount: products.length,
            //     itemBuilder:
            //         // (ctx, i) => ProductGridTile(products[i]),
            //         (ctx, i) {
            //       final product = products[i];
            //       return ListTile(
            //         leading: Image.network(product.imageUrl),
            //         title: Text(product.title),
            //       );
            //     },
            //     // gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            //     //   crossAxisCount: 2,
            //     //   //  childAspectRatio: 3 / 2,
            //     //   //  crossAxisSpacing: 10,
            //     //   mainAxisSpacing: 10,
            //     // ),
            //   ),
            // )
          ],
        ));
  }
}
