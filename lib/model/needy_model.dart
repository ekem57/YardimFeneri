
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class NeedyModel extends ChangeNotifier {
  final String email;
  final String password;
  String userId;
  String telefon;
  String isim;
  String soyisim;
  String meslek;
  String adres;
  String il;
  String foto;
  DateTime dogumTarihi;
  bool hesaponay;



  NeedyModel({this.userId,this.email, this.password,this.isim,this.soyisim,this.meslek,this.adres,this.il,this.foto,this.dogumTarihi,this.telefon,this.hesaponay});

  Map<String, dynamic> toMap() {
    return {
      'email': email,
      'userID': userId,
      'telefon': telefon ?? '00000000000',
      'isim': isim,
      'soyisim': soyisim,
      'meslek': meslek,
      'il': il,
      'adres': adres,
      'foto': foto,
      'dogumTarihi': dogumTarihi,
      'hesapOnay': hesaponay ?? false,
    };
  }

  NeedyModel.fromMap(Map<String, dynamic> map)
      : userId = map['userID'],
        telefon = map['telefon'],
        email = map['email'],
        password = null,
        isim = map['isim'],
        soyisim = map['soyisim'],
        meslek = map['meslek'],
        il = map['il'],
        adres = map['adres'],
        dogumTarihi = (map['dogumTarihi'] as Timestamp).toDate(),
        foto = map['foto'],
        hesaponay = map['hesapOnay'];

}