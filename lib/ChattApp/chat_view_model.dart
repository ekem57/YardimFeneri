import 'dart:async';
import 'package:flutter/material.dart';
import 'package:yardimfeneri/locator.dart';
import 'package:yardimfeneri/model/helpful_model.dart';
import 'package:yardimfeneri/model/mesaj.dart';
import 'package:yardimfeneri/model/needy_model.dart';
import 'package:yardimfeneri/repository/helpfulrepo.dart';


enum ChatViewState { Idle, Loaded, Busy }

class ChatViewModel with ChangeNotifier {
  List<Mesaj>? _tumMesajlar;
  ChatViewState? _state = ChatViewState.Idle;
  static final sayfaBasinaGonderiSayisi = 20;
  HelpfulRepo _userRepository = locator<HelpfulRepo>();
  final HelpfulModel? currentUser;
  final NeedyModel? sohbetEdilenUser;
  Mesaj? _enSonGetirilenMesaj;
  Mesaj? _listeyeEklenenIlkMesaj;
  bool _hasMore = true;
  bool _yeniMesajDinleListener = false;
  List<Mesaj>? _tumMesajlarTers;
  bool get hasMoreLoading => _hasMore;

  StreamSubscription? _streamSubscription;

  ChatViewModel({this.currentUser, this.sohbetEdilenUser}) {
    _tumMesajlar = [];
    _tumMesajlarTers=[];
    getMessageWithPagination(false);
  }

  List<Mesaj>?get mesajlarListesi => _tumMesajlar;
  List<Mesaj>? get mesajlarListesiTers => _tumMesajlarTers;
  ChatViewState get state => _state!;

  set state(ChatViewState value) {
    _state = value;
    notifyListeners();
  }

  @override
  dispose() {
    print("Chatviewmodel dispose edildi");
    _streamSubscription!.cancel();
    super.dispose();
  }

  Future<bool> saveMessage(Mesaj kaydedilecekMesaj, HelpfulModel? currentUser) async {
    return await _userRepository.saveMessage(kaydedilecekMesaj, currentUser);
  }

  void getMessageWithPagination(bool yeniMesajlarGetiriliyor) async {
    if (_tumMesajlar!.length > 0) {
      print("tüm mesajlar listesi buyuk 0dır.");
      print("tüm mesajlar son mesaj."+_tumMesajlar!.last.mesaj.toString());
      _enSonGetirilenMesaj = _tumMesajlar!.last;
    }

    if (!yeniMesajlarGetiriliyor) state = ChatViewState.Busy;

    var getirilenMesajlar = await _userRepository.getMessageWithPagination(
        currentUser!.userId.toString(),
        sohbetEdilenUser!.userId.toString(),
        _enSonGetirilenMesaj!,
        sayfaBasinaGonderiSayisi);

    if (getirilenMesajlar.length < sayfaBasinaGonderiSayisi) {
      _hasMore = false;
    }

    getirilenMesajlar
        .forEach((msj) => print("getirilen mesajlar:" + msj.mesaj.toString()));

    _tumMesajlar!.addAll(getirilenMesajlar);
    _tumMesajlarTers!.addAll(_tumMesajlar!.reversed);
    if (_tumMesajlar!.length > 0) {
      _listeyeEklenenIlkMesaj = _tumMesajlar!.first;
      // print("Listeye eklenen ilk mesaj :" + _listeyeEklenenIlkMesaj.mesaj);
    }

    state = ChatViewState.Loaded;

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
    _streamSubscription = _userRepository.getMessagesDoc(currentUser!.userId.toString(), sohbetEdilenUser!.userId.toString())
        .listen((anlikData) {

      if (anlikData.isNotEmpty) {

        //print("mesaj lsitesinin ilk elemani:" +_tumMesajlar[0].toString());

        Mesaj msj=Mesaj.fromMap(anlikData[0].data() as Map<String, dynamic>);
        if (msj.date != null) {
          if(!msj.bendenMi!){
            _userRepository.mesajguncelle(sohbetEdilenUser!.userId.toString(), currentUser!.userId.toString(),anlikData[0].id);
          }


          if (_listeyeEklenenIlkMesaj == null) {

            _tumMesajlar!.insert(0, msj);
            _tumMesajlarTers!.insert(0, msj);
          }
          else  if(_tumMesajlar![0].date.millisecondsSinceEpoch == msj.date.millisecondsSinceEpoch){

            if(_tumMesajlar![0].goruldumu != msj.goruldumu){
              _tumMesajlar![0].goruldumu=msj.goruldumu;

            }
          }
          else if (_listeyeEklenenIlkMesaj!.date.millisecondsSinceEpoch != msj.date.millisecondsSinceEpoch) {

            _tumMesajlar!.insert(0, msj);
            _tumMesajlarTers!.insert(0, msj);
            if(_tumMesajlar![0].date.millisecondsSinceEpoch == msj.date.millisecondsSinceEpoch && _tumMesajlar![0].goruldumu != msj.goruldumu) {
              _tumMesajlar![0].goruldumu=msj.goruldumu;
            }
          }

        }


        state = ChatViewState.Loaded;
      }
    });
  }
/*
  void yeniMesajListenerAta() {
    //print("Yeni mesajlar için listener atandı");
    _streamSubscription = _userRepository
        .getMessages(currentUser.userId, sohbetEdilenUser.userId)
        .listen((anlikData) {
      if (anlikData.isNotEmpty) {
        //print("listener tetiklendi ve son getirilen veri:" +anlikData[0].toString());

        if (anlikData[0].date != null) {
          if (_listeyeEklenenIlkMesaj == null) {
            _tumMesajlar.insert(0, anlikData[0]);
          } else if (_listeyeEklenenIlkMesaj.date.millisecondsSinceEpoch !=
              anlikData[0].date.millisecondsSinceEpoch)
            _tumMesajlar.insert(0, anlikData[0]);
        }

        state = ChatViewState.Loaded;
      }
    });
  }

 */
}
