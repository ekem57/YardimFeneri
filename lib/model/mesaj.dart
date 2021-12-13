import 'package:cloud_firestore/cloud_firestore.dart';

class Mesaj {
  final String kimden;
  final String kime;
  final bool bendenMi;
  final String mesaj;
  final String konusmaSahibi;
  bool goruldumu;
  Timestamp date= Timestamp.now();

  Mesaj(
      {this.kimden,
        this.kime,
        this.bendenMi,
        this.mesaj,
         this.date,
         this.goruldumu,
        this.konusmaSahibi});

  Map<String, dynamic> toMap() {
    return {
      'kimden': kimden,
      'kime': kime,
      'bendenMi': bendenMi,
      'mesaj': mesaj,
      'goruldumu': goruldumu,
      'konusmaSahibi': konusmaSahibi,
      'date': date,
    };
  }

  Mesaj.fromMap(Map<String, dynamic> map)
      : kimden = map['kimden'],
        kime = map['kime'],
        bendenMi = map['bendenMi'],
        mesaj = map['mesaj'],
        konusmaSahibi = map['konusmaSahibi'],
        goruldumu = map['goruldumu'],
        date = map['date'];

  @override
  String toString() {
    return 'Mesaj{kimden: $kimden, kime: $kime, bendenMi: $bendenMi, mesaj: $mesaj, date: $date}';
  }
}
