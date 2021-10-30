import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
class SplashScreen extends StatelessWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(child: Text("Anasayfa"),),
    );
  }

  Future<bool> initialSetup() async {
    //await Firebase.initializeApp();
    await SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
    return true;
  }
}
