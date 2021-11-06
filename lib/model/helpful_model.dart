
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class HelpfulModel extends ChangeNotifier {
  final String? email;
  final String? password;
  final String userId;
  String? telefon;
  String? isim;
  String? soyisim;
  String? foto;
  DateTime? dogumTarihi;
  bool? hesaponay;

  HelpfulModel(this.userId, {this.email, this.password,this.isim,this.soyisim,this.foto,this.dogumTarihi,this.telefon,this.hesaponay});

  Map<String, dynamic> toMap() {
    return {
      'email': email,
      'userID': userId,
      'telefon': telefon ?? '00000000000',
      'isim': isim,
      'soyisim': soyisim,
      'foto': foto,
      'dogumTarihi': dogumTarihi,
      'hesapOnay':hesaponay ?? false,
    };
  }

  HelpfulModel.fromMap(Map<String, dynamic> map)
      : userId = map['userId'],
        telefon = map['telefon'],
        email = map['email'],
        isim = map['isim'],
        soyisim = map['soyisim'],
        password = null,
        dogumTarihi = (map['dogumTarihi'] as Timestamp).toDate(),
        foto = map['avatarImageUrl'],
        hesaponay = map['hesapOnay'];




}