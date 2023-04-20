import 'package:flutter/material.dart';
import 'package:myproject_app/main.dart';
import 'package:provider/provider.dart';
import '../products/list_product.dart';
import '../products/products_manager.dart';
import '../shared/app_drawer.dart';
import '../products/edit_product.dart';
import '../../models/product.dart';
import '../products/product_grid_tile.dart';

void main() {
  runApp(const MyApp());
}

class SearchScreen extends StatefulWidget {
  // static const routeName = '/';
  const SearchScreen({super.key});

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  TextEditingController controller = TextEditingController();
  List products = [];
  @override
  void initState() {
    getProducts();
    super.initState();
  }

  @override
  void dispose() {
    print('dispose');
    controller.dispose();
    super.dispose();
  }

  Future getProducts() async {
    return products = context.select<ProductsManager, List<Product>>(
        (productsManager) => productsManager.items);
    // for (var i = 0; i < products.length; i++) {
    //   final data = await products
    //       .where((element) => element.title.toLowerCase().contains());
    // }
  }

  void updateList(String value) {
    final sug = products.where((product) {
      final title = product.title.toLowerCase();
      final input = value.toLowerCase();
      return title.contains(input);
    }).toList();
    // if (value.isEmpty) {
    //   // if the search field is empty or only contains white-space, we'll display all users
    //   results = products;
    // } else {
    //   results = products
    //       .where((product) =>
    //           product.title.toLowerCase().contains(value.toLowerCase()))
    //       .toList();
    print('First text field: $sug');
    setState(() {
      products = sug;
    });
    // }
  }

  @override
  Widget build(BuildContext context) {
    // final productManager = ProductsManager();

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
            Expanded(
              child: GridView.builder(
                padding: const EdgeInsets.all(10.0),
                itemCount: products.length,
                itemBuilder: (ctx, i) => ProductGridTile(products[i]),
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
}
