import 'package:flutter/material.dart';
// import 'home/home_slider.dart';
// import 'package:flutter_svg/flutter_svg.dart';
// import 'bottom_nav_bar.dart';
import 'nav_scaffold.dart';

void main() => {runApp(const MyApp())};

final themeMode = ValueNotifier(2);

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      // title: _title,
      home: NavScaffold(),
      theme: ThemeData(fontFamily: 'Lato'),
    );
  }
}
