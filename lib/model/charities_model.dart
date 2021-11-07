
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class CharitiesModel extends ChangeNotifier {
  final String? email;
  final String? password;
  late  String? userId;
  String? telefon;
  String? isim;
  String? logo;
  String? faaliyetalani;
  DateTime? kurulusTarihi;
  bool? hesaponay;

  //CharitiesModel( this.userId ,{this.email, this.password, this.isim, this.logo, this.faaliyetalani, this.kurulusTarihi, this.telefon, this.hesaponay});

  CharitiesModel({this.userId,this.email, this.password, this.isim, this.logo, this.faaliyetalani, this.kurulusTarihi, this.telefon, this.hesaponay});

  Map<String, dynamic> toMap() {
    return {
      'email': email,
      'userID': userId,
      'telefon': telefon ?? '00000000000',
      'isim': isim,
      'logo': logo,
      'faaliyetalani': faaliyetalani,
      'kurulusTarihi': kurulusTarihi,
      'hesapOnay': hesaponay ?? false,
    };
  }

  CharitiesModel.fromMap(Map<String, dynamic> map)
      : userId = map['userID'],
        telefon = map['telefon'],
        email = map['email'],
        password = null,
        isim = map['isim'],
        kurulusTarihi = (map['kurulusTarihi'] as Timestamp).toDate(),
        logo = map['logo'],
        hesaponay = map['hesapOnay'];

}