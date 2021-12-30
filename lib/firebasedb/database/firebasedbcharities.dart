import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:yardimfeneri/model/charities_model.dart';
import 'package:yardimfeneri/model/konusma.dart';
import 'package:yardimfeneri/model/mesaj.dart';
import 'package:yardimfeneri/model/needy_model.dart';

class FirestoreDBServiceCharities {


  final FirebaseFirestore _firebaseDB = FirebaseFirestore.instance;

  @override
  Future<bool> saveCharities(CharitiesModel user) async {
    await _firebaseDB
        .collection("charities")
        .doc(user.userId)
        .set(user.toMap());
    return true;
  }

  @override
  Future<CharitiesModel> readCharities(String userID, String email) async {
    print("gelen userid read charities: "+userID.toString());
    DocumentSnapshot _okunanUser = await _firebaseDB.collection("charities").doc(userID).get();
    Map<String, dynamic> _okunanUserBilgileriMap = _okunanUser.data();
    print("okunan user: "+_okunanUserBilgileriMap.toString());
    if(_okunanUser.data != null){
      CharitiesModel _okunanUserNesnesi;
      _okunanUserNesnesi = CharitiesModel.fromMap(_okunanUserBilgileriMap);
      print("Okunan user nesnesi :" + _okunanUserNesnesi.toString());
      return _okunanUserNesnesi;
    }else{
      return null;
    }

  }
  
  Future<void> uyekabul(String kurumID,String basvuranuserid,String uyetipi) async {
   await _firebaseDB.collection("charities").doc(kurumID).collection("uyebasvuru").doc(basvuranuserid).delete();
   await _firebaseDB.collection("charities").doc(kurumID).collection("uyeler").doc(basvuranuserid).set({'uyeid':basvuranuserid,'uyetipi':uyetipi});
  }

  Future<void> uyered(String kurumID,String basvuranuserid) async {
    await _firebaseDB.collection("charities").doc(kurumID).collection("uyebasvuru").doc(basvuranuserid).delete();
  }

  Future<bool> kurumKatilButonu(String etid, String userid) async {

    Map<String, dynamic> EtkinlikEkle = Map();

    EtkinlikEkle['kurumid'] = etid;
    EtkinlikEkle['onay'] = "katildi";
    await _firebaseDB.collection("usersEtkinlik").doc(userid).collection("katilimci").doc(etid).set(EtkinlikEkle);
    await _firebaseDB.collection("users").doc(userid).update({'katilinanetkinliksayisi': FieldValue.increment(1)});

    return true;
  }

  Future<bool> kurumKatilmaIstegiButonu(DocumentSnapshot card, String userid) async {
    Map<String, dynamic> EtkinlikIstek = Map();

    EtkinlikIstek['kurumid'] = card['userID'];
    EtkinlikIstek['onay'] = "onayda";
    EtkinlikIstek['userid'] = userid;

    await _firebaseDB
        .collection("kurumKatilimİstekleri")
        .doc(userid)
        .collection("katilimcilar")
        .doc(card['userID'].toString())
        .set(EtkinlikIstek);

    return true;
  }

  Future<bool> kurumKatilmaIstegiVazgecButonu(DocumentSnapshot card, String userid) async {
    Map<String, dynamic> EtkinlikIstek = Map();
    EtkinlikIstek['kurumid'] = card['userID'];
    EtkinlikIstek['userid'] = userid;
    EtkinlikIstek['onay'] = "katilmadi";


    await _firebaseDB
        .collection("kurumKatilimİstekleri")
        .doc(userid)
        .collection("katilimcilar")
        .doc(card['userID'].toString())
        .set(EtkinlikIstek);

    return true;
  }


  Future<void> yardimonay(String icerik,String kurumid,String userid,String yardim_id,DocumentSnapshot card) async {

    DocumentReference _reference = await FirebaseFirestore.instance.collection("anasayfa").doc();
    DocumentReference _myreference = await FirebaseFirestore.instance.collection("charities").doc(kurumid).collection("yardim_destekleri").doc(_reference.id);

    Map<String, dynamic> yardim = Map();

    yardim['bicim'] = "yardim";
    yardim['date'] = Timestamp.now();
    yardim['icerik'] = icerik;
    yardim['foto'] = "null";
    yardim['kurumid'] = kurumid;
    yardim['yardim_id'] = yardim_id;
    yardim['toplanan'] = 0;
    yardim['userid'] = userid;
    yardim['tamamlandi'] = false;

   await _reference.set(yardim);
   await _myreference.set(yardim);
   await FirebaseFirestore.instance.collection('charities').doc(kurumid).collection("ihtiyac_sahipleri_yardim_istekleri").doc(card.reference.id).delete();
  }

