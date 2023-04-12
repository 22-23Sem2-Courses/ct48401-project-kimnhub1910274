import 'package:flutter/material.dart';
import 'package:myproject_app/ui/home/home_banner.dart';
import 'package:myproject_app/ui/home/home_content.dart';
import '/ui/cart/cart_screen.dart';
import '/ui/products/products_manager.dart';
import 'package:provider/provider.dart';
import '../shared/app_drawer.dart';
import '../products/products_grid.dart';
import '../cart/cart_manager.dart';
import '../products/top_right_badge.dart';
import 'package:flutter/src/scheduler/ticker.dart';

enum FilterOptions { favorites, all }

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> with TickerProviderStateMixin {
  final _showOnLyFavorites = ValueNotifier<bool>(false);
  late Future<void> _fetchProducts;
  late TabController _tabController;
  //var _showOnlyFavorites = false;
  @override
  void initState() {
    super.initState();
    _fetchProducts = context.read<ProductsManager>().fetchProducts();
    _tabController = TabController(length: 3, vsync: this);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Furniture',
          style: TextStyle(fontSize: 25),
        ),
        actions: <Widget>[
          // buildProductFilterMenu(),
          buildShoppingCartIcon(),
        ],
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
              "Product",
              style: TextStyle(
                fontFamily: "BarlowBold",
                fontSize: 18,
              ),
            )),
            Tab(
                child: Text(
              "Introduce",
              style: TextStyle(
                fontFamily: "BarlowBold",
                fontSize: 18,
              ),
            )),
          ],
        ),
      ),
      drawer: const AppDrawer(),
      body: FutureBuilder(
        future: _fetchProducts,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            return ValueListenableBuilder<bool>(
                valueListenable: _showOnLyFavorites,
                builder: (context, onlyFavorites, child) {
                  return TabBarView(
                    controller: _tabController,
                    children: [
                      const Center(
                        child: HomeContent(),
                      ),
                      Container(
                        child: ProductsGrid(onlyFavorites),
                      ),
                      const Center(
                        child: Text("It's rainy here"),
                      ),
                    ],
                  );
                });
          }
          return const Center(
            child: CircularProgressIndicator(),
          );
        },
      ),
    );
  }

  Widget buildShoppingCartIcon() {
    return Consumer<CartManager>(
      builder: (ctx, cartManager, child) {
        return TopRightBadge(
          data: cartManager.productCount,
          child: IconButton(
            icon: const Icon(
              Icons.shopping_cart,
            ),
            onPressed: () {
              Navigator.of(ctx).pushNamed(CartScreen.routeName);
            },
          ),
        );
      },
    );
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
