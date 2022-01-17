import 'dart:collection';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:yardimfeneri/UI/admin/adminHome.dart';
import 'package:yardimfeneri/UI/admin/needy_onay.dart';
import 'package:yardimfeneri/UI/charities/bagisislemleri.dart';
import 'package:yardimfeneri/UI/charities/bildirimler.dart';
import 'package:yardimfeneri/UI/charities/bilgilendirmeicerikleri.dart';
import 'package:yardimfeneri/UI/charities/homepage.dart';
import 'package:yardimfeneri/UI/charities/kampanyalarim.dart';
import 'package:yardimfeneri/UI/charities/notapprovedpage.dart';
import 'package:yardimfeneri/UI/charities/uyeler.dart';
import 'package:yardimfeneri/UI/charities/yardim_istegi_gonderme.dart';
import 'package:yardimfeneri/UI/charities/yardimkampanyasiacma.dart';
import 'package:yardimfeneri/extantion/size_config.dart';
import 'package:yardimfeneri/model/charities_model.dart';
import 'package:yardimfeneri/servis/charities_service.dart';


class AdminMainNavigation extends StatefulWidget {

  AdminMainNavigation({Key key}) : super(key: key);

  @override
  _AdminMainNavigationState createState() => _AdminMainNavigationState();
}

class _AdminMainNavigationState extends State<AdminMainNavigation> {
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
        final CurvedNavigationBarState navBarState = _bottomNavigationKey.currentState as CurvedNavigationBarState;
        navBarState.setPage(1);
        print("index: $index");
        setState(() {
          onTapped = true;
        });
        return false;
      },
      child: Scaffold(
        extendBody: true,
        bottomNavigationBar:  CurvedNavigationBar(
          key: _bottomNavigationKey,
          index: 0,
          height: 75.0,
          items: <Widget>[
            Icon(Icons.home, size: 40, color: Colors.white),
            Icon(Icons.person, size: 30, color: Colors.white),

          ],
          color: Colors.blue,
          buttonBackgroundColor: Colors.blue,
          animationCurve: Curves.easeInOut,
          animationDuration: Duration(milliseconds: 300),
          onTap: onTapped ? onNavButtonTapped: changeNavButtonAnimation,
          letIndexChange: (index) => true,
        ),
        backgroundColor: Colors.white,
        body:  _getBody(index),
      ),
    );
  }
  @override
  void dispose() {
    print("dispose call");
    super.dispose();
  }


  void onNavButtonTapped(int _index){
    print(_index.toString());
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

  static Widget _getBody(int index) {
    switch (index) {
      case 0:
        return AdminHome();
      case 1:
        return NeedyHome();


    }

  }
}
