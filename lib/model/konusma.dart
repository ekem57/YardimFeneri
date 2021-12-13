import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';

class Konusma {
  final String konusma_sahibi;
  final String kimle_konusuyor;
  bool goruldu;
  Timestamp olusturulma_tarihi;
  String son_yollanan_mesaj;
  Timestamp gorulme_tarihi;
  String konusulanUserName;
  String konusulanUserProfilURL;
  Timestamp sonOkunmaZamani;
  String aradakiFark;
  String name;

  Konusma(
      {this.konusma_sahibi,
        this.kimle_konusuyor,
        this.goruldu,
        this.name,
        this.olusturulma_tarihi,
        this.son_yollanan_mesaj,
        this.gorulme_tarihi});

  Map<String, dynamic> toJson() {
    return {
      'konusma_sahibi': konusma_sahibi,
      'kimle_konusuyor': kimle_konusuyor,
      'konusma_goruldu': goruldu,
      'olusturulma_tarihi': olusturulma_tarihi,
      'son_yollanan_mesaj': son_yollanan_mesaj,
      'gorulme_tarihi': gorulme_tarihi,
    };
  }

  Konusma.fromMap(Map<String, dynamic> map)
      : konusma_sahibi = map['konusma_sahibi'],
        kimle_konusuyor = map['kimle_konusuyor'],
        goruldu = map['konusma_goruldu'],
        olusturulma_tarihi = map['olusturulma_tarihi'],
        son_yollanan_mesaj = map['son_yollanan_mesaj'],
  // gorulme_tarihi = map['gorulme_tarihi'],
        sonOkunmaZamani = map['olusturulma_tarihi'];

  @override
  String toString() {
    var map = toJson();
    return jsonEncode(map,toEncodable: (obj){
      if(obj is Timestamp){
        return DateTime.fromMillisecondsSinceEpoch(obj.millisecondsSinceEpoch).toIso8601String();
      }else{
        return obj;
      }
    });
  }
}
