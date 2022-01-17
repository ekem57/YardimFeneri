import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:yardimfeneri/COMMON/resimlicard.dart';
import 'package:yardimfeneri/UI/charities/uyekabul.dart';
import 'package:yardimfeneri/common/fullresim.dart';
import 'package:yardimfeneri/common/kullanici_profil.dart';
import 'package:yardimfeneri/extantion/size_extension.dart';
import 'package:yardimfeneri/servis/charities_service.dart';

class NeedyHome extends StatefulWidget {
  const NeedyHome({Key key}) : super(key: key);

  @override
  _NeedyHomeState createState() => _NeedyHomeState();
}

class _NeedyHomeState extends State<NeedyHome> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        children: [
          SizedBox(height: 12.0.h,),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Text("Başvuran İhtiyaç Sahipleri", style: TextStyle(fontSize: 20.0.spByWidth, fontWeight: FontWeight.bold, color: Colors.black),),

            ],
          ),
          SizedBox(height: 20.0.h,),
          StreamBuilder<QuerySnapshot>(
            stream: FirebaseFirestore.instance.collection('needy').where("hesapOnay",isEqualTo: false).snapshots(),
            builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshotUye) {
              if (!snapshotUye.hasData) {
                return Center(
                  child: CircularProgressIndicator(),
                );
              }
              final int cardLength2 = snapshotUye.data.docs.length;

              return ListView.builder(
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                itemCount: cardLength2,
                itemBuilder: (_, int index) {
                  final DocumentSnapshot _card = snapshotUye.data.docs[index];
                  return    Padding(
                    padding: const EdgeInsets.only(left: 10.0,right: 10.0,top: 30.0,bottom: 30.0),
                    child: Card(
                      elevation: 14.0,
                      child: Column(
                        children: <Widget>[
                          Container(
                              width: 80.0.h,
                              height: 80.0.h,
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
                                    image:  NetworkImage(_card['foto'].toString()),
                                  )
                              )
                          ),

                          SizedBox(height: 15.0.h,),
                          Text(_card['isim']+_card['soyisim'].toString(),style: TextStyle(fontSize: 16.0.spByWidth,fontWeight: FontWeight.bold),textAlign: TextAlign.center,),
                          SizedBox(height: 15.0.h,),

                          SizedBox(height: 20.0.h,),
                          Text(
                            _card['hakkimda'].toString(),
                            overflow: TextOverflow.ellipsis,
                            maxLines: 10,
                            textAlign: TextAlign.center,
                            style: TextStyle(fontSize: 15.0.spByWidth),
                          ),
                          SizedBox(height: 20.0.h,),
                          Divider(),

                          Row(children: <Widget>[
                            Padding(
                              padding:  EdgeInsets.only(left: 10.0.w),
                              child: Text("Adres:",style: TextStyle(fontSize: 16.0.spByWidth),),
                            ),
                            Padding(
                              padding:  EdgeInsets.only(left: 70.0.w),
                              child: Container(
                                width: 200.0.w,
                                child: Text(
                                  _card['adres'].toString(),
                                  overflow: TextOverflow.ellipsis,
                                  maxLines: 10,
                                  style: TextStyle(fontSize: 12.0.spByWidth),
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
                              padding:  EdgeInsets.only(left: 10.0.w),
                              child: Container(
                                width: 190.0.w,
                                child: Text(
                                  DateFormat('dd-MM-yyyy').format(_card['dogumTarihi'].toDate()),
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
                                  _card['telefon'].toString(),
                                  overflow: TextOverflow.ellipsis,
                                  maxLines: 1,
                                  style: TextStyle(fontSize: 17.0.spByWidth),
                                ),
                              ),
                            ),
                          ],),

                          SizedBox(height: 20.0.h,),

                          StreamBuilder<QuerySnapshot>(
                            stream: FirebaseFirestore.instance.collection('insanlar_demo').where("isim",isEqualTo: _card['isim']+" "+_card['soyisim'].toString()).snapshots(),
                            builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
                              if (!snapshotUye.hasData) {
                                return Center(
                                  child: CircularProgressIndicator(),
                                );
                              }
                              final int cardLength2 = snapshot.data.docs.length;

                              return  ListView.builder(
                                shrinkWrap: true,
                                physics: NeverScrollableScrollPhysics(),
                                itemCount: cardLength2,
                                itemBuilder: (_, int index) {
                                  final DocumentSnapshot _card = snapshot.data.docs[index];
                                  return    Column(
                                    children: [
                                      Row(children: <Widget>[
                                        Padding(
                                          padding:  EdgeInsets.only(left: 10.0.w),
                                          child: Text("Ev varmı:",style: TextStyle(fontSize: 16.0.spByWidth),),
                                        ),
                                        Padding(
                                          padding:  EdgeInsets.only(left: 52.0.w),
                                          child: Container(
                                            width: 100.0.w,
                                            child: Text(
                                              _card['ev'] ? "Evet" : "Hayır",
                                              overflow: TextOverflow.ellipsis,
                                              maxLines: 1,
                                              style: TextStyle(fontSize: 17.0.spByWidth),
                                            ),
                                          ),
                                        ),
                                      ],),

                                      Row(children: <Widget>[
                                        Padding(
                                          padding:  EdgeInsets.only(left: 10.0.w),
                                          child: Text("Araba Varmı:",style: TextStyle(fontSize: 16.0.spByWidth),),
                                        ),
                                        Padding(
                                          padding:  EdgeInsets.only(left: 25.0.w),
                                          child: Container(
                                            width: 100.0.w,
                                            child: Text(
                                              _card['araba'] ? "Evet" : "Hayır",
                                              overflow: TextOverflow.ellipsis,
                                              maxLines: 1,
                                              style: TextStyle(fontSize: 17.0.spByWidth),
                                            ),
                                          ),
                                        ),
                                      ],),

                                      Row(children: <Widget>[
                                        Padding(
                                          padding:  EdgeInsets.only(left: 10.0.w),
                                          child: Text("Maas Varmı:",style: TextStyle(fontSize: 16.0.spByWidth),),
                                        ),
                                        Padding(
                                          padding:  EdgeInsets.only(left: 30.0.w),
                                          child: Container(
                                            width: 100.0.w,
                                            child: Text(
                                              _card['maas'] ? "Evet" : "Hayır",
                                              overflow: TextOverflow.ellipsis,
                                              maxLines: 1,
                                              style: TextStyle(fontSize: 17.0.spByWidth),
                                            ),
                                          ),
                                        ),
                                      ],),
                                    ],
                                  );
                                },
                              );


                            },
                          ),

                          SizedBox(height: 30.0.h,),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              Container(
                                width: 120.0.w,
                                height: 27.0.h,
                                child: ElevatedButton(
                                  onPressed: (){
                                    _card.reference.update({'hesapOnay':true});
                                  },
                                  child: Text("Kabul Et"),
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
                                    _card.reference.delete();
                                  },
                                  child: Text("Reddet"),
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
                  );
                },
              );
            },
          ),
        ],
      ),
    );
  }

  Stream uyesec(DocumentSnapshot cardYonetici) {

    if(cardYonetici['uyetipi']=="charities")
    {
      return FirebaseFirestore.instance.collection('charities').doc(cardYonetici['uyeid']).snapshots();
    }
    else if(cardYonetici['uyetipi']=="needy")
    {
      return FirebaseFirestore.instance.collection('needy').doc(cardYonetici['uyeid']).snapshots();
    }
    else{
      return FirebaseFirestore.instance.collection('helpful').doc(cardYonetici['uyeid']).snapshots();
    }

  }
}
