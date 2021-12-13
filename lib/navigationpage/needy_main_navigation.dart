import 'dart:collection';

import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:yardimfeneri/UI/charities/notapprovedpage.dart';
import 'package:yardimfeneri/UI/helpful/chat.dart';
import 'package:yardimfeneri/UI/needy/homepage.dart';
import 'package:yardimfeneri/UI/needy/profil.dart';
import 'package:yardimfeneri/UI/needy/yardim_talebinde_bulunma.dart';
import 'package:yardimfeneri/extantion/size_config.dart';
import 'package:yardimfeneri/model/needy_model.dart';
import 'package:yardimfeneri/servis/needy_service.dart';

class NeedyMainNavigation extends StatefulWidget {
  final NeedyModel user;

  NeedyMainNavigation({Key? key, required this.user}) : super(key: key);

  @override
  _NeedyMainNavigationState createState() => _NeedyMainNavigationState();
}

class _NeedyMainNavigationState extends State<NeedyMainNavigation> {
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


    final _needyService = Provider.of<NeedyService>(context, listen: true);
    print("needy service main navigation "+_needyService.user.toString());
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
          body: _needyService.user!.hesaponay == true ? Center(child: _getBody(index)) : NotApprovedPageCharities(),
          bottomNavigationBar:  CurvedNavigationBar(
            key: _bottomNavigationKey,
            index: 0,
            height: 75.0,
            items: <Widget>[
              Icon(Icons.home, size: 40, color: Theme.of(context).backgroundColor),
              Icon(Icons.supervised_user_circle_sharp, size: 30, color: Theme.of(context).backgroundColor),
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
        return HomePageNeedy();
      case 1:
        return YardimTalebindeBulunma();
      case 2:
        return MesajlarAnasayfa();
      case 3:
        return ProfilNeedy();
    }

  }
}
