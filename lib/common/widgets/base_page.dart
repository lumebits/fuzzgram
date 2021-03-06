import 'package:flutter/material.dart';
import 'package:fuzzgram/common/admob_helper.dart';
import 'package:fuzzgram/navigation/navigation.dart';
import 'package:fuzzgram/theme.dart';

abstract class BasePage extends StatelessWidget {
  final AppTab appTab;
  final bool withBackButton;
  final String title;

  const BasePage(Key key,
      {this.appTab, this.withBackButton = false, this.title})
      : super(key: key);

  List<Widget> actions() => null;

  Widget bottomNavigationBar() => NavigationWidget(activeTab: appTab);

  Widget floatingActionButton(BuildContext context) => null;

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
      title: title != null
          ? Text(title, style: TextStyle(color: Colors.black))
          : Container(
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
        body: Column(
          children: [
            AdmobHelper().nativeAd(),
            Expanded(
              child: Stack(
                children: [
                  widget(context),
                ],
              ),
            ),
          ],
        ),
        floatingActionButton: floatingActionButton(context),
        bottomNavigationBar: bottomNavigationBar());
  }
}
