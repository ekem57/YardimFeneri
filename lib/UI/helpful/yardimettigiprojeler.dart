import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:yardimfeneri/COMMON/myButton.dart';
import 'package:yardimfeneri/SERVICE/helpful_service.dart';

class YardimEttigiProjeler extends StatefulWidget {
  const YardimEttigiProjeler({Key? key}) : super(key: key);

  @override
  _YardimEttigiProjelerState createState() => _YardimEttigiProjelerState();
}

class _YardimEttigiProjelerState extends State<YardimEttigiProjeler> {
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
