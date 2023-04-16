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
  final controller = TextEditingController();
  List<Product> products = [];

  //static List<Product> all;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Search'),
        ),
        body: Column(
          children: <Widget>[
            Container(
                margin: const EdgeInsets.fromLTRB(16, 16, 16, 16),
                child: TextField(
                  controller: controller,
                  decoration: InputDecoration(
                      prefixIcon: const Icon(Icons.search),
                      hintText: 'Search...',
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(20),
                          borderSide: const BorderSide(color: Colors.blue))),
                  onChanged: searchProducts,
                )),
            Expanded(
              child: GridView.builder(
                padding: const EdgeInsets.all(10.0),
                itemCount: products.length,
                itemBuilder: (ctx, i) {
                  final product = products[i];
                  return ListTile(
                    leading: Image.network(product.imageUrl),
                    title: Text(product.title),
                  );
                },
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  //  childAspectRatio: 3 / 2,
                  //  crossAxisSpacing: 10,
                  mainAxisSpacing: 10,
                ),
              ),
            )
          ],
        ));
  }

  void searchProducts(String query) {
    final sug = products.where((product) {
      final title = product.title.toLowerCase();
      final input = query.toLowerCase();
      return title.contains(input);
    }).toList();
    setState(() => products = sug);
  }
}
