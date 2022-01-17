import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:date_format/date_format.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:yardimfeneri/ChattApp/chat_view_model_Charities.dart';
import 'package:yardimfeneri/ChattApp/sohbetPageCharities.dart';
import 'package:yardimfeneri/common/myButton.dart';
import 'package:yardimfeneri/extantion/size_extension.dart';
import 'package:yardimfeneri/firebasedb/database/firebasedbcharities.dart';
import 'package:yardimfeneri/locator.dart';
import 'package:yardimfeneri/model/needy_model.dart';
import 'package:yardimfeneri/servis/charities_service.dart';
import 'package:yardimfeneri/servis/helpful_service.dart';

class KullaniciProfilPage extends StatefulWidget {
  final DocumentSnapshot user;
  const KullaniciProfilPage({Key key,@required this.user}) : super(key: key);

  @override
  _KullaniciProfilPageState createState() => _KullaniciProfilPageState();
}

class _KullaniciProfilPageState extends State<KullaniciProfilPage> {
  @override
  Widget build(BuildContext context) {
    CharitiesService _kurumModel = Provider.of<CharitiesService>(context);
    FirestoreDBServiceCharities _firestoreDBService = locator<FirestoreDBServiceCharities>();

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        iconTheme: IconThemeData(color: Colors.black),
      ),
      body:  ListView(
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
                          image:  NetworkImage(widget.user['foto'].toString()),
                        )
                    )
                ),

                SizedBox(height: 15.0.h,),
                Text(widget.user['isim']+" "+widget.user['soyisim'],style: TextStyle(fontSize: 30.0.spByWidth,fontWeight: FontWeight.bold),),
                SizedBox(height: 15.0.h,),

                SizedBox(height: 20.0.h,),
                Text(
                  widget.user['hakkimda'].toString(),
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
                    child: Text("İl:",style: TextStyle(fontSize: 16.0.spByWidth),),
                  ),
                  Padding(
                    padding:  EdgeInsets.only(left: 109.0.w),
                    child: Container(
                      width: 200.0.w,
                      child: Text(
                        widget.user['il'].toString(),
                        overflow: TextOverflow.ellipsis,
                        maxLines: 1,
                        style: TextStyle(fontSize: 17.0.spByWidth),
                      ),
                    ),
                  ),
                ],),
                Divider(),
                Row(children: <Widget>[
                  Padding(
                    padding:  EdgeInsets.only(left: 10.0.w),
                    child: Text("Adres:",style: TextStyle(fontSize: 16.0.spByWidth),),
                  ),
                  Padding(
                    padding:  EdgeInsets.only(left: 73.0.w),
                    child: Container(
                      width: 200.0.w,
                      child: Text(
                        widget.user['adres'].toString(),
                        overflow: TextOverflow.ellipsis,
                        maxLines: 1,
                        style: TextStyle(fontSize: 17.0.spByWidth),
                      ),
                    ),
                  ),
                ],),
                Divider(),
                Row(children: <Widget>[
                  Padding(
                    padding:  EdgeInsets.only(left: 10.0.w),
                    child: Text("Doğum Tarihi:",style: TextStyle(fontSize: 16.0.spByWidth),),
                  ),
                  Padding(
                    padding:  EdgeInsets.only(left: 18.0.w),
                    child: Container(
                      width: 190.0.w,
                      child: Text(
                        DateFormat('dd-MM-yyyy').format(widget.user['dogumTarihi'].toDate()),
                        overflow: TextOverflow.ellipsis,
                        maxLines: 3,
                        style: TextStyle(fontSize: 17.0.spByWidth),
                      ),
                    ),
                  ),
                ],),
                Divider(),

                Divider(),
                Row(children: <Widget>[
                  Padding(
                    padding:  EdgeInsets.only(left: 10.0.w),
                    child: Text("Email:",style: TextStyle(fontSize: 16.0.spByWidth),),
                  ),
                  Padding(
                    padding:  EdgeInsets.only(left: 75.0.w),
                    child: Container(
                      width: 200.0.w,
                      child: Text(
                        widget.user['email'].toString(),
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
                    padding:  EdgeInsets.only(left: 60.0.w),
                    child: Container(
                      width: 200.0.w,
                      child: Text(
                        widget.user['telefon'].toString(),
                        overflow: TextOverflow.ellipsis,
                        maxLines: 1,
                        style: TextStyle(fontSize: 17.0.spByWidth),
                      ),
                    ),
                  ),
                ],),

                SizedBox(height: 20.0.h,),
                MyButton(text: "Sohbet",
                  onPressed: () async {
                   NeedyModel _oankiuser = NeedyModel.fromMap(widget.user.data());
                    Navigator.of(context, rootNavigator: true).push(
                      MaterialPageRoute(
                        builder: (context) => ChangeNotifierProvider(
                          create: (context) => ChatViewModelCharities(currentUser: _kurumModel.user, sohbetEdilenUser:_oankiuser ),
                          child: SohbetPageCharities(fotourl: _oankiuser.foto,userad: _oankiuser.isim,soyad: _oankiuser.soyisim,userid: _oankiuser.userId,),
                        ),
                      ),
                    );
                  }, textColor: Colors.white, fontSize: 18.0.spByWidth, width: 250.0.w, height: 50.0.h,butonColor: Colors.green,),
                SizedBox(height: 20.0.h,),

              ],
            ),
          ),
        ],
      ),
    );
  }
}
