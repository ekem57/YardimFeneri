import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:yardimfeneri/COMMON/resimsizcard.dart';
import 'package:yardimfeneri/common/resimsiz_bagis_kart.dart';
import 'package:yardimfeneri/extantion/size_extension.dart';
import 'package:yardimfeneri/servis/charities_service.dart';

class BagisIslemleriCharities extends StatefulWidget {
  const BagisIslemleriCharities({Key key}) : super(key: key);

  @override
  _BagisIslemleriCharitiesState createState() => _BagisIslemleriCharitiesState();
}
TabController _tabController;

class _BagisIslemleriCharitiesState extends State<BagisIslemleriCharities>  with SingleTickerProviderStateMixin{
  @override
  void initState() {
    super.initState();
    _tabController = TabController(vsync: this, length: myTabs.length);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }
  final List<Tab> myTabs = <Tab>[
    Tab(text: 'Kuruma Yapılan Bağışlar'),
    Tab(text: 'Kişilere Yapılan Bağışlar'),
  ];
  @override
  Widget build(BuildContext context) {
    final _charitiesModel = Provider.of<CharitiesService>(context, listen: true);

    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.blue,
          title: Center(
            child: Text("Bağış İşlemleri", style: TextStyle(
                fontSize: 25.0.spByWidth, fontWeight: FontWeight.bold, color: Colors.white),),
          ),
          bottom: TabBar(
            controller: _tabController,
            tabs: myTabs,
          ),
        ),
        body: TabBarView(
          controller: _tabController,
          children: [
            // first tab bar view widget
            FutureBuilder<QuerySnapshot>(
              future: FirebaseFirestore.instance
                  .collection('charities')
                  .doc(_charitiesModel.user.userId)
                  .collection('kuruma_yapilan_bagis')
                  .orderBy('date', descending: true)
                  .get(),
              builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {

                if (!snapshot.hasData){
                  return Center(child: CircularProgressIndicator(),);
                }
                final int cardLength = snapshot.data.docs.length;

                return cardLength == 0 ?
                Container(

                ) :
                ListView.builder(

                    itemCount: cardLength,
                    itemBuilder: (context, index) {
                      final DocumentSnapshot _card = snapshot.data.docs[index];
                      return  ResimsizCard(isim: _card['isim']+" "+_card['soyisim'], bagismiktar: _card['bagis_miktari'].toString(), mesaj: _card['mesaj'].toString(), onPressed: (){});

                    });

              },
            ),


            // second tab bar viiew widget
            FutureBuilder<QuerySnapshot>(
              future: FirebaseFirestore.instance
                  .collection('charities')
                  .doc(_charitiesModel.user.userId)
                  .collection('kisiye_yapilan_bagis')
                  .orderBy('date', descending: true)
                  .get(),
              builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {

                if (!snapshot.hasData){
                  return Center(child: CircularProgressIndicator(),);
                }
                final int cardLength = snapshot.data.docs.length;

                return cardLength == 0 ?
                Container(

                ) :
                ListView.builder(

                    itemCount: cardLength,
                    itemBuilder: (context, index) {
                      final DocumentSnapshot _card = snapshot.data.docs[index];
                      return ResimsizBagisCard(bagisyapan: _card['isim']+" "+_card['soyisim'],bagisyapilankampanya: "kampanya", bagismiktar: _card['bagis_miktari'].toString(), mesaj: _card['mesaj'].toString(), onPressed: (){});

                      return  ResimsizCard(isim: _card['isim']+" "+_card['soyisim'], bagismiktar: _card['bagis_miktari'].toString(), mesaj: _card['mesaj'].toString(), onPressed: (){});

                    });

              },
            ),



          ],
        ),
      ),
    );
  }
}
