import 'package:flutter/material.dart';
import 'package:fuzzgram/navigation/navigation.dart';
import 'package:fuzzgram/theme.dart';

abstract class BasePage extends StatelessWidget {
  final AppTab appTab;
  final bool withBackButton;
  final String title;

  const BasePage(Key key,
      {this.appTab, this.withBackButton = false, this.title = 'Fuzzgram'})
      : super(key: key);

  List<Widget> actions() => null;

  Widget bottomNavigationBar() => NavigationWidget(activeTab: appTab);

  Widget floatingActionButton() => null;

  Widget widget(BuildContext context);

  Widget appBar(context) {
    return AppBar(
      leading: withBackButton
          ? IconButton(
              icon: Icon(Icons.arrow_back),
              onPressed: () => Navigator.pop(context),
              color: Colors.black,
            )
          : null,
      title: Container(
        child: Hero(tag: "logo", child: appLogo),
        height: 45,
      ),
      centerTitle: true,
      backgroundColor: Colors.white,
      actions: actions(),
    );
  }

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
        floatingActionButton: floatingActionButton(),
        bottomNavigationBar: bottomNavigationBar());
  }
}
