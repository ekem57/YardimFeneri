import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:date_format/date_format.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:yardimfeneri/COMMON/resimsizcard.dart';
import 'package:yardimfeneri/UI/charities/bildirimler.dart';
import 'package:yardimfeneri/UI/charities/homepage.dart';
import 'package:yardimfeneri/common/fullresim.dart';
import 'package:yardimfeneri/common/myButton.dart';
import 'package:yardimfeneri/common/resimsiz_bagis_kart.dart';
import 'package:yardimfeneri/extantion/size_extension.dart';
import 'package:yardimfeneri/servis/charities_service.dart';

class Kampanyalarim extends StatefulWidget {
  const Kampanyalarim({Key key}) : super(key: key);

  @override
  _KampanyalarimState createState() => _KampanyalarimState();
}
TabController _tabController;

class _KampanyalarimState extends State<Kampanyalarim>  with SingleTickerProviderStateMixin{
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
    Tab(text: 'Kurum Kampanyaları'),
    Tab(text: 'Kişilere Desteklerim'),
  ];
  @override
  Widget build(BuildContext context) {
    final _charitiesModel = Provider.of<CharitiesService>(context, listen: true);

    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          title: Center(
            child: Text("Kampanyalarim", style: TextStyle(
                fontSize: 25.0.spByWidth, fontWeight: FontWeight.bold, color: Colors.white),),
          ),
          backgroundColor: Colors.blue,
          bottom: TabBar(
            controller: _tabController,
            tabs: myTabs,
          ),
          actions: [
          IconButton(icon: Icon(Icons.notifications_active,size: 30,),onPressed: (){
            Navigator.push(context, MaterialPageRoute(builder: (context) =>BildirimlerCharities()),);
          },),

          IconButton(icon: Icon(Icons.exit_to_app,size: 30.0.h,), onPressed: (){_charitiesModel.signOut();}),

      ],
        ),
        body: TabBarView(
          controller: _tabController,
          children: [
            // first tab bar view widget
            StreamBuilder<QuerySnapshot>(
              stream: FirebaseFirestore.instance
                  .collection('charities')
                  .doc(_charitiesModel.user.userId)
                  .collection('yardim_kampanyalarim')
                  .orderBy('date', descending: true)
                  .snapshots(),
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
                      DateTime dateTimeCreatedAt =
                      DateTime.parse(_card['date'].toDate().toString());
                      DateTime dateTimeNow = DateTime.now();
                      final differenceInDays =
                          dateTimeNow.difference(dateTimeCreatedAt).inDays;
                      final differenceInHours =
                          dateTimeNow.difference(dateTimeCreatedAt).inHours;
                      final differenceInMinut =
                          dateTimeNow.difference(dateTimeCreatedAt).inMinutes;
                      return  Column(
                        children: [
                          Row(
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
                                            Navigator.push(context, MaterialPageRoute(builder: (context) =>ImageViewerPage(assetName: _charitiesModel.user.logo)),);

                                          },
                                          child: Container(
                                            width: 50.0.h,
                                            height: 50.0.h,
                                            decoration: BoxDecoration(
                                              shape: BoxShape.circle,
                                              image: DecorationImage(
                                                fit: BoxFit.fill,
                                                image: NetworkImage(
                                                    _charitiesModel.user.logo),
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
                                                  _charitiesModel.user.isim,
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
                          MyButton(text: _card['tamamlandi'] ? "Kampanyayı Tamamla" : "Kampanyayı Yeniden Aç" , onPressed: ()
                          {
                            if(_card['tamamlandi'])
                            {
                              FirebaseFirestore.instance.collection("anasayfa").doc(_card.reference.id).update({'tamamlandi': false});
                              _card.reference.update({'tamamlandi': false});
                            }else
                              {
                                FirebaseFirestore.instance.collection("anasayfa").doc(_card.reference.id).update({'tamamlandi': true});
                                _card.reference.update({'tamamlandi': true});
                              }
                            print("card id: "+_card.reference.id);
                          }, textColor: Colors.white, fontSize: 16.0.spByWidth, width: 280.0.w, height: 40.0.h,butonColor: Colors.blue,),
                          SizedBox(height: 20.0.h,),
                          MyButton(text: "Kampanyayı Sil", onPressed: ()
                          {
                            FirebaseFirestore.instance.collection("anasayfa").doc(_card.reference.id).delete();
                            _card.reference.delete();
                          }, textColor: Colors.white, fontSize: 16.0.spByWidth, width: 280.0.w, height: 40.0.h,butonColor: Colors.red,),

                          SizedBox(height: 10.0.h,),
                          Divider(),
                        ],
                      );

                    });

              },
            ),


            // second tab bar viiew widget
            StreamBuilder<QuerySnapshot>(
              stream: FirebaseFirestore.instance
                  .collection('charities')
                  .doc(_charitiesModel.user.userId)
                  .collection('yardim_destekleri')
                  .orderBy('date', descending: true)
                  .snapshots(),
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
                      DateTime dateTimeCreatedAt =
                      DateTime.parse(_card['date'].toDate().toString());
                      DateTime dateTimeNow = DateTime.now();
                      final differenceInDays =
                          dateTimeNow.difference(dateTimeCreatedAt).inDays;
                      final differenceInHours =
                          dateTimeNow.difference(dateTimeCreatedAt).inHours;
                      final differenceInMinut =
                          dateTimeNow.difference(dateTimeCreatedAt).inMinutes;
                      return  Column(
                        children: [
                          Row(
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
                                            Navigator.push(context, MaterialPageRoute(builder: (context) =>ImageViewerPage(assetName: _charitiesModel.user.logo)),);

                                          },
                                          child: Container(
                                            width: 50.0.h,
                                            height: 50.0.h,
                                            decoration: BoxDecoration(
                                              shape: BoxShape.circle,
                                              image: DecorationImage(
                                                fit: BoxFit.fill,
                                                image: NetworkImage(
                                                    _charitiesModel.user.logo),
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
                                                  _charitiesModel.user.isim,
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

                          MyButton(text: _card['tamamlandi'] ? "Desteği Tamamla" : "Desteği Yeniden Aç" , onPressed: ()
                          {
                            if(_card['tamamlandi'])
                            {
                              FirebaseFirestore.instance.collection("anasayfa").doc(_card.reference.id).update({'tamamlandi': false});
                              _card.reference.update({'tamamlandi': false});
                            }else
                            {
                              FirebaseFirestore.instance.collection("anasayfa").doc(_card.reference.id).update({'tamamlandi': true});
                              _card.reference.update({'tamamlandi': true});
                            }
                            print("card id: "+_card.reference.id);
                          }, textColor: Colors.white, fontSize: 16.0.spByWidth, width: 280.0.w, height: 40.0.h,butonColor: Colors.blue,),
                          SizedBox(height: 20.0.h,),
                          MyButton(text: "Desteği Sil", onPressed: ()
                          {
                            FirebaseFirestore.instance.collection("anasayfa").doc(_card.reference.id).delete();
                            _card.reference.delete();
                          }, textColor: Colors.white, fontSize: 16.0.spByWidth, width: 280.0.w, height: 40.0.h,butonColor: Colors.red,),




                          SizedBox(height: 10.0.h,),
                          Divider(),
                        ],
                      );

                    });

              },
            ),



          ],
        ),
      ),
    );
  }
}
