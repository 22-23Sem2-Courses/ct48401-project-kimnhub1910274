import 'package:provider/provider.dart';

import '../products/list_product.dart';
import 'package:flutter/material.dart';
import 'package:myproject_app/ui/products/admin_products_screen.dart';
import 'package:myproject_app/ui/products/products_manager.dart';
import '../home/home_banner.dart';
import 'package:carousel_slider/carousel_slider.dart';

class HomeContent extends StatelessWidget {
  const HomeContent({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: <Widget>[
          const Flexible(
            child: HomeBanner(),
          ),
          Flexible(
            child: Carousel(),
          ),
        ],
      ),

      //transform: Matrix4.rotationZ(-8 * pi / 180)..translate(-10.0),
    );
  }

  Widget Carousel() {
    return Consumer<ProductsManager>(
      builder: (ctx, productsManager, child) {
        return CarouselSlider.builder(
          options: CarouselOptions(
              height: 200.0,
              aspectRatio: 16 / 9,
              viewportFraction: 0.8,
              initialPage: 0,
              enableInfiniteScroll: true,
              reverse: false,
              autoPlay: true,
              autoPlayInterval: Duration(seconds: 3),
              autoPlayAnimationDuration: Duration(milliseconds: 800),
              autoPlayCurve: Curves.fastOutSlowIn,
              enlargeCenterPage: true,
              enlargeFactor: 0.3,
              // onPageChanged: callbackFunction,
              scrollDirection: Axis.horizontal),
          itemCount: productsManager.itemCount,
          itemBuilder: (ctx, i, int pageViewIndex) => Column(children: [
            AdminProductListTile(
              productsManager.items[i],
            ),
          ]),
        );
        // print(productsManager.itemCount);
        // return ListView.builder(
        //   itemCount: productsManager.itemCount,
        //   itemBuilder: (ctx, i) => Column(
        //     children: [
        //       AdminProductListTile(
        //         productsManager.items[i],
        //       ),
        //       const Divider(),
        //     ],
        //   ),
        // );
      },
    );
  }
}
