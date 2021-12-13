import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:yardimfeneri/SERVICE/charities_service.dart';
import 'package:yardimfeneri/SERVICE/helpful_service.dart';
import 'package:yardimfeneri/SERVICE/needy_service.dart';
import 'package:yardimfeneri/UI/charities/homepage.dart';
import 'package:yardimfeneri/UI/sign_in/sign_in_select_page.dart';
import 'package:yardimfeneri/model/charities_model.dart';
import 'package:yardimfeneri/model/helpful_model.dart';
import 'package:yardimfeneri/model/needy_model.dart';
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
    final _charitiesService = Provider.of<CharitiesService>(context, listen: true);
    final _helpfulService = Provider.of<HelpfulService>(context, listen: true);

    print("charities gelen: "+_charitiesService.user.toString());
    print("needy gelen: "+_needyService.user.toString());
    print("helpful gelen: "+_helpfulService.user.toString());
    if(_helpfulService.user == null)
    {
      if (_needyService.user == null) {
        if (_charitiesService.user == null) {
          return SignInPage();
        } else {
          return CharitiesMainNavigation(user: _charitiesService.user!);
        }
      }else
        {
          return NeedyMainNavigation(user: _needyService.user!);
        }
    }else{
      return HelpfulMainNavigation(user: _helpfulService.user!,);
    }


  }

}
