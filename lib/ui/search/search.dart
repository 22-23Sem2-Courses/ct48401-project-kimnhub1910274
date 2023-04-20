import 'package:flutter/material.dart';
import 'package:myproject_app/models/product.dart';
import 'package:myproject_app/ui/products/products_manager.dart';

class Search extends SearchDelegate {
  List<String> products = [
    'Apples',
    'Bananas',
    'Oranges',
    'Apples',
    'Bananas',
  ];

  // List products = ProductsManager().items;
  List<String> recentSearch = [];

  @override
  List<Widget> buildActions(BuildContext context) {
    // return <Widget>[IconButton(onPressed: () {}, icon: Icon(Icons.clear))];
    return [
      IconButton(
          onPressed: () {
            query = "";
          },
          icon: const Icon(Icons.clear))
    ];
  }

  @override
  Widget buildLeading(BuildContext context) {
    return IconButton(
        onPressed: () => Navigator.pop(context), icon: Icon(Icons.arrow_back));
  }

  @override
  Widget buildResults(BuildContext context) {
    if (query != null && products.contains(query.toLowerCase())) {
      return ListTile(
        title: Text(query),
        onTap: () {},
      );
    } else if (query == "") {
      return Text("");
    } else {
      return ListTile(title: Text("No"), onTap: () {});
    }
    // for (var fruit in products) {
    //   if (fruit.toLowerCase().contains(query.toLowerCase())) {
    //     recentSearch.add(fruit);
    //   }
    // }
    // return ListView.builder(
    //   itemCount: recentSearch.length,
    //   itemBuilder: (context, index) {
    //     return ListTile(
    //       title: Text(recentSearch[index]),
    //     );
    //   },
    // );
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    List<String> recentSearch = [];

    for (var fruit in products) {
      if (fruit.toLowerCase().contains(query.toLowerCase())) {
        recentSearch.add(fruit);
      }
    }
    return ListView.builder(
      itemCount: recentSearch.length,
      itemBuilder: (context, index) {
        return ListTile(
          title: Text(recentSearch[index]),
        );
      },
    );
  }
}
