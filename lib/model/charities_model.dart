
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class CharitiesModel extends ChangeNotifier {
  final String email;
  final String password;
  String userId;
  String telefon;
  String isim;
  String baskan;
  String logo;
  String adres;
  String faaliyetleri;
  String faaliyetalani;
  String faaliyetbelgesi;
  DateTime kurulusTarihi;
  bool hesaponay;


  CharitiesModel({this.userId,this.email, this.password, this.isim, this.logo, this.faaliyetalani, this.kurulusTarihi, this.telefon, this.hesaponay,this.adres,this.baskan,this.faaliyetbelgesi});

  Map<String, dynamic> toMap() {
    return {
      'email': email,
      'userID': userId,
      'telefon': telefon ?? '00000000000',
      'isim': isim,
      'Faaliyetleri': "",
      'logo': 'https://firebasestorage.googleapis.com/v0/b/yardimfeneri.appspot.com/o/logo.png?alt=media&token=f8132b8b-f300-41e8-bc80-9696bd2e2e68',
      'faaliyetalani': faaliyetalani,
      'adres': adres,
      'baskan': baskan,
      'faaliyetbelgesi': faaliyetbelgesi,
      'hesapOnay': hesaponay ?? false,
    };
  }

  CharitiesModel.fromMap(Map<String, dynamic> map)
      : userId = map['userID'],
        telefon = map['telefon'],
        email = map['email'],
        password = null,
        isim = map['isim'],
        faaliyetleri=map['Faaliyetleri'],
        kurulusTarihi = (map['kurulusTarihi'] as Timestamp).toDate(),
        logo = map['logo'],
        faaliyetbelgesi = map['faaliyetbelgesi'],
        adres = map['adres'],
        baskan = map['baskan'],
        hesaponay = map['hesapOnay'];

}