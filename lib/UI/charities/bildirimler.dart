import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:yardimfeneri/SERVICE/charities_service.dart';

class BildirimlerCharities extends StatefulWidget {
  const BildirimlerCharities({Key? key}) : super(key: key);

  @override
  _BildirimlerCharitiesState createState() => _BildirimlerCharitiesState();
}

class _BildirimlerCharitiesState extends State<BildirimlerCharities> {
  @override
  Widget build(BuildContext context) {
    final _charitiesModel = Provider.of<CharitiesService>(context, listen: true);

    return Scaffold(
      appBar: AppBar(
        brightness: Brightness.light,
        backgroundColor: Colors.transparent,
        elevation: 0.0,
        iconTheme: new IconThemeData(color: Colors.black),
        title: Text("Profil", style: TextStyle(
            fontSize: 30, fontWeight: FontWeight.bold, color: Colors.black),),
        automaticallyImplyLeading: false,
        actions: <Widget>[
          Padding(
            padding: const EdgeInsets.only(right: 20),
            child: IconButton(icon: Icon(Icons.exit_to_app,size: 40,), onPressed: (){
              _charitiesModel.signOut();
            }),
          )

        ],
      ),
      body: ListView(
        children: [

          Center(child: Text("Bildirimler sayfası"),),
        ],
      ),
    );
  }
}
