import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:yardimfeneri/extantion/size_extension.dart';
import 'package:yardimfeneri/servis/helpful_service.dart';


class YardimEttigiProjeler extends StatefulWidget {

  const YardimEttigiProjeler({Key key,}) : super(key: key);

  @override
  _YardimEttigiProjelerState createState() => _YardimEttigiProjelerState();
}

class _YardimEttigiProjelerState extends State<YardimEttigiProjeler> {
  @override
  Widget build(BuildContext context) {
    final _helpfulService = Provider.of<HelpfulService>(context, listen: true);
    return Scaffold(
      appBar: AppBar(
        backgroundColor:  Colors.white,
        title: Text("Katkıda Bulunduğum Projeler",
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
      body: StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance.collection('helpful').doc(_helpfulService.user.userId).collection("yardimettiklerim").snapshots(),
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshotUye) {
          if (!snapshotUye.hasData) {
            return Center(
              child: CircularProgressIndicator(),
            );
          }
          final int cardLength2 = snapshotUye.data.docs.length;

          return cardLength2 ==0  ? _kullaniciYokUi() :ListView.builder(
            shrinkWrap: true,
            physics: NeverScrollableScrollPhysics(),
            itemCount: cardLength2,
            itemBuilder: (_, int index) {
              final DocumentSnapshot _cardYonetici = snapshotUye.data.docs[index];
              return StreamBuilder<DocumentSnapshot>(
                stream: FirebaseFirestore.instance.collection('charities').doc(_cardYonetici['userid']).snapshots(),
                builder: (BuildContext context, AsyncSnapshot<DocumentSnapshot> snapshot) {
                  if (!snapshot.hasData) {
                    return Center(
                      child: CircularProgressIndicator(),
                    );
                  }
                  final int cardLength = 1;

                  return  ListView.builder(
                    shrinkWrap: true,
                    physics: NeverScrollableScrollPhysics(),
                    itemCount: cardLength,
                    itemBuilder: (_, int index) {
                      final DocumentSnapshot _card = snapshot.data;
                      print("Üye işlemleri _card: " + _card.data().toString());
                      return charityCard(
                          charityName: _card['isim'],
                          imagePath: _card['logo'],
                          campaign: _cardYonetici['kampanya'],
                          donation: _cardYonetici['yardim_miktari'].toString()+" TL bağışlandı!"
                      );

                    },
                  );
                },
              );
            },
          );
        },
      ),

    );
  }
  Widget _kullaniciYokUi() {
    return SingleChildScrollView(
      physics: AlwaysScrollableScrollPhysics(),
      child: Container(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Icon(
                Icons.supervised_user_circle,
                color: Theme.of(context).primaryColor,
                size: 120,
              ),
              Text(
                "Katıldığınız Proje Yok",
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 36),
              )
            ],
          ),
        ),
        height: MediaQuery.of(context).size.height - 150,
      ),
    );
  }

}


Widget charityCard({String charityName, String campaign, String imagePath, String donation}){
  return  Padding(
    padding: const EdgeInsets.all(8.0),
    child: Container(
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              offset: Offset(0,1),
              blurRadius: 2,
              spreadRadius: 3,
              color: Colors.grey,
            ),
          ]
      ),
      child: Row(
        children: [
          Padding(
            padding: const EdgeInsets.all(15.0),
            child: ClipOval(
              child: Image.network(imagePath,
                  height: 100.0.h,
                  width: 100.0.w,
                  fit: BoxFit.fill
              ),
            ),
          ),
          Padding(
            padding:  EdgeInsets.only(left:10.0.w,),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children:  [
                Text(charityName, style: TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                  fontSize: 20.0.spByWidth,
                ),
                ),
                Text(campaign, style: TextStyle(
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
                    padding: EdgeInsets.symmetric(horizontal: 20.0.w, vertical: 8.0.h),
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