import 'package:flutter/material.dart';

class YardimKampanyasiAcmaCharities extends StatefulWidget {
  const YardimKampanyasiAcmaCharities({Key? key}) : super(key: key);

  @override
  _YardimKampanyasiAcmaCharitiesState createState() => _YardimKampanyasiAcmaCharitiesState();
}

class _YardimKampanyasiAcmaCharitiesState extends State<YardimKampanyasiAcmaCharities> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
          children: [
      Center(child: Text("Bağiş Kampanyasi Açma"),),
        ],
    ),
    );
  }
}
