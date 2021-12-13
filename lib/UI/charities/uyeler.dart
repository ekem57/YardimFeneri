import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:provider/provider.dart';
import 'package:yardimfeneri/COMMON/resimlicard.dart';
import 'package:yardimfeneri/extantion/size_extension.dart';
import 'package:yardimfeneri/servis/charities_service.dart';

class UyelerCharities extends StatefulWidget {
  const UyelerCharities({Key key}) : super(key: key);

  @override
  _UyelerCharitiesState createState() => _UyelerCharitiesState();
}

class _UyelerCharitiesState extends State<UyelerCharities> {
  @override
  Widget build(BuildContext context) {
    final _charitiesModel = Provider.of<CharitiesService>(context, listen: true);
    return Scaffold(
      body: ListView(
          children: [
            SizedBox(height: 12.0.h,),
            Center(
              child: Text("Üyeler", style: TextStyle(
                  fontSize: 30.0.spByWidth, fontWeight: FontWeight.bold, color: Colors.black),),
            ),
            SizedBox(height: 20.0.h,),
            StreamBuilder<QuerySnapshot>(
              stream: FirebaseFirestore.instance.collection('charities').doc(_charitiesModel.user.userId).collection("uyeler").snapshots(),
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
                    final DocumentSnapshot _cardYonetici = snapshotUye.data.docs[index];
                    return StreamBuilder<DocumentSnapshot>(
                      stream: uyesec(_cardYonetici),
                      builder: (BuildContext context, AsyncSnapshot<DocumentSnapshot> snapshot) {
                        if (!snapshot.hasData) {
                          return Center(
                            child: CircularProgressIndicator(),
                          );
                        }
                        final int cardLength = 1;

                        return ListView.builder(
                          shrinkWrap: true,
                          physics: NeverScrollableScrollPhysics(),
                          itemCount: cardLength,
                          itemBuilder: (_, int index) {
                            final DocumentSnapshot _card = snapshot.data;
                            print("Üye işlemleri _card: " + _card.data().toString());
                            return _card.data() != null ?  Slidable(
                              actionPane: SlidableDrawerActionPane(),
                              actionExtentRatio: 0.45,
                              child:ResimliCard(
                                  textSubtitle: null,
                                  textTitle: _card['isim'].toString(),
                                  onPressed: () {},
                                  fontSize: 12.0.spByWidth,
                                  img: _card['foto'].toString(),
                                  tarih: null),
                              secondaryActions: <Widget>[

                                Container(
                                  height: 70,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.all(Radius.circular(20.70)),

                                  ),
                                  child: IconSlideAction(
                                      caption: 'Sil',
                                      color: Colors.red,
                                      icon: Icons.delete,
                                      onTap: () async {
                                        setState(() {

                                        });
                                      }
                                  ),
                                ),
                              ],
                            ) : Container();

                          },
                        );
                      },
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
