import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:yardimfeneri/EXTENSIONS/size_config.dart';
import 'package:yardimfeneri/ROUTING/navigation/navigation_service.dart';
import 'package:yardimfeneri/ROUTING/routeconstants.dart';
import 'package:yardimfeneri/EXTENSIONS/size_extension.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  double imageOpacity = 0;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Future.microtask(() => imageOpacity=1);
    Future.delayed(Duration(milliseconds: 3300)).then((value) {
     nagigateToHome();
    });
  }
  @override
  Widget build(BuildContext context) {
    SizeConfig(context).init();
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Center(child: buildAnimatedOpacityImage()),
        ],
      ),
    );
  }


  AnimatedOpacity buildAnimatedOpacityImage() {
    return AnimatedOpacity(
      opacity: imageOpacity,
      duration: Duration(milliseconds: 2600),
      child: Image.asset("assets/logo.png",
        scale: 6,
        fit: BoxFit.contain,
      ),
    );
  }





  void nagigateToHome() {
    NavigationService.instance.navigateToReset(RouteConstants.HOME);
  }


}
