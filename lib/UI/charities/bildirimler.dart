import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:yardimfeneri/extantion/size_extension.dart';
import 'package:yardimfeneri/servis/charities_service.dart';


class BildirimlerCharities extends StatefulWidget {
  const BildirimlerCharities({Key key}) : super(key: key);

  @override
  _BildirimlerCharitiesState createState() => _BildirimlerCharitiesState();
}

class _BildirimlerCharitiesState extends State<BildirimlerCharities> {
  @override
  Widget build(BuildContext context) {
    final _charitiesModel = Provider.of<CharitiesService>(context, listen: true);

    return Scaffold(
      appBar: AppBar(
        brightness: Brightness.light,
        backgroundColor: Colors.transparent,
        elevation: 0.0,
        iconTheme: new IconThemeData(color: Colors.black),
        title: Text("Bildirimler", style: TextStyle(
            fontSize: 30.0.spByWidth, fontWeight: FontWeight.bold, color: Colors.black),),
        automaticallyImplyLeading: false,
        actions: <Widget>[
          Padding(
            padding:  EdgeInsets.only(right: 20.0.w),
            child: IconButton(icon: Icon(Icons.exit_to_app,size: 30.0.h,), onPressed: (){
              _charitiesModel.signOut();
            }),
          )

        ],
      ),
      body: ListView(
        children: [
          FutureBuilder<QuerySnapshot>(
            future: FirebaseFirestore.instance
                .collection('charities')
                .doc(_charitiesModel.user.userId)
                .collection('bildirimler')
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
                  physics: NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  itemCount: cardLength,
                  itemBuilder: (context, index) {
                    final DocumentSnapshot _cardFuture = snapshot.data.docs[index];
                    return InkWell(
                      onTap: (){
                        _cardFuture["etid"] != null ?  Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (c) => BildirimlerCharities(),
                          ),
                        ) : null;
                      //  _card!.reference.update({'okundu':true});
                      },
                      child: Padding(
                        padding: EdgeInsets.symmetric(vertical: 12.0.h, horizontal: 34.0.w),
                        child: Container(
                          width: 291.6666666666667.w,
                          height: 72.0.h,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.all(Radius.circular(11.70.h)),
                            boxShadow: [
                              BoxShadow(
                                  color: const Color(0x36000000), offset: Offset(0, 2), blurRadius: 22.70, spreadRadius: 0)
                            ],
                            color: Colors.white,
                          ),
                          child: Center(
                            child: ListTile(
                              title: Text(_cardFuture["icerik"],
                                  maxLines: 5,
                                  style: TextStyle(

                                      color: const Color(0xff343633),
                                      fontWeight: _cardFuture["okundu"] ? FontWeight.w400 : FontWeight.w600,
                                      fontFamily: "OpenSans",
                                      fontStyle: FontStyle.normal,
                                      fontSize: 14.0.spByWidth),
                                  textAlign: TextAlign.start),
                              leading: Padding(
                                padding:  EdgeInsets.only(top: 5.0.h),
                                child: Container(
                                  width: 15.0.w,
                                  height: 15.0.h,
                                  decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    color: _cardFuture["okundu"] ? Colors.green : Colors.blue,
                                  ),
                                ),
                              ),
                              trailing: IconButton(
                                onPressed: () {
                                  _cardFuture.reference.delete();
                                  setState(() {

                                  });
                                },
                                icon: Icon(Icons.delete, color: Theme.of(context).primaryColor,size: 30,),
                              ),
                            ),
                          ),
                        ),
                      ),
                    );
                  });

            },
          )

        ],
      ),
    );
  }
}
