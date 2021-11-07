import 'package:flutter/material.dart';

class BilgilendirmeIcerikleri extends StatefulWidget {
  const BilgilendirmeIcerikleri({Key? key}) : super(key: key);

  @override
  _BilgilendirmeIcerikleriState createState() => _BilgilendirmeIcerikleriState();
}

class _BilgilendirmeIcerikleriState extends State<BilgilendirmeIcerikleri> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
          children: [
      Center(child: Text("Bilgilendirme İçerikleri"),),
    ],
    ),
    );
  }
}
