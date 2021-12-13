import 'dart:async';
import 'package:flutter/material.dart';
import 'package:yardimfeneri/locator.dart';
import 'package:yardimfeneri/model/helpful_model.dart';
import 'package:yardimfeneri/model/mesaj.dart';
import 'package:yardimfeneri/model/needy_model.dart';
import 'package:yardimfeneri/repo/needyrepo.dart';


enum ChatViewStateYonetici { Idle, Loaded, Busy }

class ChatViewModelYonetici with ChangeNotifier {
  List<Mesaj>? _tumMesajlar;
  ChatViewStateYonetici? _state = ChatViewStateYonetici.Idle;
  static final sayfaBasinaGonderiSayisi = 20;
  NeedyRepo _userRepository = locator<NeedyRepo>();
  final NeedyModel? currentUser;
  final HelpfulModel? sohbetEdilenUser;
  Mesaj? _enSonGetirilenMesaj;
  Mesaj? _listeyeEklenenIlkMesaj;
  bool _hasMore = true;
  bool _yeniMesajDinleListener = false;
  List<Mesaj>? _tumMesajlarTers;
  bool get hasMoreLoading => _hasMore;

  StreamSubscription? _streamSubscription;

  ChatViewModelYonetici({required this.currentUser, required this.sohbetEdilenUser}) {
    _tumMesajlar = [];
    _tumMesajlarTers=[];
  }

  List<Mesaj> get mesajlarListesi => _tumMesajlar!;
  List<Mesaj> get mesajlarListesiTers => _tumMesajlarTers!;
  ChatViewStateYonetici get state => _state!;

  set state(ChatViewStateYonetici value) {
    _state = value;
    notifyListeners();
  }

  @override
  dispose() {
    print("Chatviewmodel dispose edildi");
    _streamSubscription!.cancel();
    super.dispose();
  }

  Future<bool> saveMessage(Mesaj kaydedilecekMesaj, NeedyModel? currentUser) async {
    return await _userRepository.saveMessage(kaydedilecekMesaj, currentUser);
  }




}
