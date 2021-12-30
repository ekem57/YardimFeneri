import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:yardimfeneri/common/fullresim.dart';
import 'package:yardimfeneri/common/kullanici_profil.dart';
import 'package:yardimfeneri/extantion/size_extension.dart';
import 'package:yardimfeneri/firebasedb/database/firebasedbcharities.dart';
import 'package:yardimfeneri/locator.dart';
import 'package:yardimfeneri/servis/charities_service.dart';

class YardimIstegiGonderme extends StatefulWidget {
  const YardimIstegiGonderme({Key key}) : super(key: key);

  @override
  _YardimIstegiGondermeState createState() => _YardimIstegiGondermeState();
}

class _YardimIstegiGondermeState extends State<YardimIstegiGonderme> {
  @override
  Widget build(BuildContext context) {
    final _charitiesService = Provider.of<CharitiesService>(context, listen: true);
    FirestoreDBServiceCharities _firestoreDBService = locator<FirestoreDBServiceCharities>();

    return Scaffold(
      appBar: AppBar(
        brightness: Brightness.light,
        backgroundColor: Colors.transparent,
        elevation: 0.0,
        iconTheme: new IconThemeData(color: Colors.black),
        title: Text(
          "Yardım İstekleri",
          style: TextStyle(
              fontSize: 30.0.spByWidth,
              fontWeight: FontWeight.bold,
              color: Colors.black),
        ),

      ),
      body: ListView(
        children: [
          SizedBox(height: 10.0.h,),
          StreamBuilder<QuerySnapshot>(
            stream: FirebaseFirestore.instance.collection('charities').doc(_charitiesService.user.userId).collection("ihtiyac_sahipleri_yardim_istekleri").orderBy("date",descending: true).snapshots(),
            builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
              if (!snapshot.hasData) return const Text('Yükleniyor...');
              final int cardLength = snapshot.data.docs.length;
              return new ListView.builder(
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                itemCount: cardLength,
                itemBuilder: (BuildContext context, int index) {
                  final DocumentSnapshot _card = snapshot.data.docs[index];
                  DateTime dateTimeCreatedAt =
                  DateTime.parse(_card['date'].toDate().toString());
                  DateTime dateTimeNow = DateTime.now();
                  final differenceInDays =
                      dateTimeNow.difference(dateTimeCreatedAt).inDays;
                  final differenceInHours =
                      dateTimeNow.difference(dateTimeCreatedAt).inHours;
                  final differenceInMinut =
                      dateTimeNow.difference(dateTimeCreatedAt).inMinutes;

                  return StreamBuilder<DocumentSnapshot>(
                    stream: FirebaseFirestore.instance.collection('needy').doc(_card['userid']).snapshots(),
                    builder: (BuildContext context, AsyncSnapshot<DocumentSnapshot> snapshot2) {
                      if (!snapshot2.hasData) return const Text('Yükleniyor...');
                      final DocumentSnapshot _card2 = snapshot2.data;

                      return Padding(
                        padding: EdgeInsets.symmetric(horizontal: 21.0.w,vertical: 10.0.h),
                        child:  GestureDetector(
                          onTap: (){
                            Navigator.push(context, MaterialPageRoute(builder: (context) =>KullaniciProfilPage(user: _card2,)),);
                          },
                          child: Container(
                            width: MediaQuery.of(context).size.width,
                            alignment: Alignment.center,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.all(Radius.circular(11.70.w)),
                                boxShadow: [
                                  BoxShadow(
                                      color: const Color(0x26000000),
                                      offset: Offset(0, 0),
                                      blurRadius: 5.50,
                                      spreadRadius: 0.5)
                                ],
                                color: Colors.white),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                SizedBox(height: 20.0.h,),
                                Padding(
                                  padding: EdgeInsets.only(left: 20.0.w),
                                  child: Align(
                                    alignment: Alignment.topLeft,
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.start,
                                      children: [
                                        CircleAvatar(
                                          backgroundImage: NetworkImage(_card2['foto']),
                                          radius: 33.0.w,
                                        ),
                                        SizedBox(width: 20.0.w,),
                                        Column(
                                          children: [
                                            Text(
                                              _card2['isim'].toString()+" "+_card2['soyisim'].toString(),
                                              textAlign: TextAlign.left,
                                              style: TextStyle(
                                                  color: const Color(0xff343633),
                                                  fontWeight: FontWeight.bold,
                                                  fontFamily: "OpenSans",
                                                  fontStyle: FontStyle.italic,
                                                  fontSize: 16.7.spByWidth),
                                            ),
                                            SizedBox(height: 5.0.h,),
                                            Padding(
                                              padding: EdgeInsets.only(left: 7.0.w),
                                              child: Text(
                                                _card2['telefon'].toString(),
                                                textAlign: TextAlign.left,
                                                style: TextStyle(
                                                    color: const Color(0xff343633),
                                                    fontWeight: FontWeight.bold,
                                                    fontFamily: "OpenSans",
                                                    fontStyle: FontStyle.italic,
                                                    fontSize: 12.7.spByWidth),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                                SizedBox(height: 10.0.h,),

                                Padding(
                                  padding:  EdgeInsets.only(left: 25.0.w,right: 25.0.w,top: 10.0.h),
                                  child: Align(
                                    alignment: Alignment.topLeft,
                                    child: Text(
                                      _card['mesaj'].toString(),
                                      textAlign: TextAlign.left,
                                      style: TextStyle(
                                          color: const Color(0xff343633),
                                          fontWeight: FontWeight.w600,
                                          fontFamily: "OpenSans",
                                          fontStyle: FontStyle.normal,
                                          fontSize: 16.7.spByWidth),
                                    ),
                                  ),
                                ),
                                _card['foto'].toString() =="null" ? Container() :
                                InkWell(
                                  onTap: (){
                                    Navigator.push(context, MaterialPageRoute(builder: (context) =>ImageViewerPage(assetName: _card['foto'].toString(),)),);
                                  },
                                  child: Padding(
                                    padding: const EdgeInsets.all(18.0),
                                    child: Container(
                                      width: MediaQuery.of(context).size.width - 40,
                                      height: 180.0,
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(20),
                                        image: DecorationImage(
                                            fit: BoxFit.fill,
                                            image: NetworkImage(
                                                _card['foto'].toString())),
                                      ),
                                    ),
                                  ),
                                ),
                                SizedBox(height: 15.0.h,),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                                  children: [
                                    Container(
                                      width: 120.0.w,
                                      height: 27.0.h,
                                      child: ElevatedButton(
                                        onPressed: (){
                                          _firestoreDBService.yardimonay(_card['mesaj'], _charitiesService.user.userId,_card['userid'], _card['yardim_id'],_card);
                                        },
                                        child: Text("Yayınla"),
                                        style: ButtonStyle(
                                          backgroundColor: MaterialStateProperty.all<Color>(Colors.green),
                                        ),
                                      ),
                                    ),
                                    Container(
                                      width: 120.0.w,
                                      height: 27.0.h,
                                      child: ElevatedButton(
                                        onPressed: (){
                                          _firestoreDBService.yardimred(_card);
                                        },
                                        child: Text("Sil"),
                                        style: ButtonStyle(
                                          backgroundColor: MaterialStateProperty.all<Color>(Colors.red),
                                        ),
                                      ),
                                    ),
                                  ],),
                                SizedBox(height: 20.0.h,),
                              ],
                            ),
                          ),
                        ),
                      );

                    },
                  );
                },
              );
            },
          ),
          SizedBox(height: 50.0.h,),
        ],
      ),
    );
  }
}
