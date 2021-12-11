import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:yardimfeneri/COMMON/myButton.dart';
import 'package:yardimfeneri/SERVICE/helpful_service.dart';

class YardimEttigiInsanlar extends StatefulWidget {
  const YardimEttigiInsanlar({Key? key}) : super(key: key);

  @override
  _YardimEttigiInsanlarState createState() => _YardimEttigiInsanlarState();
}

class _YardimEttigiInsanlarState extends State<YardimEttigiInsanlar> {
  @override
  Widget build(BuildContext context) {
    final _helpfulService = Provider.of<HelpfulService>(context, listen: true);
    return Scaffold(
      body: Column(
        children: [
          Center(child: Text("EMRE"),),

        ],
      ),
    );
  }
}
