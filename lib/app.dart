import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fuzzgram/category/category.dart';
import 'package:fuzzgram/explore/explore.dart';
import 'package:fuzzgram/home/home.dart';
import 'package:fuzzgram/navigation/navigation.dart';
import 'package:fuzzgram/routes.dart';
import 'package:fuzzgram/search/bloc/search_bloc.dart';
import 'package:fuzzgram/starred/starred.dart';
import 'package:fuzzgram/template/template.dart';

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
                pageBuilder: (_, __, ___) {
                  if (settings.name == FuzzgramRoutes.home) {
                    return BasePage(HomePage(), AppTab.home);
                  } else if (settings.name == FuzzgramRoutes.explore) {
                    return BasePage(ExplorePage(), AppTab.explore);
                  } else if (settings.name == FuzzgramRoutes.exploreCategory) {
                    return BasePage(
                        CategoryPage(settings.arguments), AppTab.explore,
                        withBackButton: true, title: settings.arguments);
                  } else if (settings.name == FuzzgramRoutes.template) {
                    return BasePage(TemplatePage(settings.arguments), null,
                        withBackButton: true);
                  } else {
                    return BasePage(StarredPage(), AppTab.starred);
                  }
                },
                transitionsBuilder: (_, a, __, c) =>
                    FadeTransition(opacity: a, child: c));
          },
        ));
  }
}

class BasePage extends StatelessWidget {
  final Widget widget;
  final AppTab appTab;
  final bool withBackButton;
  final String title;

  const BasePage(this.widget, this.appTab,
      {this.withBackButton = false, this.title = 'Fuzzgram'});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Color(0xEFFFFFFF),
        appBar: AppBar(
          leading: withBackButton
              ? IconButton(
                  icon: Icon(Icons.arrow_back),
                  onPressed: () => Navigator.pop(context),
                  color: Colors.black,
                )
              : null,
          title: Text(
            title,
            style: TextStyle(color: Colors.black),
          ),
          centerTitle: true,
          backgroundColor: Colors.white,
        ),
        extendBody: true,
        body: Stack(
          children: [
            widget,
          ],
        ),
        bottomNavigationBar: NavigationWidget(activeTab: appTab));
  }
}
