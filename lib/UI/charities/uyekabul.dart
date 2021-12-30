import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:yardimfeneri/common/uyekabul.dart';
import 'package:yardimfeneri/firebasedb/database/firebasedbcharities.dart';
import 'package:yardimfeneri/locator.dart';
import 'package:yardimfeneri/servis/charities_service.dart';

class CharitiesUyeKabul extends StatefulWidget {
  const CharitiesUyeKabul({Key key}) : super(key: key);

  @override
  _CharitiesUyeKabulState createState() => _CharitiesUyeKabulState();
}

class _CharitiesUyeKabulState extends State<CharitiesUyeKabul> {
  @override
  Widget build(BuildContext context) {
    final _charitiesModel = Provider.of<CharitiesService>(context, listen: true);
    FirestoreDBServiceCharities _firestoreDBService = locator<FirestoreDBServiceCharities>();

    return Scaffold(
      appBar: AppBar(),
      body: StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance.collection('charities').doc(_charitiesModel.user.userId).collection("uyebasvuru").snapshots(),
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (!snapshot.hasData) {
            return Center(
              child: CircularProgressIndicator(),
            );
          }
          final int cardLength = snapshot.data.docs.length;

          return ListView.builder(
            shrinkWrap: true,
            physics: NeverScrollableScrollPhysics(),
            itemCount: cardLength,
            itemBuilder: (_, int index) {
              final DocumentSnapshot _card = snapshot.data.docs[index];
              print("Üye işlemleri _card: " + _card.data().toString());
              return UyeKabulKart(textTitle: _card['isim'],
                img: _card['foto'].toString(),
                textSubtitle: _card['meslek'],
                onPressedKabul: (){
                  _firestoreDBService.uyekabul(_charitiesModel.user.userId, _card['userid'], _card['uyetipi']);
                },
                onPressedRed: (){
                  _firestoreDBService.uyered(_charitiesModel.user.userId, _card['userid']);
                },);

            },
          );
        },
      ),

    );
  }
}
