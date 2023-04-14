import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';

final List<String> imgList = [
  'assets/images/banner.jpg',
  'assets/images/banner.jpg',
  'assets/images/banner.jpg',
];

class Introduce extends StatelessWidget {
  const Introduce({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      // height: 500,
      child: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            Center(
              
            )
            const ListTile(
              title: Text('The sunny and windy yet cozy GOA says it all'),
            )
          ],
        ),
      ),
      //transform: Matrix4.rotationZ(-8 * pi / 180)..translate(-10.0),
    );
  }

  Widget CarouselIntro() {
    return Container(
        child: CarouselSlider(
      options: CarouselOptions(),
      items: imgList
          .map((item) => Container(
                child: Center(
                    child: Image.network(item, fit: BoxFit.cover, width: 1000)),
              ))
          .toList(),
    ));
  }
}
