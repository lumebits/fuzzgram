import 'package:floating_bottom_navigation_bar/floating_bottom_navigation_bar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:fuzzgram/fuzzgram_keys.dart';
import 'package:fuzzgram/navigation/model/app_tab.dart';
import 'package:fuzzgram/routes.dart';

class NavigationWidget extends StatelessWidget {
  final AppTab activeTab;

  NavigationWidget({Key key, this.activeTab = AppTab.home}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FloatingNavbar(
      key: FuzzgramKeys.navigation,
      currentIndex: AppTab.values.indexOf(activeTab),
      onTap: (index) {
        var appTab = AppTab.values[index];
        Navigator.pushNamed(
            context,
            appTab == AppTab.home ? FuzzgramRoutes.home
                : (appTab == AppTab.explore ? FuzzgramRoutes.explore
                    : FuzzgramRoutes.starred));
      },
      backgroundColor: Colors.white,
      unselectedItemColor: Colors.grey,
      borderRadius: 36,
      margin: const EdgeInsets.symmetric(horizontal: 28, vertical: 28),
      items: [
        FloatingNavbarItem(icon: Icons.home, title: 'Home'),
        FloatingNavbarItem(icon: Icons.explore, title: 'Explore'),
        FloatingNavbarItem(icon: Icons.star, title: 'Starred'),
      ],
    );
  }
}
