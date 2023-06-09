import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:myproject_app/ui/home/home_banner.dart';
import 'package:myproject_app/ui/home/home_content.dart';
import 'package:myproject_app/ui/about/about_screen.dart';
import 'package:myproject_app/ui/search/search.dart';
import '/ui/cart/cart_screen.dart';
import '/ui/products/products_manager.dart';
import 'package:provider/provider.dart';
import '../shared/app_drawer.dart';
import '../products/products_grid.dart';
import '../cart/cart_manager.dart';
import '../products/top_right_badge.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
//import '../search/search_screen.dart';
import '../search/search_product.dart';

import 'package:textfield_search/textfield_search.dart';
import '../../models/product.dart';

enum FilterOptions { favorites, all }

class HomeScreen extends StatefulWidget {
  // static const routeName = '/';
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final _showOnLyFavorites = ValueNotifier<bool>(false);
  late Future<void> _fetchProducts;
  bool searchState = false;
  final myController = TextEditingController();

  //var _showOnlyFavorites = false;
  @override
  void initState() {
    super.initState();
    _fetchProducts = context.read<ProductsManager>().fetchProducts();
    myController.addListener(_printLatestValue);
  }

  _printLatestValue() {
    print("text field: ${myController.text}");
  }

  @override
  void dispose() {
    myController.dispose();
    super.dispose();
  }

  // final _testList = [
  //   'Test Item 1',
  //   'Test Item 2',
  //   'Test Item 3',
  //   'Test Item 4',
  // ];

  int _selectedIndex = 0;

  _setIndex(int value) {
    setState(() {
      _selectedIndex = value;
    });
  }

  @override
  Widget build(BuildContext context) {
    final products = context.select<ProductsManager, List<Product>>(
        (productsManager) => productsManager.products);
    Future<List> fetchData() async {
      List list = [];
      for (var i = 0; i < products.length; i++) {
        list.add(products[i].title);
      }
      return list;
    }

    return Scaffold(
      appBar: AppBar(
        title: !searchState
            ? const Text(
                'Furniture',
                style: TextStyle(fontSize: 25),
              )
            : TextFieldSearch(
                future: () {
                  return fetchData();
                },
                // getSelectedValue: (value) {
                //   print(
                //       value); // this prints the selected option which could be an object
                // },
                label: 'Search',
                controller: myController),
        // onChanged: (val) {
        //   setState(() {
        //     name = val;
        //   });
        // },

        actions: <Widget>[
          !searchState
              ? IconButton(
                  onPressed: () {
                    setState(() {
                      searchState = !searchState;
                    });
                  },
                  icon: Icon(Icons.search))
              : IconButton(
                  onPressed: () {
                    setState(() {
                      searchState = !searchState;
                    });
                    // return SearchScreen(ProductsManager().findByName(productId)!);
                  },
                  icon: const Icon(Icons.cancel)),
          //buildSearch(),
          //buildProductFilterMenu(),
          buildShoppingCartIcon(),
        ],
        centerTitle: true,
      ),
      drawer: const AppDrawer(),
      body: FutureBuilder(
        future: _fetchProducts,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            return ValueListenableBuilder<bool>(
                valueListenable: _showOnLyFavorites,
                builder: (context, onlyFavorites, child) {
                  return Material(
                      child: IndexedStack(
                    index: _selectedIndex,
                    children: [
                      Center(
                        child: GestureDetector(
                          onLongPress: () => _setIndex(0),
                          child: const HomeContent(),
                        ),
                      ),
                      Center(
                        child: GestureDetector(
                          onLongPress: () => _setIndex(1),
                          child: ProductsGrid(onlyFavorites),
                        ),
                      ),
                      Center(
                        child: GestureDetector(
                          onLongPress: () => _setIndex(0),
                          child: const About(),
                        ),
                      ),
                      // Center(
                      //   child: GestureDetector(
                      //     onLongPress: () => _setIndex(0),
                      //     child: const SearchScreen(),
                      //     //child: const SearchScreen(),
                      //   ),
                      // ),
                    ],
                  ));
                });
          }
          return const Center(
            child: CircularProgressIndicator(),
          );
        },
      ),
      bottomNavigationBar: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              blurRadius: 20,
              color: Colors.black.withOpacity(.1),
            )
          ],
        ),
        // color: Colors.white70,
        child: SafeArea(
            child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 18.0, vertical: 10.0),
                child: GNav(
                  backgroundColor: Colors.white,
                  color: Colors.pink,
                  activeColor: Colors.white,
                  tabBackgroundColor: Color.fromRGBO(224, 139, 139, 1),
                  gap: 6,
                  padding: const EdgeInsets.all(14),
                  tabs: const [
                    GButton(
                      icon: CupertinoIcons.home,
                      text: 'Home',
                    ),
                    GButton(
                      icon: CupertinoIcons.bag,
                      text: 'Product',
                    ),
                    GButton(
                      icon: CupertinoIcons.news_solid,
                      text: 'About',
                    ),
                    // GButton(
                    //   icon: CupertinoIcons.search,
                    //   text: 'Search',
                    // ),
                  ],
                  selectedIndex: _selectedIndex,
                  onTabChange: (index) {
                    setState(() {
                      _selectedIndex = index;
                    });
                  },
                ))),
      ),
    );
  }

  Widget buildShoppingCartIcon() {
    return Consumer<CartManager>(
      builder: (ctx, cartManager, child) {
        return TopRightBadge(
          data: cartManager.productCount,
          child: IconButton(
            icon: const Icon(Icons.shopping_cart_outlined),
            onPressed: () {
              Navigator.of(ctx).pushNamed(CartScreen.routeName);
            },
          ),
        );
      },
    );
  }

  Widget buildProductFilterMenu() {
    return PopupMenuButton(
      onSelected: (FilterOptions selectedValue) {
        //  setState(() {
        if (selectedValue == FilterOptions.favorites) {
          _showOnLyFavorites.value = true;
        } else {
          _showOnLyFavorites.value = false;
        }
      },
      //   );
      // },
      icon: const Icon(
        Icons.more_vert,
      ),
      itemBuilder: (ctx) => [
        const PopupMenuItem(
          value: FilterOptions.favorites,
          child: Text('Only Favorite'),
        ),
        const PopupMenuItem(
          value: FilterOptions.all,
          child: Text('Show All'),
        )
      ],
    );
  }

  Widget buildSearch() {
    return IconButton(
      onPressed: () => showSearch(context: context, delegate: Search()),
      icon: Icon(Icons.search),
    );
  }
}
