import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:yardimfeneri/SERVICE/charities_service.dart';
import 'package:yardimfeneri/SERVICE/helpful_service.dart';
import 'package:yardimfeneri/SERVICE/needy_service.dart';
import 'package:yardimfeneri/UI/sign_in/sign_in_select_page.dart';
import 'package:yardimfeneri/navigationpage/charities_main_navigation.dart';
import 'package:yardimfeneri/navigationpage/helpful_main_navigation.dart';
import 'needy_main_navigation.dart';

class LandingPage extends StatefulWidget {
  @override
  _LandingPageState createState() => _LandingPageState();
}

class _LandingPageState extends State<LandingPage> {

  @override
  Widget build(BuildContext context) {

    final _needyService = Provider.of<NeedyService>(context, listen: true);


    if(_needyService.user == null)
    {
      return SignInPage();
    }else{
      return NeedyMainNavigation(user: _needyService.user!);
    }


  }

}
