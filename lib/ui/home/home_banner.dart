import 'package:flutter/material.dart';

class HomeBanner extends StatelessWidget {
  const HomeBanner({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      // height: 500,
      child: SingleChildScrollView(
        child: Column(
          children: [
            Image.network(
                'https://b2cfurniture.com.au/pub/media/b2cfurniture/category-top-banners/furniture-packages/furniture-packages-desktop-category-image.jpg')
          ],
        ),
      ),
      //transform: Matrix4.rotationZ(-8 * pi / 180)..translate(-10.0),
    );
  }
}
