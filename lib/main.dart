import 'package:floating_bottom_navigation_bar/floating_bottom_navigation_bar.dart';
import 'package:flutter/material.dart';

void main() => runApp(MyApp());

class MyApp extends StatefulWidget {
  // This widget is the root of your application.
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  int _index = 0;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Floating NavBar Example',
      home: Scaffold(
        backgroundColor: Color(0xEFFFFFFF),
        appBar: AppBar(
          title: Text('Floating NavBar Example'),
          centerTitle: true,
        ),
        //If you want to show body behind the navbar, it should be true
        extendBody: true,
        body: Center(
          child: Text(
            "index: $_index",
            style: TextStyle(
              fontSize: 52,
            ),
          ),
        ),
        bottomNavigationBar: FloatingNavbar(
          backgroundColor: Colors.white,
          unselectedItemColor: Colors.grey,
          borderRadius: 36,
          margin: const EdgeInsets.symmetric(horizontal: 28, vertical: 28),
          onTap: (int val) => setState(() => _index = val),
          currentIndex: _index,
          items: [
            FloatingNavbarItem(icon: Icons.home, title: 'Home'),
            FloatingNavbarItem(icon: Icons.search, title: 'Explore'),
            FloatingNavbarItem(icon: Icons.star, title: 'Favourites'),
          ],
        ),
      ),
    );
  }
}
