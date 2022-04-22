import 'package:flutter/material.dart';
import 'home_slider.dart';
import 'package:flutter_svg/flutter_svg.dart';

void main() => runApp(const MyApp());

final themeMode = ValueNotifier(2);

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // static const String _title = 'Word of Lifess';

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      // title: _title,
      home: MyStatefulWidget(),
      theme: ThemeData(fontFamily: 'Lato'),
    );
  }
}

class MyStatefulWidget extends StatefulWidget {
  const MyStatefulWidget({Key? key}) : super(key: key);

  @override
  State<MyStatefulWidget> createState() => _MyStatefulWidgetState();
}

class _MyStatefulWidgetState extends State<MyStatefulWidget> {
  int _selectedIndex = 0;
  static const TextStyle optionStyle =
      TextStyle(fontSize: 30, fontWeight: FontWeight.bold);
  static List<Widget> _widgetOptions = <Widget>[
    Text(
      'Church Online',
      style: optionStyle,
    ),
    Text(
      'I\'m New',
      style: optionStyle,
    ),
    FullscreenSliderDemo(),
    Text(
      'Giving',
      style: optionStyle,
    ),
    Text(
      'Contact Us',
      style: optionStyle,
    ),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      extendBody: true,
      appBar: AppBar(
        // centerTitle: true,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            SvgPicture.asset('assets/icons/LoGo.svg'),
            Text(
              'WORD OF LIFE CARLSBAD',
              style: TextStyle(
                  fontSize: 20, fontWeight: FontWeight.w900, letterSpacing: 1),
            ),
            IconButton(
              constraints: BoxConstraints(),
              padding: EdgeInsets.zero,
              onPressed: null,
              icon: SvgPicture.asset('assets/icons/LoGo.svg'),
            )
          ],
        ),
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: Center(
        child: _widgetOptions.elementAt(_selectedIndex),
      ),
      bottomNavigationBar: BottomNavigationBar(
        // elevation: 0, //getting rid of this leaves a shadow...
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
              icon: Icon(Icons.church),
              label: 'Church Online',
              backgroundColor: Colors.transparent),
          BottomNavigationBarItem(
              icon: Icon(Icons.new_releases),
              label: 'I\'m New',
              backgroundColor: Colors.transparent),
          BottomNavigationBarItem(
              icon: Icon(Icons.home),
              label: 'Listen\\Watch',
              backgroundColor: Colors.transparent),
          BottomNavigationBarItem(
              icon: Icon(Icons.attach_money),
              label: 'Giving',
              backgroundColor: Colors.transparent),
          BottomNavigationBarItem(
              icon: Icon(Icons.contact_mail),
              label: 'Contact Us',
              backgroundColor: Colors.transparent),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: Colors.amber[800],
        onTap: _onItemTapped,
      ),
    );
  }
}
