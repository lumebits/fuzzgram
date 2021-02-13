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
      title: 'Fuzzgram',
      home: Scaffold(
        backgroundColor: Color(0xEFFFFFFF),
        appBar: AppBar(
          title: Text('Fuzzgram', style: TextStyle(color: Colors.black),),
          centerTitle: true,
          backgroundColor: Colors.white,
        ),
        //If you want to show body behind the navbar, it should be true
        extendBody: true,
        body: Container(
            height: 50,
            margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 30)
                .copyWith(bottom: 20),
            decoration: BoxDecoration(
                boxShadow: [
                  const BoxShadow(
                      color: Colors.black12,
                      blurRadius: 10,
                      spreadRadius: 0.5)
                ],
                borderRadius: BorderRadius.circular(25),
                color: Colors.white),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Row(
                children: <Widget>[
                  const Icon(
                    Icons.search,
                    color: Colors.blueGrey,
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  new Flexible(
                    child: new TextField(
                      decoration: InputDecoration(
                          hintText: 'Search templates',
                          border: InputBorder.none
                      ),
                    ),
                  ),
                ],
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
