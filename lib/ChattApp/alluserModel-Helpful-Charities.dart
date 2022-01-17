import 'dart:async';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:yardimfeneri/locator.dart';
import 'package:yardimfeneri/model/charities_model.dart';
import 'package:yardimfeneri/model/helpful_model.dart';
import 'package:yardimfeneri/model/konusma.dart';
import 'package:yardimfeneri/repo/charities_repo.dart';
import 'package:yardimfeneri/repo/helpfulrepo.dart';


enum AllUserViewStateHelpful_Charities { Idle, Loaded, Busy }

class AllUserViewModelHelpful_Charities with ChangeNotifier {
  AllUserViewStateHelpful_Charities _state = AllUserViewStateHelpful_Charities.Idle;
  List<CharitiesModel> _tumKullanicilar;
  CharitiesModel _enSonGetirilenUser;
  static final sayfaBasinaGonderiSayisi = 10;
  bool _hasMore = true;
  List<Konusma> tumKonusma;
  List<bool> yenigelenokunmamiskonusmalar=[];
  bool get hasMoreLoading => _hasMore;
  StreamSubscription _streamSubscription;
  CharitiesRepo _userRepository = locator<CharitiesRepo>();
  List<CharitiesModel> get kullanicilarListesi => _tumKullanicilar;

  List<Konusma> get kullaniciBilgileri => tumKonusma;
  AllUserViewStateHelpful_Charities get state => _state;

  set state(AllUserViewStateHelpful_Charities value) {
    _state = value;
    notifyListeners();
  }

  AllUserViewModelHelpful_Charities() {
    _tumKullanicilar = [];
    tumKonusma=[];
    _enSonGetirilenUser = null;
    getUserWithPagination(_enSonGetirilenUser, false,FirebaseAuth.instance.currentUser.uid);
  }


  @override
  dispose() {
    _streamSubscription.cancel();
    super.dispose();
  }

  //refresh ve sayfalama için
  //yenielemanlar getir true yapılır
  //ilk açılıs için yenielemanlar için false deger verilir.
  getUserWithPagination(CharitiesModel enSonGetirilenUser, bool yeniElemanlarGetiriliyor,String userid) async {
    if (_tumKullanicilar.length > 0) {
      _enSonGetirilenUser = _tumKullanicilar.last;
    }

    if (yeniElemanlarGetiriliyor) {
    } else {
      state = AllUserViewStateHelpful_Charities.Busy;
    }

    var yeniListe = await _userRepository.getUserwithPagination(_enSonGetirilenUser, sayfaBasinaGonderiSayisi);

    if (yeniListe.length < sayfaBasinaGonderiSayisi) {
      _hasMore = false;
    }


    _tumKullanicilar.addAll(yeniListe);


    _streamSubscription = _userRepository.getAllConversations(userid)
        .listen((anlikData) async {

      tumKonusma.clear();
      yenigelenokunmamiskonusmalar.clear();

      tumKonusma.addAll(anlikData);

      if(_tumKullanicilar.isNotEmpty) {
        if (tumKonusma[0].kimle_konusuyor != _tumKullanicilar[0].userId) {
          refresh();
        }
      }


      state = AllUserViewStateHelpful_Charities.Loaded;

    });

    state = AllUserViewStateHelpful_Charities.Loaded;
  }

  Future<void> dahaFazlaUserGetir() async {
    // print("Daha fazla user getir tetiklendi - viewmodeldeyiz -");
    if (_hasMore) getUserWithPagination(_enSonGetirilenUser, true,FirebaseAuth.instance.currentUser.uid.toString());
    //else
    //print("Daha fazla eleman yok o yüzden çagrılmayacak");
    await Future.delayed(Duration(seconds: 2));
  }

  Future<Null> refresh() async {
    _hasMore = true;
    _enSonGetirilenUser = null;
    _tumKullanicilar = [];
    getUserWithPagination(_enSonGetirilenUser, true,FirebaseAuth.instance.currentUser.uid);
  }

}