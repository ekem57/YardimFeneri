import 'package:flutter/material.dart';

class UyelerCharities extends StatefulWidget {
  const UyelerCharities({Key? key}) : super(key: key);

  @override
  _UyelerCharitiesState createState() => _UyelerCharitiesState();
}

class _UyelerCharitiesState extends State<UyelerCharities> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
          children: [
      Center(child: Text("Bağış İşlemleri"),),
    ],
    ),
    );
  }
}
