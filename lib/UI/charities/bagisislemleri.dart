import 'package:flutter/material.dart';
import 'package:yardimfeneri/COMMON/resimsizcard.dart';
import 'package:yardimfeneri/extantion/size_extension.dart';

class BagisIslemleriCharities extends StatefulWidget {
  const BagisIslemleriCharities({Key? key}) : super(key: key);

  @override
  _BagisIslemleriCharitiesState createState() => _BagisIslemleriCharitiesState();
}

class _BagisIslemleriCharitiesState extends State<BagisIslemleriCharities> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        children: [
          SizedBox(height: 12.0.h,),
          Center(
            child: Text("Bağış İşlemleri", style: TextStyle(
                fontSize: 25.0.spByWidth, fontWeight: FontWeight.bold, color: Colors.black),),
          ),
          SizedBox(height: 20.0.h,),

         ResimsizCard(isim: "Emre Ekşisu", bagismiktar: "120", mesaj: "mesaj", onPressed: (){}),
         ResimsizCard(isim: "Emre Ekşisu", bagismiktar: "120", mesaj: "Türk lirası, Türkiye Cumhuriyeti ve Kuzey Kıbrıs Türk Cumhuriyeti'nde resmî olarak, Suriye Geçici Hükûmetinin kontrol ettiği bölgelerde ise gayriresmî olarak kullanılan para birimidir. Alt birimi kuruş olan Türk lirasının basma ve yönetme faaliyetleri Türkiye Cumhuriyet Merkez Bankası tarafından sürdürülür.", onPressed: (){}),
        SizedBox(height: 200,),
        ],
      ),
    );
  }
}
