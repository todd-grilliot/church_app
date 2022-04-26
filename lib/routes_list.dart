import 'package:flutter/material.dart';
import 'nav_scaffold.dart' show sliderFuture;
import 'home/home_slider.dart' show FullScreenSlider;

const TextStyle optionStyle = TextStyle(
  fontSize: 30,
  fontWeight: FontWeight.bold,
);

final List<Widget> routeList = [
  Text(
    'Live',
    style: optionStyle,
  ),
  Text(
    'Social',
    style: optionStyle,
  ),
  Text(
    'Listen',
    style: optionStyle,
  ),
  FullScreenSlider(
    dataFuture: sliderFuture,
  ),
  Text(
    'Blog',
    style: optionStyle,
  ),
  Text(
    'Visit',
    style: optionStyle,
  ),
  Text(
    'Give',
    style: optionStyle,
  ),
];