  Future<void> yardimred(DocumentSnapshot card) async {
   await card.reference.delete();
  }

  @override
  Stream<List<Konusma>> getAllConversations(String userID) {
    var querySnapshot = _firebaseDB
        .collection("sohbetler")
        .doc(userID)
        .collection("sohbetler")
        .orderBy("olusturulma_tarihi", descending: true)
        .snapshots();


    return querySnapshot.map((mesajListesi) =>
        mesajListesi.docs
            .map((mesaj) => Konusma.fromMap(mesaj.data()))
            .toList());
  }


  @override
  Stream<List<Mesaj>> getMessages(String currentUserID,
      String sohbetEdilenUserID) {
    var snapShot = _firebaseDB
        .collection("sohbetler")
        .doc(currentUserID)
        .collection("sohbetler")
        .doc(sohbetEdilenUserID)
        .collection("mesajlar")
        .where("konusmaSahibi", isEqualTo: currentUserID)
        .orderBy("date", descending: true)
        .limit(1)
        .snapshots();
    return snapShot.map((mesajListesi) =>
        mesajListesi.docs
            .map((mesaj) => Mesaj.fromMap(mesaj.data()))
            .toList());
  }

  @override
  Stream<List<DocumentSnapshot>> getMessagesDoc(String currentUserID,
      String sohbetEdilenUserID) {
    var snapShot = _firebaseDB
        .collection("sohbetler")
        .doc(currentUserID)
        .collection("sohbetler")
        .doc(sohbetEdilenUserID)
        .collection("mesajlar")
        .where("konusmaSahibi", isEqualTo: currentUserID)
        .orderBy("date", descending: true)
        .limit(1)
        .snapshots();


    return snapShot.map((mesajListesi) => mesajListesi.docs.toList());
  }


  Future<bool> saveMessage(Mesaj kaydedilecekMesaj, String userid) async {
    var _mesajID = _firebaseDB
        .collection("sohbetler")
        .doc(userid)
        .collection("sohbetler")
        .doc()
        .id;
    var _myDocumentID = kaydedilecekMesaj.kime;
    var _receiverDocumentID = kaydedilecekMesaj.kimden;

    var _kaydedilecekMesajMapYapisi = kaydedilecekMesaj.toMap();

    await _firebaseDB
        .collection("sohbetler")
        .doc(userid)
        .collection("sohbetler")
        .doc(_myDocumentID)
        .collection("mesajlar")
        .doc(_mesajID)
        .set(_kaydedilecekMesajMapYapisi);

    await _firebaseDB.collection("sohbetler").doc(userid)
        .collection("sohbetler").doc(_myDocumentID).set({
      "konusma_sahibi": kaydedilecekMesaj.kimden,
      "kimle_konusuyor": kaydedilecekMesaj.kime,
      "son_yollanan_mesaj": kaydedilecekMesaj.mesaj,
      "konusma_goruldu": false,
      "olusturulma_tarihi": FieldValue.serverTimestamp(),
    });

    _kaydedilecekMesajMapYapisi.update("bendenMi", (deger) => false);
    _kaydedilecekMesajMapYapisi.update(
        "konusmaSahibi", (deger) => kaydedilecekMesaj.kime);

    await _firebaseDB
        .collection("sohbetler")
        .doc(kaydedilecekMesaj.kime)
        .collection("sohbetler")
        .doc(_receiverDocumentID)
        .collection("mesajlar")
        .doc(_mesajID)
        .set(_kaydedilecekMesajMapYapisi);

    await _firebaseDB
        .collection("sohbetler")
        .doc(kaydedilecekMesaj.kime)
        .collection("sohbetler")
        .doc(_receiverDocumentID)
        .set({
      "konusma_sahibi": kaydedilecekMesaj.kime,
      "kimle_konusuyor": kaydedilecekMesaj.kimden,
      "son_yollanan_mesaj": kaydedilecekMesaj.mesaj,
      "konusma_goruldu": false,
      "olusturulma_tarihi": FieldValue.serverTimestamp(),
    });

    return true;
  }

  @override
  Future<DateTime> saatiGoster(String userID) async {
    await _firebaseDB.collection("server").doc(userID).set({
      "saat": FieldValue.serverTimestamp(),
    });

    var okunanMap =
    await _firebaseDB.collection("server").doc(userID).get();
    Timestamp okunanTarih = okunanMap["saat"];
    return okunanTarih.toDate();
  }


  @override
  bool mesajguncelle(String currentUserID, String sohbetEdilenUserID,
      String docid) {
    var snapShot = _firebaseDB
        .collection("sohbetler")
        .doc(currentUserID)
        .collection("sohbetler")
        .doc(sohbetEdilenUserID)
        .collection("mesajlar").doc(docid).update({'goruldumu': true});

    _firebaseDB
        .collection("sohbetler")
        .doc(currentUserID)
        .collection("sohbetler")
        .doc(sohbetEdilenUserID).update({'son_gorulme': true});

    return true;
  }

