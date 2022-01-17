import 'dart:async';
import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:yardimfeneri/ChattApp/SohbetPageYonetici.dart';
import 'package:yardimfeneri/ChattApp/chat_view_model.dart';
import 'package:yardimfeneri/ChattApp/chat_view_model_Yonetici.dart';
import 'package:yardimfeneri/ChattApp/sohbetPage.dart';
import 'package:yardimfeneri/common/resimlicard.dart';
import 'package:yardimfeneri/extantion/size_extension.dart';
import 'package:yardimfeneri/model/helpful_model.dart';
import 'package:yardimfeneri/model/needy_model.dart';
import 'package:yardimfeneri/servis/helpful_service.dart';
import 'package:yardimfeneri/servis/needy_service.dart';

class ChattKisiSecNeedy extends StatefulWidget {
  @override
  _ChattKisiSecNeedyState createState() => _ChattKisiSecNeedyState();
}



class _ChattKisiSecNeedyState extends State<ChattKisiSecNeedy> {
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
          stream: FirebaseFirestore.instance.collection('needy').snapshots(),
          builder: (BuildContext context,
              AsyncSnapshot<QuerySnapshot> snapshot) {
            if (!snapshot.hasData){
              return Center(child: CircularProgressIndicator(),);
            }
            final int cardLength = snapshot.data.docs.length;


            return ListView.builder(
              shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(),
              itemCount: cardLength,
              itemBuilder: (_, int index) {

                final DocumentSnapshot _card = snapshot.data.docs[index];

                return Column(
                  children: [
                    ResimliCard(textSubtitle: null, textTitle: _card['isim'].toString(), fontSize: 12.0.spByWidth,
                      img: _card['foto'].toString(), tarih: null,
                      onPressed: (){
                        print("current user: "+_ogretmenModel.user.userId.toString());
                        print("EMREEEEE sohbet user: "+_card.data().toString());
                        Navigator.of(context, rootNavigator: true).push(
                          MaterialPageRoute(
                            builder: (context) => ChangeNotifierProvider(
                              create: (context) => ChatViewModel(currentUser: _ogretmenModel.user, sohbetEdilenUser: NeedyModel.fromMap(_card.data())),
                              child: SohbetPageHelpful(fotourl:  _card['foto'].toString(),userad:  _card['isim'].toString(),userid: _card['userID']),
                            ),
                          ),
                        );
                      },


                    ),
                    SizedBox(height: 10.0.h,),
                  ],
                );

              },
            );

          },
        ),
      ),
    );
  }
}