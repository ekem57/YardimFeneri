import 'dart:async';
import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:yardimfeneri/ChattApp/chat_view_model.dart';
import 'package:yardimfeneri/ChattApp/sohbetPage.dart';
import 'package:yardimfeneri/common/resimlicard.dart';
import 'package:yardimfeneri/extensions/size_extension.dart';
import 'package:yardimfeneri/model/needy_model.dart';
import 'package:yardimfeneri/service/helpful_service.dart';

class ChattKisiSec extends StatefulWidget {
  @override
  _ChattKisiSecState createState() => _ChattKisiSecState();
}


class _ChattKisiSecState extends State<ChattKisiSec> {
  bool isSearching = false;
  List<DocumentSnapshot> totalUsers = [];
  List data=[];


  @override
  Widget build(BuildContext context) {
    final _ogretmenModel = Provider.of<HelpfulService>(context, listen: false);

    return  Scaffold(
      backgroundColor: Colors.green,
      appBar: AppBar(
        backgroundColor:  Colors.white,
        title: Text("Kişi Seç",
            style: TextStyle(
                color: Colors.black,
                fontWeight: FontWeight.w700,
                fontFamily: "OpenSans",
                fontStyle: FontStyle.normal,
                fontSize: 21.7.spByWidth),
           ),
        leading: IconButton(
          icon: Platform.isAndroid ? Icon(
            Icons.arrow_back,
            color: Colors.deepPurpleAccent,
            size: 18.0.h,
          ): Icon(
            Icons.arrow_back_ios,
            color: Colors.deepPurpleAccent,
            size: 18.0.h,
          ) ,
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
        elevation: 0.0,
        brightness: Brightness.light,


      ),
      body: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
       color: Colors.white,
        child: StreamBuilder<QuerySnapshot>(
          stream: FirebaseFirestore.instance.collection('ogretmen').snapshots(),
          builder: (BuildContext context,
              AsyncSnapshot<QuerySnapshot> snapshot) {
            if (!snapshot.hasData){
              return Center(child: CircularProgressIndicator(),);
            }
            final int cardLength = snapshot.data!.docs.length;


            return ListView.builder(
              shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(),
              itemCount: cardLength,
              itemBuilder: (_, int index) {

                final DocumentSnapshot _card = snapshot.data!.docs[index];

                return ResimliCard(textSubtitle: null, textTitle: _card['adSoyad'].toString(), fontSize: 12.0.spByWidth,
                  img: _card['avatarImageUrl'].toString(), tarih: null,
                  onPressed: (){

                    Navigator.of(context, rootNavigator: true).push(
                      MaterialPageRoute(
                        builder: (context) => ChangeNotifierProvider(
                          create: (context) => ChatViewModel(currentUser: _ogretmenModel.user, sohbetEdilenUser: NeedyModel.fromMap(_card.data() as Map<String, dynamic> )),
                          child: SohbetPage(fotourl:  _card['avatarImageUrl'].toString(),userad:  _card['adSoyad'].toString(),userid: _card['userId']),
                        ),
                      ),
                    );
                  },


                );

              },
            );

          },
        ),
      ),
    );
  }
}
