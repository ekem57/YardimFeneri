
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:yardimfeneri/base_class/authbasecharities.dart';
import 'package:yardimfeneri/firebasedb/auth/firebaseauthservicecharities.dart';
import 'package:yardimfeneri/firebasedb/database/firebasedbcharities.dart';
import 'package:yardimfeneri/locator.dart';
import 'package:yardimfeneri/model/charities_model.dart';
import 'package:yardimfeneri/model/konusma.dart';
import 'package:yardimfeneri/model/mesaj.dart';
import 'package:timeago/timeago.dart' as timeago;

enum AppMode { DEBUG, RELEASE }

class CharitiesRepo implements AuthBaseCharities {
  FirebaseAuthServiceCharities _firebaseAuthService = locator<FirebaseAuthServiceCharities>();

  FirestoreDBServiceCharities _firestoreDBService = locator<FirestoreDBServiceCharities>();
  List<CharitiesModel> tumKullaniciListesi = [];


  AppMode appMode = AppMode.RELEASE;
  @override
  Future<CharitiesModel> currentCharities() async {
    print("current charities repo");
    CharitiesModel _user = await _firebaseAuthService.currentCharities();

    return await _firestoreDBService.readCharities(_user.userId, _user.email.toString());

  }

  @override
  Future<bool> signOut() async {

    return await _firebaseAuthService.signOut();

  }



  @override
  Future<CharitiesModel> createUserWithEmailandPasswordCharities(String email, String sifre,CharitiesModel users) async {
    CharitiesModel _user = await _firebaseAuthService.createUserWithEmailandPasswordCharities(email, sifre,users);
    users.userId = _user.userId;
    bool _sonuc = await _firestoreDBService.saveCharities(users);
    if (_sonuc) {
      return await _firestoreDBService.readCharities(_user.userId,email);
    }
  }

  @override
  Future<CharitiesModel> signInWithEmailandPasswordCharities(String email, String sifre) async {

    CharitiesModel _user = await _firebaseAuthService.signInWithEmailandPasswordCharities(email, sifre);

    return await _firestoreDBService.readCharities(_user.userId,email);

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


  Future<List<CharitiesModel>> getUserwithPagination(CharitiesModel enSonGetirilenUser, int getirilecekElemanSayisi) async {
    if (appMode == AppMode.DEBUG) {
      return [];
    } else {
      List<CharitiesModel> _userList = await _firestoreDBService.getUserwithPaginationYonetici(enSonGetirilenUser, getirilecekElemanSayisi);
      tumKullaniciListesi.addAll(_userList);
      return _userList;
    }
  }


  Future<List<Mesaj>> getMessageWithPagination(String currentUserID, String sohbetEdilenUserID, Mesaj enSonGetirilenMesaj, int getirilecekElemanSayisi) async {
    print("current userid: "+currentUserID+"  sohbet edilen id: "+sohbetEdilenUserID +" ");
    if (appMode == AppMode.DEBUG) {
      return [];
    } else {
      return await _firestoreDBService.getMessagewithPagination(currentUserID,
          sohbetEdilenUserID, enSonGetirilenMesaj, getirilecekElemanSayisi);
    }
  }


  Future<bool> saveMessage(Mesaj kaydedilecekMesaj, CharitiesModel currentUser) async {
    if (appMode == AppMode.DEBUG) {
      return true;
    } else {
      var dbYazmaIslemi = await _firestoreDBService.saveMessage(kaydedilecekMesaj,currentUser.userId.toString());


      return true;
    }
  }

  Stream<List<DocumentSnapshot>> getMessagesDoc(
      String currentUserID, String sohbetEdilenUserID) {
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
      var dbGuncellemeIslemi = await _firestoreDBService.mesajguncelle(currentUserID, sohbetEdilenUserID,Docid);
      return dbGuncellemeIslemi;
    }
  }


}