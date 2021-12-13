
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class HelpfulModel extends ChangeNotifier {
  final String email;
  final String password;
  String userId;
  String telefon;
  String isim;
  String soyisim;
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
      'soyisim': soyisim,
      'il': il,
      'adres': adres,
      'foto': foto,
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
        il = map['il'],
        adres = map['adres'],
        dogumTarihi = (map['dogumTarihi'] as Timestamp).toDate(),
        foto = map['foto'];




}