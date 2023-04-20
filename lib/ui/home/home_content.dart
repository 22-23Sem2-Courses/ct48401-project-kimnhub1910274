import 'package:provider/provider.dart';

import '../products/list_product.dart';
import 'package:flutter/material.dart';
import 'package:myproject_app/ui/products/admin_products_screen.dart';
import 'package:myproject_app/ui/products/products_manager.dart';
import '../home/home_banner.dart';
import 'package:carousel_slider/carousel_slider.dart';
import '../products/product_item.dart';

class HomeContent extends StatelessWidget {
  const HomeContent({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        const Flexible(
          child: HomeBanner(),
        ),
        const ListTile(
          title: Text(
            'Product Sales',
            style: TextStyle(fontSize: 20),
          ),
          minLeadingWidth: 0,
          leading: Icon(
            Icons.local_fire_department_sharp,
            color: Colors.red,
            size: 30,
          ),
        ),
        Container(
          child: myCarousel(),
        ),
      ],
    );
  }

  Widget myCarousel() {
    return SingleChildScrollView(
      child: Consumer<ProductsManager>(
        builder: (ctx, productsManager, child) {
          return CarouselSlider.builder(
            options: CarouselOptions(
                height: 400.0,
                aspectRatio: 2.0,
                viewportFraction: 0.8,
                initialPage: 1,
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
              ProductItem(
                productsManager.items[i],
              ),
            ]),
          );
        },
      ),
    );
  }
}
