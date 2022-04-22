// import 'dart:html';

import 'package:church_app/nav_scaffold.dart';
import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'defaultMap.dart';
import 'slides_map.dart' show slidesMap;

class FullScreenSlider extends StatefulWidget {
  final Future dataFuture;

  const FullScreenSlider({
    Key? key,
    required this.dataFuture,
  }) : super(key: key);
  State<FullScreenSlider> createState() => _FullScreenSliderState();
}

class _FullScreenSliderState extends State<FullScreenSlider> {
  bool _isLoaded = false;
  List _data = [];

  @override
  Widget build(BuildContext context) {
    widget.dataFuture.then((value) => {
          setState(() {
            _data = value;
            _isLoaded = true;
          }),
          print(_data[0]['id']),
        });
    return Builder(
      builder: (context) {
        final double _fullHeight = MediaQuery.of(context).size.height;
        return CarouselSlider(
            options: CarouselOptions(
              height: _fullHeight,
              viewportFraction: 1.0,
              enlargeCenterPage: false,
              enableInfiniteScroll: false,
              autoPlay: true,
            ),
            items: _isLoaded ? slidesMap(_data) : defaultMap());
      },
      // ),
    );
  }
}
