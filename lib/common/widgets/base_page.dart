import 'package:flutter/material.dart';
import 'package:fuzzgram/navigation/navigation.dart';

abstract class BasePage extends StatelessWidget {
  final AppTab appTab;
  final bool withBackButton;
  final String title;

  const BasePage(Key key,
      {this.appTab, this.withBackButton = false, this.title = 'Fuzzgram'})
      : super(key: key);

  Widget appBar(context) {
    return AppBar(
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
    );
  }

  Widget widget(BuildContext context);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Color(0xEFFFFFFF),
        appBar: appBar(context),
        extendBody: true,
        body: Stack(
          children: [
            widget(context),
          ],
        ),
        bottomNavigationBar: NavigationWidget(activeTab: appTab));
  }
}
