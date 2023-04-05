import 'package:flutter/material.dart';
// import '/ui/cart/cart_screen.dart';
import '/ui/products/products_manager.dart';
// import 'package:provider/provider.dart';
import '../shared/app_drawer.dart';
// import 'products_grid.dart';
// import '../cart/cart_manager.dart';
// import 'top_right_badge.dart';
import 'package:flutter/src/scheduler/ticker.dart';

enum FilterOptions { favorites, all }

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> with TickerProviderStateMixin {
  final _showOnLyFavorites = ValueNotifier<bool>(false);
  //late Future<void> _fetchProducts;
  late TabController _tabController;
  // var _showOnlyFavorites = false;
  @override
  void initState() {
    super.initState();
    // _fetchProducts = context.read<ProductsManager>().fetchProducts();
    _tabController = TabController(length: 4, vsync: this);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Furniture',
          style: TextStyle(fontSize: 25),
        ),
        centerTitle: true,
        bottom: TabBar(
          controller: _tabController,
          indicatorWeight: 2,
          tabs: const <Widget>[
            Tab(
                child: Text(
              "Home",
              style: TextStyle(
                fontFamily: "BarlowBold",
                fontSize: 18,
              ),
            )),
            Tab(
                child: Text(
              "Desk",
              style: TextStyle(
                fontFamily: "BarlowBold",
                fontSize: 18,
              ),
            )),
            Tab(
                child: Text(
              "Bed",
              style: TextStyle(
                fontFamily: "BarlowBold",
                fontSize: 18,
              ),
            )),
            Tab(
                child: Text(
              "Sofa",
              style: TextStyle(
                fontFamily: "BarlowBold",
                fontSize: 18,
              ),
            )),
          ],
        ),
        actions: <Widget>[
          // buildProductFilterMenu(),
          buildShoppingCartIcon(),
        ],
      ),
      drawer: const AppDrawer(),
      // body: FutureBuilder(
      //  // future: _fetchProducts,
      //   builder: (context, snapshot) {
      //     if (snapshot.connectionState == ConnectionState.done) {
      //       return ValueListenableBuilder<bool>(
      //           valueListenable: _showOnLyFavorites,
      //           builder: (context, onlyFavorites, child) {
      //             // return ProductsGrid(onlyFavorites);
      //             return TabBarView(
      //               controller: _tabController,
      //               children: [
      //                 // Center(
      //                 //   child: ProductsGrid(onlyFavorites),
      //                 // ),
      //                 // Center(
      //                 //   child: Text("It's rainy here"),
      //                 // ),
      //                 // Center(
      //                 //   child: Text("It's sunny here"),
      //                 // ),
      //                 // Center(
      //                 //   child: Text("It's sunny herer"),
      //                 // ),

      //                 // ProductsGrid(onlyFavorites),
      //                 Text('data')
      //               ],
      //             );
      //           });
      //     }
      //     return const Center(
      //       child: CircularProgressIndicator(),
      //     );
      //   },
      // ),
    );
  }

  Widget buildShoppingCartIcon() {
    return IconButton(
        onPressed: () {
          print('Go to cart ');
        },
        icon: const Icon(
          Icons.shopping_cart,
        ));
  }

  // Widget buildProductFilterMenu() {
  //   return PopupMenuButton(
  //     onSelected: (FilterOptions selectedValue) {
  //       //  setState(() {
  //       if (selectedValue == FilterOptions.favorites) {
  //         _showOnLyFavorites.value = true;
  //       } else {
  //         _showOnLyFavorites.value = false;
  //       }
  //     },
  //     //   );
  //     // },
  //     icon: const Icon(
  //       Icons.more_vert,
  //     ),
  //     itemBuilder: (ctx) => [
  //       const PopupMenuItem(
  //         value: FilterOptions.favorites,
  //         child: Text('Only Favorite'),
  //       ),
  //       const PopupMenuItem(
  //         value: FilterOptions.all,
  //         child: Text('Show All'),
  //       )
  //     ],
  //   );
  // }
}
