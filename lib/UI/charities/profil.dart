import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:yardimfeneri/COMMON/myButton.dart';
import 'package:yardimfeneri/SERVICE/charities_service.dart';
import 'package:yardimfeneri/EXTENSIONS/size_extension.dart';

class CharitiesProfil extends StatefulWidget {
  @override
  _CharitiesProfilState createState() => _CharitiesProfilState();
}

class _CharitiesProfilState extends State<CharitiesProfil> {


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
        children: <Widget>[


          Center(
            child: Column(
              children: <Widget>[



                SizedBox(height: 20.0.h,),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
