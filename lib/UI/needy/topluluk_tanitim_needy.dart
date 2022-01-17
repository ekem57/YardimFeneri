import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:date_format/date_format.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:yardimfeneri/common/myButton.dart';
import 'package:yardimfeneri/extantion/size_extension.dart';
import 'package:yardimfeneri/firebasedb/database/firebasedbcharities.dart';
import 'package:yardimfeneri/locator.dart';
import 'package:yardimfeneri/servis/needy_service.dart';

class ToplulukTanitimNeedy extends StatefulWidget {
  final String kurumid;
  const ToplulukTanitimNeedy({Key key,@required this.kurumid}) : super(key: key);

  @override
  _ToplulukTanitimNeedyState createState() => _ToplulukTanitimNeedyState();
}

class _ToplulukTanitimNeedyState extends State<ToplulukTanitimNeedy> {
  @override
  Widget build(BuildContext context) {
    NeedyService _userModel = Provider.of<NeedyService>(context);
    FirestoreDBServiceCharities _firestoreDBService = locator<FirestoreDBServiceCharities>();

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        iconTheme: IconThemeData(color: Colors.black),
      ),
      body:  StreamBuilder<DocumentSnapshot>(
        stream: FirebaseFirestore.instance
            .collection('charities').doc(widget.kurumid).snapshots(),
        builder: (BuildContext context,
            AsyncSnapshot<DocumentSnapshot> snapshot) {
          if (!snapshot.hasData) return const Text('Connecting...');
          final int cardLength = 1;
          final DocumentSnapshot _card = snapshot.data;
          return ListView(
            children: <Widget>[


              Center(
                child: Column(
                  children: <Widget>[

                    Container(
                        width: 120.0.h,
                        height: 120.0.h,
                        margin: EdgeInsets.all(
                            10.0.w
                        ),
                        decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(100.0),
                            boxShadow:[
                              BoxShadow(
                                  color: Color.fromARGB(60, 0, 0, 0),
                                  blurRadius: 5.0,
                                  offset: Offset(3.0, 3.0)
                              )
                            ],
                            image: DecorationImage(
                              fit: BoxFit.fill,
                              image:  NetworkImage(_card['logo'].toString()),
                            )
                        )
                    ),

                    SizedBox(height: 15.0.h,),
                    Text(_card['isim'],style: TextStyle(fontSize: 30.0.spByWidth,fontWeight: FontWeight.bold),),
                    SizedBox(height: 15.0.h,),
                    StreamBuilder<QuerySnapshot>(
                      stream: FirebaseFirestore.instance
                          .collection("kurumKatilimİstekleri")
                          .doc(_userModel.user.userId)
                          .collection("katilimcilar")
                          .where('kurumid', isEqualTo: _card['userID'])
                          .snapshots(),
                      builder: (BuildContext context,
                          AsyncSnapshot<QuerySnapshot> snapshot) {
                        if (!snapshot.hasData) return Container();
                        return snapshot.data.docs.toString() == "[]" ?
                        MyButton(text: "Başvur", onPressed: ()
                        {
                          _firestoreDBService.kurumKatilmaIstegiButonu(_card, _userModel.user.userId,_userModel.user.foto,_userModel.user.isim+" "+_userModel.user.soyisim,_userModel.user.meslek,"needy");
                        }, textColor: Colors.white, fontSize: 16.0.spByWidth, width: 240.0.w, height: 40.0.h,butonColor: Colors.green,)
                            : snapshot.data.docs[0]['onay'].toString() == "katilmadi" ?
                        MyButton(text: "Başvur", onPressed: ()
                        {
                          _firestoreDBService.kurumKatilmaIstegiButonu(_card, _userModel.user.userId,_userModel.user.foto,_userModel.user.isim+" "+_userModel.user.soyisim,_userModel.user.meslek,"needy");
                        }, textColor: Colors.white, fontSize: 16.0.spByWidth, width: 240.0.w, height: 40.0.h,butonColor: Colors.green,)
                            : snapshot.data.docs[0]['onay'].toString() == "katildi"
                            ? MyButton(text: "Katıldınız", onPressed: (){
                          // yapacak birşey yok
                        }, textColor: Colors.white, fontSize: 16.0.spByWidth, width: 240.0.w, height: 40.0.h,butonColor: Colors.blue,) :
                        MyButton(text: "Onay Aşamasında", onPressed: (){
                          _firestoreDBService.kurumKatilmaIstegiVazgecButonu(_card, _userModel.user.userId);
                        }, textColor: Colors.white, fontSize: 16.0.spByWidth, width: 240.0.w, height: 40.0.h,butonColor: Colors.amberAccent,);


                      },
                    ),

                    SizedBox(height: 20.0.h,),
                    Text(
                      _card['Faaliyetleri'].toString(),
                      overflow: TextOverflow.ellipsis,
                      maxLines: 10,
                      textAlign: TextAlign.center,
                      style: TextStyle(fontSize: 17.0.spByWidth),
                    ),
                    SizedBox(height: 20.0.h,),
                    Divider(),
                    Row(children: <Widget>[
                      Padding(
                        padding:  EdgeInsets.only(left: 10.0.w),
                        child: Text("Kuruluş Tarihi:",style: TextStyle(fontSize: 16.0.spByWidth),),
                      ),
                      Padding(
                        padding:  EdgeInsets.only(left: 25.0.w),
                        child: Container(
                          width: 190.0.w,
                          child: Text(
                            DateFormat('dd-MM-yyyy').format(_card['kurulusTarihi'].toDate()),
                            overflow: TextOverflow.ellipsis,
                            maxLines: 3,
                            style: TextStyle(fontSize: 17.0.spByWidth),
                          ),
                        ),
                      ),
                    ],),
                    Divider(),
                    Row(children: <Widget>[
                      Padding(
                        padding:  EdgeInsets.only(left: 10.0.w),
                        child: Text("Faaliyet alanı:",style: TextStyle(fontSize: 16.0.spByWidth),),
                      ),
                      Padding(
                        padding:  EdgeInsets.only(left: 30.0.w),
                        child: Container(
                          width: 180.0.w,
                          child: Text(
                            _card['faaliyetalani'].toString(),
                            overflow: TextOverflow.ellipsis,
                            maxLines: 3,
                            style: TextStyle(fontSize: 17.0.spByWidth),
                          ),
                        ),
                      ),
                    ],),
                    Divider(),
                    Row(children: <Widget>[
                      Padding(
                        padding:  EdgeInsets.only(left: 10.0.w),
                        child: Text("Email:",style: TextStyle(fontSize: 16.0.spByWidth),),
                      ),
                      Padding(
                        padding:  EdgeInsets.only(left: 85.0.w),
                        child: Container(
                          width: 200.0.w,
                          child: Text(
                            _card['email'].toString(),
                            overflow: TextOverflow.ellipsis,
                            maxLines: 3,
                            style: TextStyle(fontSize: 17.0.spByWidth),
                          ),
                        ),
                      ),
                    ],),


                    Divider(),
                    Row(children: <Widget>[
                      Padding(
                        padding:  EdgeInsets.only(left: 10.0.w),
                        child: Text("Telefon:",style: TextStyle(fontSize: 16.0.spByWidth),),
                      ),
                      Padding(
                        padding:  EdgeInsets.only(left: 70.0.w),
                        child: Container(
                          width: 200.0.w,
                          child: Text(
                            _card['telefon'].toString(),
                            overflow: TextOverflow.ellipsis,
                            maxLines: 1,
                            style: TextStyle(fontSize: 17.0.spByWidth),
                          ),
                        ),
                      ),
                    ],),

                    SizedBox(height: 20.0.h,),
                  ],
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
