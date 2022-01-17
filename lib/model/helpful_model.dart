
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class HelpfulModel extends ChangeNotifier {
  final String email;
  final String password;
  String userId;
  String telefon;
  String isim;
  String soyisim;
  String hakkimda;
  String adres;
  String il;
  String foto;
  DateTime dogumTarihi;

  HelpfulModel({this.userId,this.email, this.password,this.isim,this.soyisim,this.adres,this.il,this.foto,this.dogumTarihi,this.telefon});

  Map<String, dynamic> toMap() {
    return {
      'email': email,
      'userID': userId,
      'telefon': telefon ?? '00000000000',
      'isim': isim,
      'hakkimda': "",
      'soyisim': soyisim,
      'il': il,
      'adres': adres,
      'foto': 'https://firebasestorage.googleapis.com/v0/b/yardimfeneri.appspot.com/o/logo.png?alt=media&token=f8132b8b-f300-41e8-bc80-9696bd2e2e68',
      'dogumTarihi': dogumTarihi,
    };
  }

  HelpfulModel.fromMap(Map<String, dynamic> map)
      : userId = map['userID'],
        telefon = map['telefon'],
        email = map['email'],
        password = null,
        isim = map['isim'],
        soyisim = map['soyisim'],
        hakkimda = map['hakkimda'],
        il = map['il'],
        adres = map['adres'],
        dogumTarihi = (map['dogumTarihi'] as Timestamp).toDate(),
        foto = map['foto'];




}