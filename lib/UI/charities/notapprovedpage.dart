import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:yardimfeneri/extantion/size_extension.dart';
import 'package:yardimfeneri/servis/charities_service.dart';

class NotApprovedPageCharities extends StatelessWidget {
  const NotApprovedPageCharities({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final _charitiesModel = Provider.of<CharitiesService>(context, listen: true);

    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Center(child: Text("HESAP ONAYLANMADI"),),
          SizedBox(height: 30.0.h,),
          InkWell(
            onTap: (){
              _charitiesModel.signOut();
            },
            child: Container(
              width: 200.0.w,
              height: 50.0.h,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: Colors.blue,
                boxShadow: [
                  BoxShadow(color: Colors.blue, spreadRadius: 3),
                ],
              ),
              child: Center(child: Text("Çıkış",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 20.0.spByWidth,color: Colors.white),)),
            ),
          )
        ],
      ),
    );
  }
}
