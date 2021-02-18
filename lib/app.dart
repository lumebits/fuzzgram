import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fuzzgram/home/home.dart';
import 'package:fuzzgram/navigation/navigation.dart';
import 'package:fuzzgram/search/bloc/search_bloc.dart';
import 'package:fuzzgram/search/view/search_widget.dart';

import 'explore/explore.dart';

class App extends StatelessWidget {

  App({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<SearchBloc>(
            create: (_) => SearchBloc()
        ),
        BlocProvider<NavigationBloc>(
          create: (_) => NavigationBloc()
        )
      ],
      child: MaterialApp(
        title: 'Fuzzgram',
        builder: (context, child) {
          return BlocBuilder<NavigationBloc, AppTab>(
            builder: (context, activeTab) {
              return Scaffold(
                backgroundColor: Color(0xEFFFFFFF),
                appBar: AppBar(
                  title: Text('Fuzzgram', style: TextStyle(color: Colors.black),),
                  centerTitle: true,
                  backgroundColor: Colors.white,
                ),
                extendBody: true,
                body: Stack(
                  children: [
                    activeTab == AppTab.home ? HomePage() : (activeTab == AppTab.explore ? ExplorePage() : Center()),
                    SearchWidget(),
                  ],
                ),
                bottomNavigationBar: NavigationWidget()
              );
            },
          );
        },
      )
    );
  }
}
