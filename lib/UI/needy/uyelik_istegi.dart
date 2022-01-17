import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:yardimfeneri/UI/needy/topluluk_tanitim_needy.dart';
import 'package:yardimfeneri/common/fullresim.dart';
import 'package:yardimfeneri/extantion/size_extension.dart';

class UyelikBasvurusuNeedy extends StatefulWidget {
  const UyelikBasvurusuNeedy({Key key}) : super(key: key);

  @override
  _UyelikBasvurusuNeedyState createState() => _UyelikBasvurusuNeedyState();
}

class _UyelikBasvurusuNeedyState extends State<UyelikBasvurusuNeedy> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        iconTheme: IconThemeData(color: Colors.black),
        title: Text("Kuruluşlar",style: TextStyle(color: Colors.black,fontSize: 27.0.spByWidth,fontWeight: FontWeight.bold),),
      ),
      body:  StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance
            .collection('charities').snapshots(),
        builder: (BuildContext context,
            AsyncSnapshot<QuerySnapshot> snapshot) {
          if (!snapshot.hasData) return const Text('Connecting...');
          final int cardLength = snapshot.data.docs.length;
          return new ListView.builder(

            itemCount:cardLength,
            itemBuilder: (_, int index) {
              final DocumentSnapshot _card = snapshot.data.docs[index];
              return Padding(
                padding: const EdgeInsets.all(5.0),
                child: Card(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                  elevation: 7,
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: ListTile(
                      onTap: (){
                        Navigator.push(context, MaterialPageRoute(builder: (context) =>ToplulukTanitimNeedy(kurumid: _card['userID'].toString(),)),);
                      },
                      title: Text(_card['isim'].toString(),style: TextStyle(fontWeight: FontWeight.bold,fontSize: 18.0.spByWidth),),
                      leading: GestureDetector(
                        onTap: () {
                          Navigator.push(context, MaterialPageRoute(builder: (context) =>ImageViewerPage(assetName: _card['logo'].toString(),)),);
                        },
                        child: Container(
                          width: 70.0.h,
                          height: 70.0.h,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            image: DecorationImage(
                              fit: BoxFit.fill,
                              image: NetworkImage(
                                  _card['logo']),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              );

            },
          );
        },
      ),
    );
  }
}
