import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:provider/provider.dart';
import 'package:yardimfeneri/EXTENSIONS/size_extension.dart';
import 'package:yardimfeneri/SERVICE/helpful_service.dart';


class HomePageHelpful extends StatefulWidget {
  bool? clean;

  HomePageHelpful({this.clean});

  @override
  _HomePageHelpfulState createState() => _HomePageHelpfulState();
}

class _HomePageHelpfulState extends State<HomePageHelpful> {

  @override
  Widget build(BuildContext context) {
    final _helpfulService = Provider.of<HelpfulService>(context, listen: true);
    return Scaffold(
      appBar: AppBar(
        brightness: Brightness.light,
        backgroundColor: Colors.grey.shade300,
        elevation: 0.0,
        iconTheme: new IconThemeData(color: Colors.black),
        title: Text(
          "Anasayfa",
          style: TextStyle(
              fontSize: 25.0.spByWidth,
              fontWeight: FontWeight.bold,
              color: Colors.black),
        ),
      ),
      body:  Center(
        child: Container(
          child: SingleChildScrollView(
            child: Column(
              children: <Widget>[
               ]),
          ),
        ),
      ),
    );

  }
}

