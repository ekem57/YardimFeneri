import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:date_format/date_format.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';
import 'package:provider/provider.dart';
import 'package:yardimfeneri/COMMON/fullresim.dart';
import 'package:yardimfeneri/UI/charities/kampanya_destek.dart';
import 'package:yardimfeneri/UI/charities/yardima_ihtiyac_kampanya_katilim.dart';
import 'package:yardimfeneri/UI/odeme/odeme_sayfasi.dart';
import 'package:yardimfeneri/common/myButton.dart';
import 'package:yardimfeneri/extantion/size_extension.dart';
import 'package:yardimfeneri/firebasedb/database/firebasedbcharities.dart';
import 'package:yardimfeneri/locator.dart';
import 'package:yardimfeneri/servis/charities_service.dart';

enum FormType { Register }

bool descTextShowFlag = false;

class HomePageCharities extends StatefulWidget {
  @override
  _HomePageCharitiesState createState() => _HomePageCharitiesState();
}

class _HomePageCharitiesState extends State<HomePageCharities>  with SingleTickerProviderStateMixin{
  AnimationController controller;
  Animation<double> animation;
  String gelenfiltre="";
  String emre;
  Future<String> filter;
  String sharedileadligimfiltre="yok";
  FirebaseFirestore _firestore = FirebaseFirestore.instance;


  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    controller = AnimationController(
        duration: const Duration(milliseconds: 20), vsync: this);

  }



  @override
  Widget build(BuildContext context) {
    FirestoreDBServiceCharities _firestoreDBService = locator<FirestoreDBServiceCharities>();


    SystemChrome.setSystemUIOverlayStyle(
        SystemUiOverlayStyle(statusBarBrightness: Brightness.light)
    );
    CharitiesService _userModel = Provider.of<CharitiesService>(context);
    return SafeArea(
      child: Scaffold(
          appBar: AppBar(
            brightness: Brightness.light,
            backgroundColor: Colors.transparent,
            elevation: 0.0,
            iconTheme: new IconThemeData(color: Colors.black),
            title: Text(
              "Anasayfa",
              style: TextStyle(
                  fontSize: 30.0.spByWidth,
                  fontWeight: FontWeight.bold,
                  color: Colors.black),
            ),

          ),
          body: ListView(
            children: <Widget>[
              Divider(),
              StreamBuilder<QuerySnapshot>(
                stream: FirebaseFirestore.instance.collection('anasayfa').orderBy("date",descending: true).snapshots(),
                builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
                  if (!snapshot.hasData) return const Text('Yükleniyor...');
                  final int cardLength = snapshot.data.docs.length;
                  return new ListView.builder(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
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

                      Widget child;
                      if (_card['foto'] == "null" && _card['bicim'].toString() == "yardim") {
                        child = Column(
                          children: <Widget>[
                            StreamBuilder<QuerySnapshot>(
                              stream: FirebaseFirestore.instance
                                  .collection('charities').doc(_card['kurumid']).collection("isim_logo").snapshots(),
                              builder: (BuildContext context,
                                  AsyncSnapshot<QuerySnapshot> snapshot) {
                                if (!snapshot.hasData) return const Text('Connecting...');
                                final int cardLength = snapshot.data.docs.length;
                                return new ListView.builder(
                                  shrinkWrap: true,
                                  physics: const NeverScrollableScrollPhysics(),
                                  itemCount:1,
                                  itemBuilder: (_, int index) {
                                    final DocumentSnapshot _card2 = snapshot.data.docs[index];

                                    return  Row(
                                      mainAxisAlignment:
                                      MainAxisAlignment.spaceAround,
                                      children: <Widget>[
                                        SizedBox(
                                          height: 10.0.h,
                                        ),

                                        Expanded(
                                          child: Padding(
                                            padding:  EdgeInsets.only(right: 10.0.w),
                                            child: Row(
                                              mainAxisAlignment:
                                              MainAxisAlignment.start,
                                              children: <Widget>[
                                                Padding(
                                                  padding:  EdgeInsets.all(8.0.h),
                                                  child: GestureDetector(
                                                    onTap: () {
                                                      Navigator.push(context, MaterialPageRoute(builder: (context) =>ImageViewerPage(assetName: _card['logo'].toString(),)),);

                                                    },
                                                    child: Container(
                                                      width: 50.0.h,
                                                      height: 50.0.h,
                                                      decoration: BoxDecoration(
                                                        shape: BoxShape.circle,
                                                        image: DecorationImage(
                                                          fit: BoxFit.fill,
                                                          image: NetworkImage(
                                                              _card2['logo']),
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                                SizedBox(
                                                  width: 10.0.w,
                                                ),
                                                Expanded(
                                                  child: GestureDetector(
                                                    onTap: () {
//                                                      Navigator.push(context, MaterialPageRoute(builder: (context) =>KulupDetay(kulupid: _card["topid"].toString(),)),);
                                                    },
                                                    child: Column(
                                                      children: <Widget>[
                                                        Align(
                                                          alignment: Alignment.centerLeft,
                                                          child: Text(
                                                            _card2['isim'].toString(),
                                                            style: TextStyle(fontSize: 17.0.spByWidth),
                                                          ),
                                                        ),


                                                      ],
                                                    ),
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ),
                                        Padding(
                                          padding:  EdgeInsets.only(right: 20.0.w),
                                          child: differenceInMinut < 60
                                              ? Text(differenceInMinut.toString() +
                                              " Dakika Önce")
                                              : differenceInHours > 24
                                              ? Text(
                                            formatDate(
                                              _card['date'].toDate(),
                                              [dd, '-', mm, '-', yyyy],
                                            ),
                                            style: TextStyle(
                                                fontSize: 15,
                                                fontWeight:
                                                FontWeight.w500),
                                          )
                                              : Text(
                                              differenceInHours.toString() +
                                                  " Saat Önce"),
                                        ),
                                      ],
                                    );
                                  },
                                );
                              },
                            ),

                            Padding(
                              padding: EdgeInsets.only(left: 20.0.w),
                              child: DescriptionTextWidget(
                                text: _card['icerik'],
                              ),
                            ),
                            SizedBox(height: 10.0.h,),
                            Align(alignment: Alignment.topLeft,child:
                            Padding(
                              padding: EdgeInsets.only(left: 30.0.w),
                              child: Text("Toplanan: ",style: TextStyle(fontSize: 16.0.spByWidth,fontWeight: FontWeight.bold),),
                            )),
                            SizedBox(height: 10.0.h,),
                            Align(alignment: Alignment.topLeft,child:
                            Padding(
                              padding: EdgeInsets.only(left: 30.0.w),
                              child: Text(_card['toplanan'].toString()+" ₺",style: TextStyle(fontSize: 16.0.spByWidth,fontWeight: FontWeight.bold),),
                            )),
                            SizedBox(height: 10.0.h,),
                            _card['tamamlandi'] ? MyButton(text: "Destek Tamamlanmıştır", onPressed: ()
                            {

                            },
                              textColor: Colors.white, fontSize: 16.0.spByWidth, width: 280.0.w, height: 40.0.h,butonColor: Colors.blue,) :
                            MyButton(text: "Destek Ol", onPressed: ()
                            {
                              Navigator.push(context, MaterialPageRoute(builder: (context) =>YardimaIhtiyacKampanyaKatilim(yardim_id: _card['yardim_id'].toString(),kurum:_card['kurumid'].toString(),bagis:_card['toplanan'].toString())),);
                            },
                              textColor: Colors.white, fontSize: 16.0.spByWidth, width: 280.0.w, height: 40.0.h,butonColor: Colors.green,),
                            SizedBox(height: 10.0.h,),
                            Divider(),
                          ],
                        );
                      }
                      else if (_card['foto'] != "null" && _card['bicim'].toString() == "yardim") {
                        child = Column(
                          children: <Widget>[
                            StreamBuilder<QuerySnapshot>(
                              stream: FirebaseFirestore.instance
                                  .collection('charities').doc(_card['kurumid']).collection("isim_logo").snapshots(),
                              builder: (BuildContext context,
                                  AsyncSnapshot<QuerySnapshot> snapshot) {
                                if (!snapshot.hasData) return const Text('Connecting...');
                                final int cardLength = snapshot.data.docs.length;
                                return new ListView.builder(
                                  shrinkWrap: true,
                                  physics: const NeverScrollableScrollPhysics(),
                                  itemCount:1,
                                  itemBuilder: (_, int index) {
                                    final DocumentSnapshot _card2 = snapshot.data.docs[index];

                                    return  Row(
                                      mainAxisAlignment:
                                      MainAxisAlignment.spaceAround,
                                      children: <Widget>[
                                        SizedBox(
                                          height: 10.0.h,
                                        ),

                                        Expanded(
                                          child: Padding(
                                            padding:  EdgeInsets.only(right: 10.0.w),
                                            child: Row(
                                              mainAxisAlignment:
                                              MainAxisAlignment.start,
                                              children: <Widget>[
                                                Padding(
                                                  padding:  EdgeInsets.all(8.0.h),
                                                  child: GestureDetector(
                                                    onTap: () {
                                                      Navigator.push(context, MaterialPageRoute(builder: (context) =>ImageViewerPage(assetName: _card['logo'].toString(),)),);

                                                    },
                                                    child: Container(
                                                      width: 50.0.h,
                                                      height: 50.0.h,
                                                      decoration: BoxDecoration(
                                                        shape: BoxShape.circle,
                                                        image: DecorationImage(
                                                          fit: BoxFit.fill,
                                                          image: NetworkImage(
                                                              _card2['logo']),
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                                SizedBox(
                                                  width: 10.0.w,
                                                ),
                                                Expanded(
                                                  child: GestureDetector(
                                                    onTap: () {
//                                                      Navigator.push(context, MaterialPageRoute(builder: (context) =>KulupDetay(kulupid: _card["topid"].toString(),)),);
                                                    },
                                                    child: Column(
                                                      children: <Widget>[
                                                        Align(
                                                          alignment: Alignment.centerLeft,
                                                          child: Text(
                                                            _card2['isim'].toString(),
                                                            style: TextStyle(fontSize: 17.0.spByWidth),
                                                          ),
                                                        ),


                                                      ],
                                                    ),
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ),
                                        Padding(
                                          padding:  EdgeInsets.only(right: 20.0.w),
                                          child: differenceInMinut < 60
                                              ? Text(differenceInMinut.toString() +
                                              " Dakika Önce")
                                              : differenceInHours > 24
                                              ? Text(
                                            formatDate(
                                              _card['date'].toDate(),
                                              [dd, '-', mm, '-', yyyy],
                                            ),
                                            style: TextStyle(
                                                fontSize: 15,
                                                fontWeight:
                                                FontWeight.w500),
                                          )
                                              : Text(
                                              differenceInHours.toString() +
                                                  " Saat Önce"),
                                        ),
                                      ],
                                    );
                                  },
                                );
                              },
                            ),

                            Padding(
                              padding: EdgeInsets.only(left: 20.0.w),
                              child: DescriptionTextWidget(
                                text: _card['icerik'],
                              ),
                            ),
                            SizedBox(height: 10.0.h,),
                            Align(alignment: Alignment.topLeft,child:
                            Padding(
                              padding: EdgeInsets.only(left: 30.0.w),
                              child: Text("Toplanan: ",style: TextStyle(fontSize: 16.0.spByWidth,fontWeight: FontWeight.bold),),
                            )),
                            SizedBox(height: 10.0.h,),
                            Align(alignment: Alignment.topLeft,child:
                            Padding(
                              padding: EdgeInsets.only(left: 30.0.w),
                              child: Text(_card['toplanan'].toString()+" ₺",style: TextStyle(fontSize: 16.0.spByWidth,fontWeight: FontWeight.bold),),
                            )),
                            SizedBox(height: 10.0.h,),
                            _card['tamamlandi'] ? MyButton(text: "Destek Tamamlanmıştır", onPressed: ()
                            {

                            },
                              textColor: Colors.white, fontSize: 16.0.spByWidth, width: 280.0.w, height: 40.0.h,butonColor: Colors.blue,) :
                            MyButton(text: "Destek Ol", onPressed: ()
                            {
                              Navigator.push(context, MaterialPageRoute(builder: (context) =>YardimaIhtiyacKampanyaKatilim(yardim_id: _card['yardim_id'].toString(),kurum:_card['kurumid'].toString(),bagis:_card['toplanan'].toString())),);

                            },
                              textColor: Colors.white, fontSize: 16.0.spByWidth, width: 280.0.w, height: 40.0.h,butonColor: Colors.green,),
                            SizedBox(height: 10.0.h,),
                            Divider(),
                          ],
                        );
                      }
                      else if (_card['foto'] == "null" && _card['bicim'].toString() == "post") {
                        child = Column(
                          children: <Widget>[
                            StreamBuilder<QuerySnapshot>(
                              stream: FirebaseFirestore.instance
                                  .collection('charities').doc(_card['kurumid']).collection("isim_logo").snapshots(),
                              builder: (BuildContext context,
                                  AsyncSnapshot<QuerySnapshot> snapshot) {
                                if (!snapshot.hasData) return const Text('Connecting...');
                                final int cardLength = snapshot.data.docs.length;
                                return new ListView.builder(
                                  shrinkWrap: true,
                                  physics: const NeverScrollableScrollPhysics(),
                                  itemCount:1,
                                  itemBuilder: (_, int index) {
                                    final DocumentSnapshot _card2 = snapshot.data.docs[index];

                                    return  Row(
                                      mainAxisAlignment:
                                      MainAxisAlignment.spaceAround,
                                      children: <Widget>[
                                        SizedBox(
                                          height: 10.0.h,
                                        ),

                                        Expanded(
                                          child: Padding(
                                            padding:  EdgeInsets.only(right: 10.0.w),
                                            child: Row(
                                              mainAxisAlignment:
                                              MainAxisAlignment.start,
                                              children: <Widget>[
                                                Padding(
                                                  padding:  EdgeInsets.all(8.0.h),
                                                  child: GestureDetector(
                                                    onTap: () {
                                                      Navigator.push(context, MaterialPageRoute(builder: (context) =>ImageViewerPage(assetName: _card['logo'].toString(),)),);

                                                    },
                                                    child: Container(
                                                      width: 50.0.h,
                                                      height: 50.0.h,
                                                      decoration: BoxDecoration(
                                                        shape: BoxShape.circle,
                                                        image: DecorationImage(
                                                          fit: BoxFit.fill,
                                                          image: NetworkImage(
                                                              _card2['logo']),
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                                SizedBox(
                                                  width: 10.0.w,
                                                ),
                                                Expanded(
                                                  child: GestureDetector(
                                                    onTap: () {
//                                                      Navigator.push(context, MaterialPageRoute(builder: (context) =>KulupDetay(kulupid: _card["topid"].toString(),)),);

                                                    },
                                                    child: Column(
                                                      children: <Widget>[
                                                        Align(
                                                          alignment: Alignment.centerLeft,
                                                          child: Text(
                                                            _card2['isim'].toString(),
                                                            style: TextStyle(fontSize: 17.0.spByWidth),
                                                          ),
                                                        ),


                                                      ],
                                                    ),
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ),
                                        Padding(
                                          padding:  EdgeInsets.only(right: 20.0.w),
                                          child: differenceInMinut < 60
                                              ? Text(differenceInMinut.toString() +
                                              " Dakika Önce")
                                              : differenceInHours > 24
                                              ? Text(
                                            formatDate(
                                              _card['date'].toDate(),
                                              [dd, '-', mm, '-', yyyy],
                                            ),
                                            style: TextStyle(
                                                fontSize: 15,
                                                fontWeight:
                                                FontWeight.w500),
                                          )
                                              : Text(
                                              differenceInHours.toString() +
                                                  " Saat Önce"),
                                        ),
                                      ],
                                    );
                                  },
                                );
                              },
                            ),

                            Padding(
                              padding: EdgeInsets.only(left: 20.0.w),
                              child: DescriptionTextWidget(
                                text: _card['icerik'],
                              ),
                            ),
                            StreamBuilder<QuerySnapshot>(
                                stream: FirebaseFirestore.instance
                                    .collection('userspost')
                                    .doc(_userModel.user.userId)
                                    .collection('katilimci').where('postid',isEqualTo: _card['postid'])
                                    .snapshots(),
                                builder: (BuildContext context,
                                    AsyncSnapshot<QuerySnapshot> snapshot) {
                                  if (!snapshot.hasData)
                                    return Center(
                                        child:
                                        const CircularProgressIndicator());
                                  return new ListView.builder(
                                      shrinkWrap: true,
                                      physics:
                                      const NeverScrollableScrollPhysics(),
                                      itemCount: 1,

                                      itemBuilder: (BuildContext context, int index) {

                                       return Userpost(snapshot,index,_card,context);

                                      });
                                }),
                            Divider(),
                          ],
                        );
                      }
                      else if (_card['foto'] != "null" && _card['bicim'] == "post") {
                        child = Column(
                          children: <Widget>[
                            StreamBuilder<QuerySnapshot>(
                              stream: FirebaseFirestore.instance
                                  .collection('charities').doc(_card['kurumid']).collection("isim_logo").snapshots(),
                              builder: (BuildContext context,
                                  AsyncSnapshot<QuerySnapshot> snapshot) {
                                if (!snapshot.hasData) return const Text('Connecting...');
                                final int cardLength = snapshot.data.docs.length;
                                return new ListView.builder(
                                  shrinkWrap: true,
                                  physics: const NeverScrollableScrollPhysics(),
                                  itemCount:1,
                                  itemBuilder: (_, int index) {
                                    final DocumentSnapshot _card2 = snapshot.data.docs[index];

                                    return  Row(
                                      mainAxisAlignment:
                                      MainAxisAlignment.spaceAround,
                                      children: <Widget>[
                                        SizedBox(
                                          height: 10,
                                        ),

                                        Expanded(
                                          child: Padding(
                                            padding: const EdgeInsets.only(right: 10),
                                            child: Row(
                                              mainAxisAlignment:
                                              MainAxisAlignment.start,
                                              children: <Widget>[
                                                Padding(
                                                  padding: const EdgeInsets.all(8.0),
                                                  child: GestureDetector(
                                                    onTap: () {
                                                      Navigator.push(context, MaterialPageRoute(builder: (context) =>ImageViewerPage(assetName: _card['logo'].toString(),)),);

                                                    },
                                                    child: Container(
                                                      width: 50,
                                                      height: 50,
                                                      decoration: BoxDecoration(
                                                        shape: BoxShape.circle,
                                                        image: DecorationImage(
                                                          fit: BoxFit.fill,
                                                          image: NetworkImage(
                                                              _card2['logo']),
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                                SizedBox(
                                                  width: 10,
                                                ),
                                                Expanded(
                                                  child: GestureDetector(
                                                    onTap: () {
                                                     // Navigator.push(context, MaterialPageRoute(builder: (context) =>KulupDetay(kulupid: _card["topid"].toString(),)),);
                                                    },
                                                    child: Column(
                                                      children: <Widget>[
                                                        Align(
                                                          alignment: Alignment.centerLeft,
                                                          child: Text(
                                                            _card2['isim'].toString(),
                                                            style: TextStyle(fontSize: 17),
                                                          ),
                                                        ),

                                                      ],
                                                    ),
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.only(right: 20),
                                          child: differenceInMinut < 60
                                              ? Text(differenceInMinut.toString() +
                                              " Dakika Önce")
                                              : differenceInHours > 24
                                              ? Text(
                                            formatDate(
                                              _card['date'].toDate(),
                                              [dd, '-', mm, '-', yyyy],
                                            ),
                                            style: TextStyle(
                                                fontSize: 15,
                                                fontWeight:
                                                FontWeight.w500),
                                          )
                                              : Text(
                                              differenceInHours.toString() +
                                                  " Saat Önce"),
                                        ),
                                      ],
                                    );
                                  },
                                );
                              },
                            ),

                            Padding(
                              padding:
                              const EdgeInsets.only(top: 10, bottom: 10),
                              // ignore: missing_return, missing_return, missing_return, missing_return
                              child: GestureDetector(
                                onTap: (){
                                  Navigator.push(context, MaterialPageRoute(builder: (context) =>ImageViewerPage(assetName: _card['foto'].toString(),)),);
                                },
                                child: Container(
                                  width: MediaQuery.of(context).size.width - 40,
                                  height: 220.0,
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
                            Padding(
                              padding: const EdgeInsets.only(left: 10),
                              child: DescriptionTextWidget(
                                  text: _card['icerik']),
                            ),
                            StreamBuilder<QuerySnapshot>(
                                stream: FirebaseFirestore.instance
                                    .collection('userspost')
                                    .doc(_userModel.user.userId)
                                    .collection('katilimci').where('postid',isEqualTo: _card['postid'])
                                    .snapshots(),
                                builder: (BuildContext context,
                                    AsyncSnapshot<QuerySnapshot> snapshot) {
                                  if (!snapshot.hasData)
                                    return Center(
                                        child:
                                        const CircularProgressIndicator());
                                  return new ListView.builder(
                                      shrinkWrap: true,
                                      physics:
                                      const NeverScrollableScrollPhysics(),
                                      itemCount: 1,
                                      // ignore: missing_return
                                      itemBuilder: (context, int index) {

                                        Widget child;
                                        if (snapshot.data.docs.toString() == "[]") {
                                          child = GestureDetector(
                                            onTap:(){gri_kalp_tikla(_card);},
                                            child: Padding(
                                              padding: const EdgeInsets.only(left: 20),
                                              child: Align(
                                                  alignment: Alignment.centerLeft,
                                                  child: Row(
                                                    children: <Widget>[
                                                      Container(
                                                          width: 30,
                                                          height: 30,
                                                          child: Image.asset("assets/gri_kalp.png")),
                                                      Padding(
                                                        padding: const EdgeInsets.all(8.0),
                                                        child: Text(_card['like'].toString(),style: TextStyle(),),
                                                      ),
                                                    ],
                                                  )),
                                            ),
                                          );
                                        } else if (snapshot.data.docs[0]['onay'] == false) {
                                          child = GestureDetector(
                                            onTap: (){gri_kalp_tikla(_card);},
                                            child: Padding(
                                              padding: const EdgeInsets.only(left: 20),
                                              child: Align(
                                                alignment: Alignment.centerLeft,
                                                child: Row(
                                                  children: <Widget>[
                                                    Container(
                                                        width: 30,
                                                        height: 30,
                                                        child: Image.asset(
                                                            "assets/gri_kalp.png")),
                                                    Padding(
                                                      padding: const EdgeInsets.all(8.0),
                                                      child: Text(_card['like'].toString(),style: TextStyle(),),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            ),
                                          );
                                        } else if (snapshot.data.docs[0]['onay'] == true) {
                                          child = GestureDetector(
                                            onTap: (){
                                              kirmizi_kalp_tikla(_card);
                                            },
                                            child: Padding(
                                              padding: const EdgeInsets.only(left: 20),
                                              child: Align(
                                                alignment: Alignment.centerLeft,
                                                child: Row(
                                                  children: <Widget>[
                                                    Container(
                                                        width: 30,
                                                        height: 30,
                                                        child: Image.asset(
                                                            "assets/kirmizi_kalp.png")),
                                                    Padding(
                                                      padding: const EdgeInsets.all(8.0),
                                                      child: Text(_card['like'].toString(),style: TextStyle(),),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            ),
                                          );
                                        }
                                        return child;
                                      });
                                }),
                            Divider(),
                          ],
                        );
                      }
                      else if (_card['foto'] != "null" && _card['bicim'] == "kampanya") {
                        child = Column(
                          children: <Widget>[
                            StreamBuilder<QuerySnapshot>(
                              stream: FirebaseFirestore.instance
                                  .collection('charities').doc(_card['kurumid']).collection("isim_logo").snapshots(),
                              builder: (BuildContext context,
                                  AsyncSnapshot<QuerySnapshot> snapshot) {
                                if (!snapshot.hasData) return const Text('Connecting...');
                                final int cardLength = snapshot.data.docs.length;
                                return new ListView.builder(
                                  shrinkWrap: true,
                                  physics: const NeverScrollableScrollPhysics(),
                                  itemCount:1,
                                  itemBuilder: (_, int index) {
                                    final DocumentSnapshot _card2 = snapshot.data.docs[index];

                                    return  Row(
                                      mainAxisAlignment:
                                      MainAxisAlignment.spaceAround,
                                      children: <Widget>[
                                        SizedBox(
                                          height: 10,
                                        ),

                                        Expanded(
                                          child: Padding(
                                            padding: const EdgeInsets.only(right: 10),
                                            child: Row(
                                              mainAxisAlignment:
                                              MainAxisAlignment.start,
                                              children: <Widget>[
                                                Padding(
                                                  padding: const EdgeInsets.all(8.0),
                                                  child: GestureDetector(
                                                    onTap: () {
                                                      Navigator.push(context, MaterialPageRoute(builder: (context) =>ImageViewerPage(assetName: _card['logo'].toString(),)),);

                                                    },
                                                    child: Container(
                                                      width: 50,
                                                      height: 50,
                                                      decoration: BoxDecoration(
                                                        shape: BoxShape.circle,
                                                        image: DecorationImage(
                                                          fit: BoxFit.fill,
                                                          image: NetworkImage(
                                                              _card2['logo']),
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                                SizedBox(
                                                  width: 10,
                                                ),
                                                Expanded(
                                                  child: GestureDetector(
                                                    onTap: () {
                                                      // Navigator.push(context, MaterialPageRoute(builder: (context) =>KulupDetay(kulupid: _card["topid"].toString(),)),);
                                                    },
                                                    child: Column(
                                                      children: <Widget>[
                                                        Align(
                                                          alignment: Alignment.centerLeft,
                                                          child: Text(
                                                            _card2['isim'].toString(),
                                                            style: TextStyle(fontSize: 17),
                                                          ),
                                                        ),

                                                      ],
                                                    ),
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.only(right: 20),
                                          child: differenceInMinut < 60
                                              ? Text(differenceInMinut.toString() +
                                              " Dakika Önce")
                                              : differenceInHours > 24
                                              ? Text(
                                            formatDate(
                                              _card['date'].toDate(),
                                              [dd, '-', mm, '-', yyyy],
                                            ),
                                            style: TextStyle(
                                                fontSize: 15,
                                                fontWeight:
                                                FontWeight.w500),
                                          )
                                              : Text(
                                              differenceInHours.toString() +
                                                  " Saat Önce"),
                                        ),
                                      ],
                                    );
                                  },
                                );
                              },
                            ),

                            Padding(
                              padding:
                              const EdgeInsets.only(top: 10, bottom: 10),
                              // ignore: missing_return, missing_return, missing_return, missing_return
                              child: GestureDetector(
                                onTap: (){
                                  Navigator.push(context, MaterialPageRoute(builder: (context) =>ImageViewerPage(assetName: _card['foto'].toString(),)),);
                                },
                                child: Container(
                                  width: MediaQuery.of(context).size.width - 40,
                                  height: 220.0,
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
                            Padding(
                              padding: const EdgeInsets.only(left: 10),
                              child: DescriptionTextWidget(
                                  text: _card['icerik']),
                            ),
                            SizedBox(height: 10.0.h,),
                            Align(alignment: Alignment.topLeft,child:
                            Padding(
                              padding: EdgeInsets.only(left: 30.0.w),
                              child: Text("Toplanan: ",style: TextStyle(fontSize: 16.0.spByWidth,fontWeight: FontWeight.bold),),
                            )),
                            SizedBox(height: 10.0.h,),
                            Align(alignment: Alignment.topLeft,child:
                            Padding(
                              padding: EdgeInsets.only(left: 30.0.w),
                              child: Text(_card['toplanan_tutar'].toString()+" ₺",style: TextStyle(fontSize: 16.0.spByWidth,fontWeight: FontWeight.bold),),
                            )),
                            SizedBox(height: 10.0.h,),
                            _card['tamamlandi'] ?
                            MyButton(text: "Kampanyaya Tamamlanmıştır", onPressed: ()
                            {

                            },
                              textColor: Colors.white, fontSize: 16.0.spByWidth, width: 280.0.w, height: 40.0.h,butonColor: Colors.blue,) :

                            MyButton(text: "Kampanyaya Destek Ol", onPressed: ()
                            {
                              Navigator.push(context, MaterialPageRoute(builder: (context) =>KampanyaDestekGonderme(yardim_id: _card['postid'].toString(),kurum:_card['kurumid'].toString(),bagis:_card['toplanan_tutar'].toString())),);

                            },
                              textColor: Colors.white, fontSize: 16.0.spByWidth, width: 280.0.w, height: 40.0.h,butonColor: Colors.green,),
                            SizedBox(height: 10.0.h,),
                            Divider(),
                          ],
                        );
                      }
                      else if (_card['foto'] == "null" && _card['bicim'].toString() == "kampanya") {
                        child = Column(
                          children: <Widget>[
                            StreamBuilder<QuerySnapshot>(
                              stream: FirebaseFirestore.instance
                                  .collection('charities').doc(_card['kurumid']).collection("isim_logo").snapshots(),
                              builder: (BuildContext context,
                                  AsyncSnapshot<QuerySnapshot> snapshot) {
                                if (!snapshot.hasData) return const Text('Connecting...');
                                final int cardLength = snapshot.data.docs.length;
                                return new ListView.builder(
                                  shrinkWrap: true,
                                  physics: const NeverScrollableScrollPhysics(),
                                  itemCount:1,
                                  itemBuilder: (_, int index) {
                                    final DocumentSnapshot _card2 = snapshot.data.docs[index];

                                    return  Row(
                                      mainAxisAlignment:
                                      MainAxisAlignment.spaceAround,
                                      children: <Widget>[
                                        SizedBox(
                                          height: 10.0.h,
                                        ),

                                        Expanded(
                                          child: Padding(
                                            padding:  EdgeInsets.only(right: 10.0.w),
                                            child: Row(
                                              mainAxisAlignment:
                                              MainAxisAlignment.start,
                                              children: <Widget>[
                                                Padding(
                                                  padding:  EdgeInsets.all(8.0.h),
                                                  child: GestureDetector(
                                                    onTap: () {
                                                      Navigator.push(context, MaterialPageRoute(builder: (context) =>ImageViewerPage(assetName: _card['logo'].toString(),)),);

                                                    },
                                                    child: Container(
                                                      width: 50.0.h,
                                                      height: 50.0.h,
                                                      decoration: BoxDecoration(
                                                        shape: BoxShape.circle,
                                                        image: DecorationImage(
                                                          fit: BoxFit.fill,
                                                          image: NetworkImage(
                                                              _card2['logo']),
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                                SizedBox(
                                                  width: 10.0.w,
                                                ),
                                                Expanded(
                                                  child: GestureDetector(
                                                    onTap: () {
//                                                      Navigator.push(context, MaterialPageRoute(builder: (context) =>KulupDetay(kulupid: _card["topid"].toString(),)),);

                                                    },
                                                    child: Column(
                                                      children: <Widget>[
                                                        Align(
                                                          alignment: Alignment.centerLeft,
                                                          child: Text(
                                                            _card2['isim'].toString(),
                                                            style: TextStyle(fontSize: 17.0.spByWidth),
                                                          ),
                                                        ),


                                                      ],
                                                    ),
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ),
                                        Padding(
                                          padding:  EdgeInsets.only(right: 20.0.w),
                                          child: differenceInMinut < 60
                                              ? Text(differenceInMinut.toString() +
                                              " Dakika Önce")
                                              : differenceInHours > 24
                                              ? Text(
                                            formatDate(
                                              _card['date'].toDate(),
                                              [dd, '-', mm, '-', yyyy],
                                            ),
                                            style: TextStyle(
                                                fontSize: 15,
                                                fontWeight:
                                                FontWeight.w500),
                                          )
                                              : Text(
                                              differenceInHours.toString() +
                                                  " Saat Önce"),
                                        ),
                                      ],
                                    );
                                  },
                                );
                              },
                            ),

                            Padding(
                              padding: EdgeInsets.only(left: 20.0.w),
                              child: DescriptionTextWidget(
                                text: _card['icerik'],
                              ),
                            ),
                            SizedBox(height: 10.0.h,),
                            Align(alignment: Alignment.topLeft,child:
                            Padding(
                              padding: EdgeInsets.only(left: 30.0.w),
                              child: Text("Toplanan: ",style: TextStyle(fontSize: 16.0.spByWidth,fontWeight: FontWeight.bold),),
                            )),
                            SizedBox(height: 10.0.h,),
                            Align(alignment: Alignment.topLeft,child:
                            Padding(
                              padding: EdgeInsets.only(left: 30.0.w),
                              child: Text(_card['toplanan_tutar'].toString()+" ₺",style: TextStyle(fontSize: 16.0.spByWidth,fontWeight: FontWeight.bold),),
                            )),
                            SizedBox(height: 10.0.h,),

                            _card['tamamlandi'] ?
                            MyButton(text: "Kampanyaya Tamamlanmıştır", onPressed: ()
                            {

                            },
                              textColor: Colors.white, fontSize: 16.0.spByWidth, width: 280.0.w, height: 40.0.h,butonColor: Colors.blue,) :
                            MyButton(text: "Kampanyaya Destek Ol", onPressed: ()
                            {
                              Navigator.push(context, MaterialPageRoute(builder: (context) =>KampanyaDestekGonderme(yardim_id: _card['postid'].toString(),kurum:_card['kurumid'].toString(),bagis:_card['toplanan_tutar'].toString())),);

                            },
                              textColor: Colors.white, fontSize: 16.0.spByWidth, width: 280.0.w, height: 40.0.h,butonColor: Colors.green,),
                            SizedBox(height: 10.0.h,),
                            Divider(),
                          ],
                        );
                      }
                      return child;
                    },
                  );
                },
              ),
              SizedBox(
                height: 80.0.h,
              ),
            ],
          )),
    );
  }




  Future<void>  gri_kalp_tikla(DocumentSnapshot card)  async {
    CharitiesService _userModel = Provider.of<CharitiesService>(context,listen: false);

    _firestore.runTransaction((Transaction transaction) async {
      await transaction.update(
          _firestore
              .collection("anasayfa")
              .doc(card.id.toString()),
          {'like': FieldValue.increment(1)});
    });

    Map<String, dynamic> EtkinlikEkle = Map();

    EtkinlikEkle['postid'] = card['postid'];
    EtkinlikEkle['onay'] = true;
    _firestore.collection("userspost").doc(_userModel.user.userId).collection("katilimci").doc(card.id).set(EtkinlikEkle);


  }
  Future<void> kirmizi_kalp_tikla(DocumentSnapshot card) async {

    CharitiesService _userModel = Provider.of<CharitiesService>(context,listen:false);

    _firestore.runTransaction((Transaction transaction) async {
      await transaction.update(
          _firestore
              .collection("anasayfa")
              .doc(card.id.toString()),
          {'like': FieldValue.increment(-1)});
    });

    Map<String, dynamic> EtkinlikEkle = Map();

    EtkinlikEkle['postid'] = card['postid'];
    EtkinlikEkle['onay'] = false;
    _firestore.collection("userspost").doc(_userModel.user.userId).collection("katilimci").doc(card.id).set(EtkinlikEkle);

  }


  Widget Userpost(AsyncSnapshot<QuerySnapshot> snapshot,int index,DocumentSnapshot _card,BuildContext context) {
     Widget child;
    if (snapshot.data.docs.toString() == "[]") {
      child = GestureDetector(
        onTap:(){gri_kalp_tikla(_card);},
        child: Padding(
          padding: const EdgeInsets.only(left: 20),
          child: Align(
              alignment: Alignment.centerLeft,
              child: Row(
                children: <Widget>[
                  Container(
                      width: 30,
                      height: 30,
                      child: Image.asset("assets/gri_kalp.png")),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(_card['like'].toString(),style: TextStyle(),),
                  ),
                ],
              )),
        ),
      );
    }
    else if (snapshot.data.docs[0]['onay'] == false) {
      child = GestureDetector(
        onTap: (){gri_kalp_tikla(_card);},
        child: Padding(
          padding: const EdgeInsets.only(left: 20),
          child: Align(
            alignment: Alignment.centerLeft,
            child: Row(
              children: <Widget>[
                Container(
                    width: 30,
                    height: 30,
                    child: Image.asset(
                        "assets/gri_kalp.png")),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(_card['like'].toString(),style: TextStyle(),),
                ),
              ],
            ),
          ),
        ),
      );
    }
    else if (snapshot.data.docs[0]['onay'] ==
        true) {
      child = GestureDetector(
        onTap: (){
          kirmizi_kalp_tikla(_card);
        },
        child: Padding(
          padding: const EdgeInsets.only(left: 20),
          child: Align(
            alignment: Alignment.centerLeft,
            child: Row(
              children: <Widget>[
                Container(
                    width: 30,
                    height: 30,
                    child: Image.asset(
                        "assets/kirmizi_kalp.png")),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(_card['like'].toString(),style: TextStyle(),),
                ),
              ],
            ),
          ),
        ),
      );
    }
    return  child;
  }



}

class DescriptionTextWidget extends StatefulWidget {
  final String text;

  DescriptionTextWidget({this.text});

  @override
  _DescriptionTextWidgetState createState() =>
      new _DescriptionTextWidgetState();
}

class _DescriptionTextWidgetState extends State<DescriptionTextWidget> {
  String firstHalf;
  String secondHalf;

  bool flag = true;

  @override
  void initState() {
    super.initState();

    if (widget.text.length > 300) {
      firstHalf = widget.text.substring(0, 300);
      secondHalf = widget.text.substring(300, widget.text.length);
    } else {
      firstHalf = widget.text;
      secondHalf = "";
    }
  }

  @override
  Widget build(BuildContext context) {
    return new Container(
      padding: new EdgeInsets.symmetric(horizontal: 10.0, vertical: 10.0),
      child: secondHalf.isEmpty
          ? new Text(
        firstHalf,
        style: TextStyle(fontSize: 18),
      )
          : new Column(
        children: <Widget>[
          new Text(
            flag ? (firstHalf + "...") : (firstHalf + secondHalf),
            style: TextStyle(fontSize: 18),
          ),
          new InkWell(
            child: new Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: <Widget>[
                new Text(
                  flag ? "devamını oku" : "gizle",
                  style: new TextStyle(color: Colors.blue),
                ),
              ],
            ),
            onTap: () {
              setState(() {
                flag = !flag;
              });
            },
          ),
        ],
      ),
    );
  }
}
