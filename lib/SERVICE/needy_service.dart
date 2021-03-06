import 'package:flutter/material.dart';
import 'package:yardimfeneri/BASE/authbasecharities.dart';
import 'package:yardimfeneri/BASE/authbasehelpful.dart';
import 'package:yardimfeneri/BASE/authbaseneedy.dart';
import 'package:yardimfeneri/REPOSITORY/charities_repo.dart';
import 'package:yardimfeneri/REPOSITORY/helpfulrepo.dart';
import 'package:yardimfeneri/REPOSITORY/needyrepo.dart';
import 'package:yardimfeneri/locator.dart';
import 'package:yardimfeneri/model/charities_model.dart';
import 'package:yardimfeneri/model/helpful_model.dart';
import 'package:yardimfeneri/model/needy_model.dart';


enum NeedyViewState { Idle, Busy }

class NeedyService with ChangeNotifier implements AuthBaseNeedy {
  NeedyViewState _state = NeedyViewState.Idle;
  NeedyRepo _userRepository = locator<NeedyRepo>();
  NeedyModel? _user;

  NeedyModel? get user => _user;

  NeedyViewState get state => _state;

  set state(NeedyViewState value) {
    _state = value;
    notifyListeners();
  }

  HelpfulService() {
    currentNeedy();
  }



  @override
  Future<bool> signOut() async {
    try {
      state = NeedyViewState.Busy;
      bool sonuc = await _userRepository.signOut();
      _user = null;
      return sonuc;
    } catch (e) {
      return false;
    } finally {
      state = NeedyViewState.Idle;
    }
  }

  @override
  Future<NeedyModel?> createUserWithEmailandPasswordNeedy(String email, String sifre, NeedyModel users) async {
    try {
      _user = await _userRepository.createUserWithEmailandPasswordNeedy(email, sifre,users);
      return _user;
    } finally {
      state = NeedyViewState.Idle;
    }
  }

  @override
  Future<NeedyModel?> currentNeedy() async {
    try {
      state = NeedyViewState.Busy;
      _user = await _userRepository.currentNeedy();
      if (_user != null)
        return _user!;
    } catch (e) {
      return null!;
    } finally {
      state = NeedyViewState.Idle;
    }
  }

  @override
  Future<NeedyModel?> signInWithEmailandPasswordNeedy(String email, String sifre) async {
    try {

      _user = await _userRepository.signInWithEmailandPasswordNeedy(email, sifre);
      return _user!;

    } finally {
      state = NeedyViewState.Idle;
    }
  }



}