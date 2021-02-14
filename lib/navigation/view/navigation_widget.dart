import 'package:floating_bottom_navigation_bar/floating_bottom_navigation_bar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fuzzgram/fuzzgram_keys.dart';
import 'package:fuzzgram/navigation/bloc/navigation_bloc.dart';
import 'package:fuzzgram/navigation/bloc/navigation_event.dart';
import 'package:fuzzgram/navigation/model/app_tab.dart';

class NavigationWidget extends StatelessWidget {
  final AppTab activeTab;

  NavigationWidget({
    Key key,
    @required this.activeTab
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<NavigationBloc, AppTab>(
      builder: (context, activeTab) {
        return Scaffold(
          appBar: AppBar(
            centerTitle: true,
            title: const Text('Fuzzgram'),
          ),
          body: activeTab == AppTab.home ? Center() : (activeTab == AppTab.explore ? Center() : Center()),
          bottomNavigationBar: FloatingNavbar(
            key: FuzzgramKeys.navigation,
            currentIndex: AppTab.values.indexOf(activeTab),
            onTap: (index) => BlocProvider.of<NavigationBloc>(context).add(TabTapped(AppTab.values[index])),
            backgroundColor: Colors.white,
            unselectedItemColor: Colors.grey,
            borderRadius: 36,
            margin: const EdgeInsets.symmetric(horizontal: 28, vertical: 28),
            items: [
              FloatingNavbarItem(icon: Icons.home, title: 'Home'),
              FloatingNavbarItem(icon: Icons.search, title: 'Explore'),
              FloatingNavbarItem(icon: Icons.star, title: 'Starred'),
            ],
          ),
        );
      },
    );
  }
}