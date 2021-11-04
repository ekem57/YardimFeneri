import 'package:flutter/material.dart';
import 'package:yardimfeneri/UI/sign_in/sign_in_page.dart';
import 'UI/splash/splash_ui.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Etkinlik Kafası',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primaryColor: const Color(0xFFED4C67),
        //accentColor: const Color(0xffffd400),
        backgroundColor: const Color(0xffffffff),
        //buttonColor: const Color(0xff3ecf8e),
        canvasColor: const Color(0xffffffff),
        visualDensity: VisualDensity.adaptivePlatformDensity,
        sliderTheme: SliderThemeData(
          thumbShape: RoundSliderThumbShape(enabledThumbRadius: 0.0),
          disabledActiveTrackColor: Colors.red[700],
        ),
        textTheme: TextTheme(
          button: TextStyle(
            fontSize: 18.0,
            color: const Color(0xff8b1afe),
            fontFamily: "OpenSans",
            fontWeight: FontWeight.w500,
            letterSpacing: 1.0,
          ),
          headline1: TextStyle(
              color: const Color(0xFFFFFFFF),
              fontSize: 20.0,
              fontFamily: "OpenSans"),
          caption: TextStyle(
              color: const Color(0xff343633),
              fontSize: 20.0,
              fontFamily: "OpenSans"),
        ),
        iconTheme: IconThemeData(
          color: const Color(0xff8b1afe),
        ),
      ),
      locale: const Locale('tr', "TR"),
      home: Scaffold(body: SignInPage()),
    );
  }
}
