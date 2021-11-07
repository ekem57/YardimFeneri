import 'package:flutter/material.dart';

class BagisIslemleriCharities extends StatefulWidget {
  const BagisIslemleriCharities({Key? key}) : super(key: key);

  @override
  _BagisIslemleriCharitiesState createState() => _BagisIslemleriCharitiesState();
}

class _BagisIslemleriCharitiesState extends State<BagisIslemleriCharities> {
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
