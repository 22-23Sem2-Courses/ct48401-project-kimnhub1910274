import 'package:flutter/material.dart';
import 'package:myproject_app/ui/products/products_grid.dart';
import '../screen.dart';
import 'dart:async';
import 'package:provider/provider.dart';
import 'package:flutter/foundation.dart';
import '../../models/product.dart';
import '../../services/products_service.dart';
import '../../models/auth_token.dart';
import '../shared/dialog_utils.dart';
import '../products/products_manager.dart';
import '../../services/products_service.dart';

class SearchScreen extends StatelessWidget {
  const SearchScreen({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return IconButton(
        onPressed: () {
          showSearch(context: context, delegate: CustomSearch());
        },
        icon: const Icon(Icons.search));
  }
}

class CustomSearch extends SearchDelegate {
  //   final ProductsService _productsService;

  List<Product> allData = [];
  //  Future<void> fetchProducts([bool filterByUser = false]) async {
  //  allData = await _productsService.fetchProducts(filterByUser);
  //   notifyListeners();

  @override
  List<Widget>? buildActions(BuildContext context) {
    return [
      IconButton(
        onPressed: () {
          query = '';
        },
        icon: const Icon(Icons.clear),
      )
    ];
  }

  @override
  Widget? buildLeading(BuildContext context) {
    return IconButton(
      onPressed: () {
        close(context, null);
      },
      icon: const Icon(Icons.arrow_back),
    );
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    //var allData = _refreshProducts(context);
    final listItem = query.isEmpty
        ? allData
        : allData.where((element) => element.title.startsWith(query)).toList();
    print(allData);
    return listItem.isEmpty
        ? const Center(
            child: Text("No Product Found!!"),
          )
        : ListView.builder(
            itemCount: listItem.length,
            itemBuilder: (context, index) {
              return Padding(
                  padding: const EdgeInsets.only(
                      left: 15.0, right: 15.0, top: 15.0, bottom: 15.0),
                  child: Column(
                    children: [
                      ListTile(
                        onTap: () {
                          showResults(context);
                        },
                        leading: Icon(Icons.production_quantity_limits_rounded),
                        title: Text(
                          listItem[index].title,
                        ),
                        subtitle: Text("Price: ${(listItem[index].price)}"),
                      )
                    ],
                  ));
            });
  }

  @override
  Widget buildResults(BuildContext context) {
    return Center(
      child: Text(query),
    );
    //   List<String> matchQuery = [];
    //   for (var item in allData) {
    //     if (item.toLowerCase().contains(query.toLowerCase())) {
    //       matchQuery.add(item);
    //     }
    //   }
    //   return ListView.builder(
    //       itemCount: matchQuery.length,
    //       itemBuilder: (context, index) {
    //         var result = matchQuery[index];
    //         return ListTile(
    //           title: Text(result),
    //         );
    //       });
  }
}
