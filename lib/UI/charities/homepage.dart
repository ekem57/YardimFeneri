import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:yardimfeneri/COMMON/myButton.dart';
import 'package:yardimfeneri/SERVICE/charities_service.dart';

class HomePageCharities extends StatefulWidget {
  const HomePageCharities({Key? key}) : super(key: key);

  @override
  _HomePageCharitiesState createState() => _HomePageCharitiesState();
}

class _HomePageCharitiesState extends State<HomePageCharities> {
  @override
  Widget build(BuildContext context) {
    final _charitiesService = Provider.of<CharitiesService>(context, listen: true);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue,
        title: Text("Anasayfa"),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Center(child: Text("HOŞGELDİNİZ"),),

        ],
      ),
    );
  }
}
