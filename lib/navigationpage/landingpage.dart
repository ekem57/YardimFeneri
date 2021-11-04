import 'package:flutter/material.dart';

class LandingPage extends StatefulWidget {
  @override
  _LandingPageState createState() => _LandingPageState();
}

class _LandingPageState extends State<LandingPage> {

  @override
  Widget build(BuildContext context) {
    final _userModel = Provider.of<UserModel>(context, listen: true);
    if (_userModel.state == ViewState.Idle) {
      if (_userModel.user == null) {
        return LoginView();
      } else {
        return MainNavigation(user: _userModel.user,);
      }
    }
    return Scaffold();
  }


}
