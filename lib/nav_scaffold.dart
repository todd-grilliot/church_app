import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'routes_list.dart' show routeList;
import 'package:http/http.dart' as http;
import 'dart:convert';

late final Future sliderFuture = fetchSliderFuture();
Future fetchSliderFuture() async {
  print('fetch slider future');
  // String jsonBinUrlMp4Videos = 'https://api.jsonbin.io/b/62632205bc312b30ebeb8b2e/3';
  // String url = 'https://wolvideos.firebaseapp.com/wolProject.js';
  String jsonBinUrl = 'https://api.jsonbin.io/b/6266f83f25069545a3291c1c/2';
  String badUrl = 'https://api.jsonbin.io/b/6266f83f25069545a3291c1c/4';
  http.Response response = await http.get(Uri.parse(jsonBinUrl));
  if (response.statusCode != 200) return [];

  List data = jsonDecode(response.body)['videos'];
  return data.sublist(0, 6);
}

class NavScaffold extends StatefulWidget {
  const NavScaffold({Key? key}) : super(key: key);
  @override
  State<NavScaffold> createState() => _NavScaffoldState();
}

class _NavScaffoldState extends State<NavScaffold> {
  int _selectedIndex = 3;

  static List<Widget> _routes = routeList;

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  void initState() {
    super.initState();
    fetchSliderFuture();
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
        child: _routes.elementAt(_selectedIndex),
      ),
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        backgroundColor: Colors.transparent,
        fixedColor: Colors.white,
        unselectedItemColor: Colors.white,
        // iconSize: 10,
        // unselectedFontSize: 10,
        unselectedLabelStyle:
            TextStyle(overflow: TextOverflow.fade, letterSpacing: -1.3),
        // elevation: 0, //getting rid of this leaves a shadow...
        items: <BottomNavigationBarItem>[
          BottomNavigationBarItem(
              icon: SvgPicture.asset('assets/icons/Live.svg'),
              label: 'LIVE',
              backgroundColor: Colors.transparent),
          BottomNavigationBarItem(
              icon: SvgPicture.asset(
                'assets/icons/Social.svg',
              ),
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
