import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:yardimfeneri/extantion/size_extension.dart';
import 'package:yardimfeneri/servis/helpful_service.dart';


class YardimEttigiInsanlar extends StatefulWidget {
  const YardimEttigiInsanlar({Key key}) : super(key: key);

  @override
  _YardimEttigiInsanlarState createState() => _YardimEttigiInsanlarState();
}

class _YardimEttigiInsanlarState extends State<YardimEttigiInsanlar> {
  @override
  Widget build(BuildContext context) {
    final _helpfulService = Provider.of<HelpfulService>(context, listen: true);
    return Scaffold(
      appBar: AppBar(
        backgroundColor:  Colors.white,
        title: Text("Yardım Ettiğim İnsanlar",
          style: TextStyle(
              color: Colors.black,
              fontWeight: FontWeight.w700,
              fontFamily: "OpenSans",
              fontStyle: FontStyle.normal,
              fontSize: 21.7.spByWidth),
        ),

        elevation: 0.0,
        brightness: Brightness.light,
        automaticallyImplyLeading: false,
        // status bar brightness

      ),
      body: Padding(
        padding:  EdgeInsets.all(15.0.w),
        child: Center(
          child: ListView(
            children: [
              StreamBuilder<QuerySnapshot>(
                stream:
                FirebaseFirestore.instance.collection("helpful").doc(_helpfulService.user.userId).collection("yardimettiklerim").snapshots(),
                builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
                  if (!snapshot.hasData) {
                    return Center(
                      child: CircularProgressIndicator(),
                    );
                  }

                  final int cardLength = snapshot.data.docs.length;

                  return ListView.builder(
                    padding: EdgeInsets.all(0),
                    shrinkWrap: true,
                    physics: NeverScrollableScrollPhysics(),
                    itemCount: cardLength,
                    itemBuilder: (_, int index) {
                      final DocumentSnapshot _cardYonetici = snapshot.data.docs[index];
                      return StreamBuilder<DocumentSnapshot>(
                        stream: FirebaseFirestore.instance.collection("needy").doc(_cardYonetici['userid']).snapshots(),
                        builder: (BuildContext context, AsyncSnapshot<DocumentSnapshot> snapshot) {
                          if (!snapshot.hasData) {
                            return Center(
                              child: CircularProgressIndicator(),
                            );
                          }


                          return ListView.builder(
                            padding: EdgeInsets.all(0),
                            shrinkWrap: true,
                            physics: NeverScrollableScrollPhysics(),
                            itemCount: 1,
                            itemBuilder: (_, int index) {
                              final DocumentSnapshot _card = snapshot.data;

                              return needyCard(
                                imagePath: _card['foto'],
                                username: _card['isim']+" "+_card['soyisim'],
                                userCity: _card['il'],
                                donation: _cardYonetici['yardim_miktari'].toString() +" TL bağışlandı!",
                              );
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
        ),
      ),
    );
  }
}

Widget needyCard({String username, String userCity, String donation, String imagePath}){
  return  Padding(
    padding: const EdgeInsets.all(8.0),
    child: Container(
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              offset: Offset(1,1),
              blurRadius: 2,
              spreadRadius: 3,
              color: Colors.grey,
            ),
          ]
      ),
      child: Row(
        children: [
          Padding(
            padding:  EdgeInsets.all(15.0.w),
            child: ClipOval(
              child: Image.network(imagePath,
                  height: 100.0.h,
                  width: 100.0.w,
                  fit: BoxFit.cover
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left:10.0,),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children:  [
                Text(username, style: TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                  fontSize: 20.0.spByWidth,
                ),
                ),
                Text(userCity, style: TextStyle(
                  color: Colors.black,
                  fontSize: 15.0.spByWidth,
                ),
                  textAlign: TextAlign.left,
                ),
                SizedBox(height: 10.0.h,),
                ElevatedButton(
                  onPressed: (){},
                  style: ElevatedButton.styleFrom(
                    shape: StadiumBorder(),
                    onPrimary: Colors.white,
                    padding: EdgeInsets.symmetric(horizontal: 10.0.w, vertical: 8.0.h),
                  ),
                  child: Text(donation, style: TextStyle(
                    fontSize: 15.0.spByWidth,
                    fontWeight: FontWeight.bold,
                  ),),

                ),

              ],
            ),
          ),
        ],
      ),
    ),
  );
}