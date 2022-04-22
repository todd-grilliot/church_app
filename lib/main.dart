import 'package:flutter/material.dart';
import 'home_slider.dart';
import 'package:flutter_svg/flutter_svg.dart';

void main() => runApp(const MyApp());

final themeMode = ValueNotifier(2);

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

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
  int _selectedIndex = 3;
  static const TextStyle optionStyle = TextStyle(
    fontSize: 30,
    fontWeight: FontWeight.bold,
  );
  static List<Widget> _widgetOptions = <Widget>[
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
    FullscreenSliderDemo(),
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

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[500],
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
              icon: SvgPicture.asset('assets/icons/ContactUs.svg'),
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
        items: <BottomNavigationBarItem>[
          BottomNavigationBarItem(
              icon: SvgPicture.asset('assets/icons/Live.svg'),
              label: 'LIVE',
              backgroundColor: Colors.transparent),
          BottomNavigationBarItem(
              icon: SvgPicture.asset('assets/icons/Social.svg'),
              label: 'SOCIAL',
              backgroundColor: Colors.transparent),
          BottomNavigationBarItem(
              icon: SvgPicture.asset('assets/icons/Listen.svg'),
              label: 'LISTEN',
              backgroundColor: Colors.transparent),
          BottomNavigationBarItem(
              icon: SvgPicture.asset(
                'assets/icons/Home.svg',
                color: Colors.white,
              ),
              label: 'HOME',
              backgroundColor: Colors.transparent),
          BottomNavigationBarItem(
              icon: SvgPicture.asset('assets/icons/Blog.svg'),
              label: 'BLOG',
              backgroundColor: Colors.transparent),
          BottomNavigationBarItem(
              icon: SvgPicture.asset('assets/icons/Visit.svg'),
              label: 'VISIT',
              backgroundColor: Colors.transparent),
          BottomNavigationBarItem(
              icon: SvgPicture.asset('assets/icons/Give.svg'),
              label: 'GIVE',
              backgroundColor: Colors.transparent),
        ],
        currentIndex: _selectedIndex,
        selectedLabelStyle:
            TextStyle(fontSize: 18, fontWeight: FontWeight.w300),
        // selectedItemColor: Colors.amber[800],
        // selectedIconTheme: IconThemeData(color: Colors.red),
        onTap: _onItemTapped,
      ),
    );
  }
}
