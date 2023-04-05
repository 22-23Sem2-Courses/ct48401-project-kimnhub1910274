import 'dart:math';

import 'package:flutter/material.dart';

class AppBanner extends StatelessWidget {
  const AppBanner({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(top: 100.0),
      padding: const EdgeInsets.symmetric(
        vertical: 8.0,
        horizontal: 94.0,
      ),
      child: Column(
        children: [
          Image.network(
              'https://www.bhadepay.com/assets/images/furniture-banner.png')
        ],
      ),
      //transform: Matrix4.rotationZ(-8 * pi / 180)..translate(-10.0),
    );
  }
}
