import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fuzzgram/home/home.dart';
import 'package:fuzzgram/navigation/navigation.dart';
import 'package:fuzzgram/routes.dart';
import 'package:fuzzgram/search/bloc/search_bloc.dart';
import 'package:fuzzgram/search/view/search_widget.dart';

import 'explore/explore.dart';

class App extends StatelessWidget {
  App({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
        providers: [
          BlocProvider<SearchBloc>(create: (_) => SearchBloc()),
        ],
        child: MaterialApp(
          title: 'Fuzzgram',
          onGenerateRoute: (settings) {
            return PageRouteBuilder(
                pageBuilder: (_, __, ___) =>
                    settings.name == FuzzgramRoutes.home ? BasePage(HomePage(), AppTab.home)
                        : (settings.name == FuzzgramRoutes.explore ? BasePage(ExplorePage(), AppTab.explore)
                            : BasePage(Center(), AppTab.starred)),
                transitionsBuilder: (_, a, __, c) =>
                    FadeTransition(opacity: a, child: c));
          },
        ));
  }
}

class BasePage extends StatelessWidget {
  final Widget widget;
  final AppTab appTab;

  const BasePage(this.widget, this.appTab);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Color(0xEFFFFFFF),
        appBar: AppBar(
          title: Text(
            'Fuzzgram',
            style: TextStyle(color: Colors.black),
          ),
          centerTitle: true,
          backgroundColor: Colors.white,
        ),
        extendBody: true,
        body: Stack(
          children: [
            widget,
            SearchWidget(),
          ],
        ),
        bottomNavigationBar: NavigationWidget(activeTab: appTab));
  }
}
