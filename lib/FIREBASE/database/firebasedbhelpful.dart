import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:yardimfeneri/model/helpful_model.dart';
import 'package:yardimfeneri/model/konusma.dart';
import 'package:yardimfeneri/model/mesaj.dart';
import 'package:yardimfeneri/model/needy_model.dart';

class FirestoreDBServiceHelpful {


  final FirebaseFirestore _firebaseDB = FirebaseFirestore.instance;

  @override
  Future<bool> saveHelpful(HelpfulModel user) async {
    await _firebaseDB
        .collection("helpful")
        .doc(user.userId)
        .set(user.toMap());
    return true;
  }


  @override
  Future<HelpfulModel> readHelpful(String? userID, String? email) async {
    DocumentSnapshot<Map<String, dynamic>> _okunanUser = await _firebaseDB
        .collection("helpful").doc(userID).get();
    Map<String, dynamic>? _okunanUserBilgileriMap = _okunanUser.data();
    if (_okunanUser.data != null) {
      HelpfulModel _okunanUserNesnesi;
      _okunanUserNesnesi = HelpfulModel.fromMap(_okunanUserBilgileriMap!);
      print("Okunan user nesnesi :" + _okunanUserNesnesi.toString());
      return _okunanUserNesnesi;
    } else {
      return null!;
    }
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
          .doc(FirebaseAuth.instance.currentUser!.uid)
          .collection("sohbetler")
          .orderBy("olusturulma_tarihi", descending: true)
          .limit(getirilecekElemanSayisi)
          .get();
    } else {
      _querySnapshot = await FirebaseFirestore.instance
          .collection("sohbetler")
          .doc(FirebaseAuth.instance.currentUser!.uid)
          .collection("sohbetler")
          .orderBy("olusturulma_tarihi", descending: true)
          .limit(getirilecekElemanSayisi)
          .get();

      await Future.delayed(Duration(seconds: 1));
    }

    for (DocumentSnapshot snap in _querySnapshot.docs) {
      print("userid: " + snap['kimle_konusuyor'].toString());
      DocumentSnapshot snapshot = await FirebaseFirestore.instance.collection(
          "ogretmen").doc(snap['kimle_konusuyor']).get();
      NeedyModel _tekUser = NeedyModel.fromMap(
          snapshot.data() as Map<String, dynamic>);
      _tumKullanicilar.add(_tekUser);
    }

    return _tumKullanicilar;
  }


  @override
  Future<List<HelpfulModel>> getUserwithPaginationYonetici(
      HelpfulModel enSonGetirilenUser, int getirilecekElemanSayisi) async {
    QuerySnapshot _querySnapshot;
    List<HelpfulModel> _tumKullanicilar = [];

    if (enSonGetirilenUser == null) {
      _querySnapshot = await FirebaseFirestore.instance
          .collection("sohbetler")
          .doc(FirebaseAuth.instance.currentUser!.uid)
          .collection("sohbetler")
          .orderBy("olusturulma_tarihi", descending: true)
          .limit(getirilecekElemanSayisi)
          .get();
    } else {
      _querySnapshot = await FirebaseFirestore.instance
          .collection("sohbetler")
          .doc(FirebaseAuth.instance.currentUser!.uid)
          .collection("sohbetler")
          .orderBy("olusturulma_tarihi", descending: true)
          .limit(getirilecekElemanSayisi)
          .get();

      await Future.delayed(Duration(seconds: 1));
    }

    for (DocumentSnapshot snap in _querySnapshot.docs) {
      print("userid: " + snap['kimle_konusuyor'].toString());
      DocumentSnapshot snapshot = await FirebaseFirestore.instance.collection(
          "yonetici").doc(snap['kimle_konusuyor']).get();
      HelpfulModel _tekUser = HelpfulModel.fromMap(
          snapshot.data() as Map<String, dynamic>);
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
      Mesaj _tekMesaj = Mesaj.fromMap(snap.data() as Map<String, dynamic>);
      _tumMesajlar.add(_tekMesaj);
    }
    print("gelen toplam mesaj:" + _querySnapshot.docs.length.toString());

    return _tumMesajlar;
  }



}