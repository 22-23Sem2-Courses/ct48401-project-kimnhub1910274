import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';

final List<String> imgList = [
  'assets/images/banner.jpg',
  'assets/images/banner1.jpg',
  'assets/images/banner3.jpg',
  'assets/images/banner5.jpg',
  'assets/images/banner4.jpg',
];

class About extends StatelessWidget {
  const About({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: <Widget>[
          Center(
            child: CarouselAbout(),
          ),
          const Padding(
            padding: EdgeInsets.all(10),
            child: Text(
              'ABOUT',
              style: TextStyle(
                  fontWeight: FontWeight.w600, height: 2, fontSize: 16),
              textAlign: TextAlign.left,
            ),
          ),
          Image.asset('assets/images/banner6.jpg'),
          const Padding(
            padding: EdgeInsets.only(left: 0, right: 10, bottom: 0, top: 0),
            child: ListTile(
              title: Text(
                'The Story of Making ',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
              ),
            ),
          ),
          const Padding(
            padding: EdgeInsets.only(left: 15, right: 10, bottom: 10, top: 0),
            child: Text(
              'See the rigourous yet meticulous process of how your furniture is made to look so beautiful and last for generations with Lifetime Warranty, with the help of our 2000+ strong skilled & experienced artisnas.',
              style: TextStyle(fontSize: 16),
              textAlign: TextAlign.justify,
            ),
          ),
          const Padding(
            padding: EdgeInsets.only(left: 0, right: 10, bottom: 10, top: 0),
            child: ListTile(
              title: Text(
                '✓ Made in Solid Sheesham Wood.\n✓ ISO Ceritifed for Environment responsibility. \n✓ Lifetime Warranty & Free Delivery All VietNam.',
                style: TextStyle(fontSize: 16),
              ),
            ),
          ),
          Image.asset('assets/images/banner7.jpg'),
          const Padding(
            padding: EdgeInsets.all(10),
            child: Text(
              'CONTACT',
              style: TextStyle(
                  fontWeight: FontWeight.w600, height: 2, fontSize: 16),
              textAlign: TextAlign.left,
            ),
          ),
          const Padding(
            padding: EdgeInsets.all(10),
            child: Text(
              'Address: Street 123, Xuan Khanh Ward, Ninh Kieu District, Can Tho City\nEmail: furniture@gmail.com\nPhone: 0796543746 ',
              style: TextStyle(fontSize: 15),
              textAlign: TextAlign.justify,
            ),
          ),
        ],
      ),
    );
    //transform: Matrix4.rotationZ(-8 * pi / 180)..translate(-10.0),
  }

  Widget CarouselAbout() {
    return Container(
        child: CarouselSlider(
      options: CarouselOptions(
        height: 500,
        aspectRatio: 16 / 9,
        viewportFraction: 0.8,
        initialPage: 0,
        enableInfiniteScroll: true,
        reverse: false,
        autoPlay: true,
        autoPlayInterval: Duration(seconds: 3),
        autoPlayAnimationDuration: Duration(milliseconds: 400),
        autoPlayCurve: Curves.easeInOut,
        enlargeCenterPage: true,
        enlargeFactor: 0.3,
        //onPageChanged: callbackFunction,
        scrollDirection: Axis.horizontal,
      ),
      items: imgList
          .map((item) => Container(
                child: Center(
                    child: Image.asset(item, fit: BoxFit.fill, width: 1000)),
              ))
          .toList(),
    ));
  }
}
