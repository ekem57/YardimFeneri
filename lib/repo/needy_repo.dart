import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:yardimfeneri/base_class/authbaseneedy.dart';
import 'package:yardimfeneri/firebasedb/auth/firebaseauthserviceneedy.dart';
import 'package:yardimfeneri/firebasedb/database/firebasedbneedy.dart';
import 'package:yardimfeneri/firebasedb/db/firebase_db_needy.dart';
import 'package:yardimfeneri/firebasedb/firebase_auth_service_needy.dart';
import 'package:yardimfeneri/locator.dart';
import 'package:yardimfeneri/model/konusma.dart';
import 'package:yardimfeneri/model/mesaj.dart';
import 'package:yardimfeneri/model/needy_model.dart';
import 'package:timeago/timeago.dart' as timeago;


enum AppMode { DEBUG, RELEASE }

class NeedyRepo2 implements AuthBaseNeedy {
  FirebaseAuthServiceNeedy _firebaseAuthService = locator<FirebaseAuthServiceNeedy>();

  FirestoreDBServiceNeedy _firestoreDBService = locator<FirestoreDBServiceNeedy>();

  // FirestoreDBServiceHelpful _firestoreDBServiceHelpful = locator<FirestoreDBServiceHelpful>();

  List<NeedyModel> tumKullaniciListesi = [];


  AppMode appMode = AppMode.RELEASE;
  @override
  Future<NeedyModel> currentNeedy() async {
    print("object needy");
    NeedyModel _user = await _firebaseAuthService.currentNeedy();

    return await _firestoreDBService.readNeedy(_user.userId, _user.email.toString());

  }

  @override
  Future<bool> signOut() async {

    return await _firebaseAuthService.signOut();

  }



  @override
  Future<NeedyModel> createUserWithEmailandPasswordNeedy(String email, String sifre,NeedyModel users) async {
    NeedyModel _user = await _firebaseAuthService.createUserWithEmailandPasswordNeedy(email, sifre,users);
    users.userId = _user.userId;
    bool _sonuc = await _firestoreDBService.saveNeedy(users);
    if (_sonuc) {
      return await _firestoreDBService.readNeedy(_user.userId,email);
    }
  }

  @override
  Future<NeedyModel> signInWithEmailandPasswordNeedy(String email, String sifre) async {

    NeedyModel _user = await _firebaseAuthService.signInWithEmailandPasswordNeedy(email, sifre);

    return await _firestoreDBService.readNeedy(_user.userId,email);

  }

  ///Mesajlaşma kısmı
  ///

  Stream<List<Mesaj>> getMessages(
      String currentUserID, String sohbetEdilenUserID) {
    if (appMode == AppMode.DEBUG) {
      return Stream.empty();
    } else {
      return _firestoreDBService.getMessages(currentUserID, sohbetEdilenUserID);
    }
  }

  Stream<List<DocumentSnapshot>> getMessagesDoc(String currentUserID, String sohbetEdilenUserID) {
    if (appMode == AppMode.DEBUG) {
      return Stream.empty();
    } else {
      return _firestoreDBService.getMessagesDoc(currentUserID, sohbetEdilenUserID);
    }
  }

  Future<bool> mesajguncelle(String currentUserID, String sohbetEdilenUserID,String Docid) async {
    if (appMode == AppMode.DEBUG) {
      return true;
    } else {
      var dbGuncellemeIslemi = await _firestoreDBService.mesajguncelle(currentUserID, sohbetEdilenUserID ,Docid);
      return dbGuncellemeIslemi;
    }
  }

  Future<bool> saveMessage(Mesaj kaydedilecekMesaj, NeedyModel currentUser) async {
    if (appMode == AppMode.DEBUG) {
      return true;
    } else {
      var dbYazmaIslemi = await _firestoreDBService.saveMessage(kaydedilecekMesaj,currentUser.userId.toString());
      return true;
    }
  }




  Stream<List<Konusma>> getAllConversations(String userID)  {
    if (appMode == AppMode.DEBUG) {
      return Stream.empty();
    } else {
      var konusmaListesi =  _firestoreDBService.getAllConversations(userID);
      return konusmaListesi;
    }
  }


  void timeagoHesapla(Konusma oankiKonusma, Timestamp zaman) {
    oankiKonusma.sonOkunmaZamani = zaman;

    timeago.setLocaleMessages("tr", timeago.TrMessages());

    var _duration = zaman.toDate().difference(oankiKonusma.olusturulma_tarihi.toDate());
    oankiKonusma.aradakiFark = timeago.format(zaman.toDate().subtract(_duration), locale: "tr");
  }


  Future<List<NeedyModel>> getUserwithPagination(NeedyModel enSonGetirilenUser, int getirilecekElemanSayisi) async {
    if (appMode == AppMode.DEBUG) {
      return [];
    } else {
      List<NeedyModel> _userList = await _firestoreDBService.getUserwithPagination(enSonGetirilenUser, getirilecekElemanSayisi);
      tumKullaniciListesi.addAll(_userList);
      return _userList;
    }
  }





  NeedyModel listedeUserBul(String userID) {
    for (int i = 0; i < tumKullaniciListesi.length; i++) {
      if (tumKullaniciListesi[i].userId == userID) {
        return tumKullaniciListesi[i];
      }
    }

    return null;
  }

}