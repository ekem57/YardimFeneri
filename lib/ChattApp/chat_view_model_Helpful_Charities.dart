import 'dart:async';
import 'package:flutter/material.dart';
import 'package:yardimfeneri/locator.dart';
import 'package:yardimfeneri/model/charities_model.dart';
import 'package:yardimfeneri/model/helpful_model.dart';
import 'package:yardimfeneri/model/mesaj.dart';
import 'package:yardimfeneri/repo/helpfulrepo.dart';


enum ChatViewStateHelpful_Charities { Idle, Loaded, Busy }

class ChatViewModelHelpful_Charities with ChangeNotifier {
  List<Mesaj> _tumMesajlar;
  ChatViewStateHelpful_Charities _state = ChatViewStateHelpful_Charities.Idle;
  static final sayfaBasinaGonderiSayisi = 20;
  HelpfulRepo _userRepository = locator<HelpfulRepo>();
  final HelpfulModel currentUser;
  final CharitiesModel sohbetEdilenUser;
  Mesaj _enSonGetirilenMesaj;
  Mesaj _listeyeEklenenIlkMesaj;
  bool _hasMore = true;
  bool _yeniMesajDinleListener = false;
  List<Mesaj> _tumMesajlarTers;
  bool get hasMoreLoading => _hasMore;

  StreamSubscription _streamSubscription;

  ChatViewModelHelpful_Charities({this.currentUser,this.sohbetEdilenUser}) {
    _tumMesajlar = [];
    _tumMesajlarTers=[];
    getMessageWithPagination(false);
  }

  List<Mesaj> get mesajlarListesi => _tumMesajlar;
  List<Mesaj> get mesajlarListesiTers => _tumMesajlarTers;
  ChatViewStateHelpful_Charities get state => _state;

  set state(ChatViewStateHelpful_Charities value) {
    _state = value;
    notifyListeners();
  }

  @override
  dispose() {
    print("Chatviewmodel dispose edildi");
    _streamSubscription.cancel();
    super.dispose();
  }

  Future<bool> saveMessage(Mesaj kaydedilecekMesaj, HelpfulModel currentUser) async {
    return await _userRepository.saveMessage(kaydedilecekMesaj, currentUser);
  }


  void getMessageWithPagination(bool yeniMesajlarGetiriliyor) async {
    if (_tumMesajlar.length > 0) {
      print("tüm mesajlar listesi buyuk 0dır.");
      //print("tüm mesajlar son mesaj."+_tumMesajlar!.last.mesaj);
      _enSonGetirilenMesaj = _tumMesajlar.last;
    }

    if (!yeniMesajlarGetiriliyor) state = ChatViewStateHelpful_Charities.Busy;

    var getirilenMesajlar = await _userRepository.getMessageWithPagination(
        currentUser.userId.toString(),
        sohbetEdilenUser.userId.toString(),
        _enSonGetirilenMesaj,
        sayfaBasinaGonderiSayisi);

    if (getirilenMesajlar.length < sayfaBasinaGonderiSayisi) {
      _hasMore = false;
    }

    //getirilenMesajlar.forEach((msj) => print("getirilen mesajlar:" + msj!.mesaj));

    _tumMesajlar.addAll(getirilenMesajlar);
    _tumMesajlarTers.addAll(_tumMesajlar.reversed);
    if (_tumMesajlar.length > 0) {
      _listeyeEklenenIlkMesaj = _tumMesajlar.first;
      // print("Listeye eklenen ilk mesaj :" + _listeyeEklenenIlkMesaj.mesaj);
    }

    state = ChatViewStateHelpful_Charities.Loaded;

    if (_yeniMesajDinleListener == false) {
      _yeniMesajDinleListener = true;
      //print("Listener yok o yüzden atanacak");
      yeniMesajListenerAta();
    }
  }

  Future<void> dahaFazlaMesajGetir() async {
    //print("Daha fazla mesaj getir tetiklendi - viewmodeldeyiz -");
    if (_hasMore) getMessageWithPagination(true);
    /*else
      print("Daha fazla eleman yok o yüzden çagrılmayacak");*/
    await Future.delayed(Duration(seconds: 2));
  }
  void yeniMesajListenerAta() {
    //print("Yeni mesajlar için listener atandı");
    // _userRepository.mesajguncelle(currentUser.userID, sohbetEdilenUser.userID);
    _streamSubscription = _userRepository.getMessagesDoc(currentUser.userId, sohbetEdilenUser.userId)
        .listen((anlikData) {

      if (anlikData.isNotEmpty) {

        //print("mesaj lsitesinin ilk elemani:" +_tumMesajlar[0].toString());

        Mesaj msj=Mesaj.fromMap(anlikData[0].data());
        if (msj.date != null) {
          if(!msj.bendenMi){
            _userRepository.mesajguncelle(sohbetEdilenUser.userId, currentUser.userId,anlikData[0].id);
          }


          if (_listeyeEklenenIlkMesaj == null) {

            _tumMesajlar.insert(0, msj);
            _tumMesajlarTers.insert(0, msj);
          }
          else  if(_tumMesajlar[0].date.millisecondsSinceEpoch == msj.date.millisecondsSinceEpoch){

            if(_tumMesajlar[0].goruldumu != msj.goruldumu){
              _tumMesajlar[0].goruldumu=msj.goruldumu;

            }
          }
          else if (_listeyeEklenenIlkMesaj.date.millisecondsSinceEpoch != msj.date.millisecondsSinceEpoch) {

            _tumMesajlar.insert(0, msj);
            _tumMesajlarTers.insert(0, msj);
            if(_tumMesajlar[0].date.millisecondsSinceEpoch == msj.date.millisecondsSinceEpoch && _tumMesajlar[0].goruldumu != msj.goruldumu) {
              _tumMesajlar[0].goruldumu=msj.goruldumu;
            }
          }

        }


        state = ChatViewStateHelpful_Charities.Loaded;
      }
    });
  }

}