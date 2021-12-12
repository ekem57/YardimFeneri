import 'dart:collection';

import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:yardimfeneri/EXTENSIONS/size_config.dart';
import 'package:yardimfeneri/SERVICE/helpful_service.dart';
import 'package:yardimfeneri/UI/charities/notapprovedpage.dart';
import 'package:yardimfeneri/UI/helpful/chat.dart';
import 'package:yardimfeneri/UI/helpful/profilpage.dart';
import 'package:yardimfeneri/UI/helpful/homepage.dart';
import 'package:yardimfeneri/model/helpful_model.dart';

class HelpfulMainNavigation extends StatefulWidget {
  final HelpfulModel? user;

  HelpfulMainNavigation({Key? key, required this.user}) : super(key: key);

  @override
  _HelpfulMainNavigationState createState() => _HelpfulMainNavigationState();
}

class _HelpfulMainNavigationState extends State<HelpfulMainNavigation> {
  GlobalKey _bottomNavigationKey = GlobalKey();
  ListQueue<int> _navigationQueue = ListQueue();
  int index = 0;
  bool onTapped = true;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    onTapped = true;
  }

  @override
  Widget build(BuildContext context) {
    SizeConfig(context).init();



    return WillPopScope(
      onWillPop: () async {
        if (_navigationQueue.isEmpty){
          onTapped = true;
          return true;
        }
        setState(() {
          _navigationQueue.removeLast();
          int position = _navigationQueue.isEmpty ? 0 : _navigationQueue.last;
          onTapped = false;
          index = position;
        });
        final CurvedNavigationBarState? navBarState = _bottomNavigationKey.currentState as CurvedNavigationBarState?;
        navBarState?.setPage(1);
        print("index: $index");
        setState(() {
          onTapped = true;
        });
        return false;
      },
      child: Scaffold(
          backgroundColor: Theme.of(context).backgroundColor,
          extendBody: true,
          body:  _getBody(index),
          bottomNavigationBar:  CurvedNavigationBar(
            key: _bottomNavigationKey,
            index: 0,
            height: 75.0,
            items: <Widget>[
              Icon(Icons.home, size: 40, color: Theme.of(context).backgroundColor),
              Icon(Icons.date_range, size: 30, color: Theme.of(context).backgroundColor),
              Icon(Icons.info, size: 30, color: Theme.of(context).backgroundColor),
              Icon(Icons.message, size: 30, color: Theme.of(context).backgroundColor),
              Icon(Icons.person, size: 30, color: Theme.of(context).backgroundColor),
            ],
            color: Theme.of(context).primaryColor,
            buttonBackgroundColor: Theme.of(context).primaryColor,
            backgroundColor: Colors.transparent,
            animationCurve: Curves.easeInOut,
            animationDuration: Duration(milliseconds: 300),
            onTap: onTapped ? onNavButtonTapped: changeNavButtonAnimation,
            letIndexChange: (index) => true,
          )),
    );
  }
  @override
  void dispose() {
    print("dispose call");
    super.dispose();
  }


  void onNavButtonTapped(int _index){
    if (index != _index) {
      _navigationQueue.removeWhere((element) => element == _index);
      _navigationQueue.addLast(_index);
      setState(() {
        this.index = _index;
      });
    }
  }

  void changeNavButtonAnimation(int _index){
    setState(() {
      this.index = _index;
    });
  }

  Widget? _getBody(int index) {
    switch (index) {
      case 0:
        return HomePageHelpful();
      case 1:
        return HomePageHelpful();
      case 2:
        return HomePageHelpful();
      case 3:
        return MesajlarAnasayfa();
      case 4:
        return ProfilPageHelpful();
    }

  }
}
