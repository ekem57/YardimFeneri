import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:yardimfeneri/base_class/authbasehelpful.dart';
import 'package:yardimfeneri/firebasedb/auth/firebaseauthservicehelpful.dart';
import 'package:yardimfeneri/firebasedb/database/firebasedbhelpful.dart';
import 'package:yardimfeneri/locator.dart';
import 'package:yardimfeneri/model/helpful_model.dart';
import 'package:yardimfeneri/model/konusma.dart';
import 'package:yardimfeneri/model/mesaj.dart';
import 'package:timeago/timeago.dart' as timeago;


enum AppMode { DEBUG, RELEASE }

class HelpfulRepo implements AuthBaseHelpful {
  FirebaseAuthServiceHelpful _firebaseAuthService = locator<FirebaseAuthServiceHelpful>();

  FirestoreDBServiceHelpful _firestoreDBService = locator<FirestoreDBServiceHelpful>();

  List<HelpfulModel> tumKullaniciListesi = [];

  AppMode appMode = AppMode.RELEASE;
  @override
  Future<HelpfulModel?> currentHelpful() async {

    HelpfulModel? _user = await _firebaseAuthService.currentHelpful();

    return await _firestoreDBService.readHelpful(_user!.userId, _user.email.toString());

  }

  @override
  Future<bool> signOut() async {

    return await _firebaseAuthService.signOut();

  }



  @override
  Future<HelpfulModel?> createUserWithEmailandPasswordHelpful(String email, String sifre,HelpfulModel users) async {
    HelpfulModel? _user = await _firebaseAuthService.createUserWithEmailandPasswordHelpful(email, sifre,users);
    users.userId = _user!.userId;
    bool _sonuc = await _firestoreDBService.saveHelpful(users);
    if (_sonuc) {
      return await _firestoreDBService.readHelpful(_user.userId,email);
    }
  }

  @override
  Future<HelpfulModel?> signInWithEmailandPasswordHelpful(String email, String sifre) async {

    HelpfulModel? _user = await _firebaseAuthService.signInWithEmailandPasswordHelpful(email, sifre);

    return await _firestoreDBService.readHelpful(_user!.userId.toString(),email);

  }



  /// Mesajlasma kısmı
///
///


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

    var _duration = zaman.toDate().difference(oankiKonusma.olusturulma_tarihi!.toDate());
    oankiKonusma.aradakiFark = timeago.format(zaman.toDate().subtract(_duration), locale: "tr");
  }


  Future<List<HelpfulModel>> getUserwithPagination(HelpfulModel enSonGetirilenUser, int getirilecekElemanSayisi) async {
    if (appMode == AppMode.DEBUG) {
      return [];
    } else {
      List<HelpfulModel> _userList = await _firestoreDBService.getUserwithPaginationYonetici(enSonGetirilenUser, getirilecekElemanSayisi);
      tumKullaniciListesi.addAll(_userList);
      return _userList;
    }
  }


  Future<List<Mesaj>> getMessageWithPagination(
      String currentUserID,
      String sohbetEdilenUserID,
      Mesaj enSonGetirilenMesaj,
      int getirilecekElemanSayisi) async {
    if (appMode == AppMode.DEBUG) {
      return [];
    } else {
      return await _firestoreDBService.getMessagewithPagination(currentUserID,
          sohbetEdilenUserID, enSonGetirilenMesaj, getirilecekElemanSayisi);
    }
  }


  Future<bool> saveMessage(Mesaj kaydedilecekMesaj, HelpfulModel? currentUser) async {
    if (appMode == AppMode.DEBUG) {
      return true;
    } else {
      var dbYazmaIslemi = await _firestoreDBService.saveMessage(kaydedilecekMesaj,currentUser!.userId.toString());


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