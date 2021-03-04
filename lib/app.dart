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
                    return HomePage();
                  } else if (settings.name == FuzzgramRoutes.explore) {
                    return ExplorePage();
                  } else if (settings.name == FuzzgramRoutes.exploreCategory) {
                    return CategoryPage(settings.arguments);
                  } else if (settings.name == FuzzgramRoutes.template) {
                    return TemplatePage(settings.arguments);
                  } else {
                    return StarredPage();
                  }
                },
                transitionsBuilder: (_, a, __, c) =>
                    FadeTransition(opacity: a, child: c));
          },
        ));
  }
}