  @override
  Future<List<NeedyModel>> getUserwithPagination(NeedyModel enSonGetirilenUser,
      int getirilecekElemanSayisi) async {
    QuerySnapshot _querySnapshot;
    List<NeedyModel> _tumKullanicilar = [];

    if (enSonGetirilenUser == null) {
      _querySnapshot = await FirebaseFirestore.instance
          .collection("sohbetler")
          .doc(FirebaseAuth.instance.currentUser.uid)
          .collection("sohbetler")
          .orderBy("olusturulma_tarihi", descending: true)
          .limit(getirilecekElemanSayisi)
          .get();
    } else {
      _querySnapshot = await FirebaseFirestore.instance
          .collection("sohbetler")
          .doc(FirebaseAuth.instance.currentUser.uid)
          .collection("sohbetler")
          .orderBy("olusturulma_tarihi", descending: true)
          .limit(getirilecekElemanSayisi)
          .get();

      await Future.delayed(Duration(seconds: 1));
    }

    for (DocumentSnapshot snap in _querySnapshot.docs) {
      print("userid: " + snap['kimle_konusuyor'].toString());
      DocumentSnapshot snapshot = await FirebaseFirestore.instance.collection("charities").doc(snap['kimle_konusuyor']).get();
      NeedyModel _tekUser = NeedyModel.fromMap(snapshot.data());
      _tumKullanicilar.add(_tekUser);
    }

    return _tumKullanicilar;
  }


  @override
  Future<List<CharitiesModel>> getUserwithPaginationYonetici(CharitiesModel enSonGetirilenUser, int getirilecekElemanSayisi) async {
    QuerySnapshot _querySnapshot;
    List<CharitiesModel> _tumKullanicilar = [];

    if (enSonGetirilenUser == null) {
      _querySnapshot = await FirebaseFirestore.instance
          .collection("sohbetler")
          .doc(FirebaseAuth.instance.currentUser.uid)
          .collection("sohbetler")
          .orderBy("olusturulma_tarihi", descending: true)
          .limit(getirilecekElemanSayisi)
          .get();
    } else {
      _querySnapshot = await FirebaseFirestore.instance
          .collection("sohbetler")
          .doc(FirebaseAuth.instance.currentUser.uid)
          .collection("sohbetler")
          .orderBy("olusturulma_tarihi", descending: true)
          .limit(getirilecekElemanSayisi)
          .get();

      await Future.delayed(Duration(seconds: 1));
    }

    for (DocumentSnapshot snap in _querySnapshot.docs) {
      print("userid: " + snap['kimle_konusuyor'].toString());
      DocumentSnapshot snapshot = await FirebaseFirestore.instance.collection("charities").doc(snap['kimle_konusuyor']).get();
      CharitiesModel _tekUser = CharitiesModel.fromMap(snapshot.data());
      _tumKullanicilar.add(_tekUser);
    }

    return _tumKullanicilar;
  }


  Future<List<Mesaj>> getMessagewithPagination(String currentUserID,
      String sohbetEdilenUserID,
      Mesaj enSonGetirilenMesaj,
      int getirilecekElemanSayisi) async {
    QuerySnapshot _querySnapshot;
    List<Mesaj> _tumMesajlar = [];

    if (enSonGetirilenMesaj == null) {
      _querySnapshot = await FirebaseFirestore.instance
          .collection("sohbetler")
          .doc(currentUserID)
          .collection("sohbetler")
          .doc(sohbetEdilenUserID)
          .collection("mesajlar")
          .where("konusmaSahibi", isEqualTo: currentUserID)
          .orderBy("date", descending: true)
          .limit(getirilecekElemanSayisi)
          .get();
    } else {
      _querySnapshot = await FirebaseFirestore.instance
          .collection("sohbetler")
          .doc(currentUserID)
          .collection("sohbetler")
          .doc(sohbetEdilenUserID)
          .collection("mesajlar")
          .where("konusmaSahibi", isEqualTo: currentUserID)
          .orderBy("date", descending: true)
          .startAfter([enSonGetirilenMesaj.date])
          .limit(getirilecekElemanSayisi)
          .get();

      await Future.delayed(Duration(seconds: 1));
    }

    for (DocumentSnapshot snap in _querySnapshot.docs) {
      Mesaj _tekMesaj = Mesaj.fromMap(snap.data());
      _tumMesajlar.add(_tekMesaj);
    }
    print("gelen toplam mesaj:" + _querySnapshot.docs.length.toString());

    return _tumMesajlar;
  }



}