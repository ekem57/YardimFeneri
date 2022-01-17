import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:yardimfeneri/common/resimlicard.dart';
import 'package:yardimfeneri/common/uyeistekKart.dart';
import 'package:yardimfeneri/extantion/size_extension.dart';

class KurumlarUyeIstekAtma extends StatefulWidget {
  const KurumlarUyeIstekAtma({Key key}) : super(key: key);

  @override
  _KurumlarUyeIstekAtmaState createState() => _KurumlarUyeIstekAtmaState();
}
List<DocumentSnapshot> etkinlikozelKatilimci = [];
List<String> etkinlikozelKatilimciidler = [];

class _KurumlarUyeIstekAtmaState extends State<KurumlarUyeIstekAtma> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        brightness: Brightness.light,
        backgroundColor: Colors.transparent,
        elevation: 0.0,
        iconTheme: new IconThemeData(color: Colors.black),
        title: Text(
          "Kuruluşlar",
          style: TextStyle(
              fontSize: 30.0.spByWidth,
              fontWeight: FontWeight.bold,
              color: Colors.black),
        ),
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back,
            color: Theme.of(context).primaryColor,
            size: 17.0.h,
          ),
          onPressed: () {
            Navigator.pop(context,null);
          },
        ),

      ),
      body: StreamBuilder<QuerySnapshot>(
          stream: FirebaseFirestore.instance.collection('charities').snapshots(),
          builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(
                child: CircularProgressIndicator(),
              );
            }
            return  ListView.builder(
              shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(),
              itemCount: snapshot.data.docs.length,
              itemBuilder: (_, int index) {
                final DocumentSnapshot _card = snapshot.data.docs[index];

                return  UyeIstekKart(textSubtitle: null, textTitle: _card['isim'].toString(), onPressed: (){

                  Navigator.pop(context,_card);

                }, fontSize: 12,
                    img: _card['logo'].toString(), tarih: null);

              },
            );
          }

      ),
    );
  }
}
