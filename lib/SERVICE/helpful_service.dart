import 'package:flutter/material.dart';
import 'package:yardimfeneri/base/authbasehelpful.dart';
import 'package:yardimfeneri/locator.dart';
import 'package:yardimfeneri/model/helpful_model.dart';
import 'package:yardimfeneri/repository/helpfulrepo.dart';

enum HelpfulViewState { Idle, Busy }

class HelpfulService with ChangeNotifier implements AuthBaseHelpful {
  HelpfulViewState _state = HelpfulViewState.Idle;
  HelpfulRepo _userRepository = locator<HelpfulRepo>();
  HelpfulModel? _user;

  HelpfulModel? get user => _user;

  HelpfulViewState get state => _state;

  set state(HelpfulViewState value) {
    _state = value;
    notifyListeners();
  }

  HelpfulService() {
    currentHelpful();
  }



  @override
  Future<bool> signOut() async {
    try {
      state = HelpfulViewState.Busy;
      bool sonuc = await _userRepository.signOut();
      _user = null;
      return sonuc;
    } catch (e) {
      return false;
    } finally {
      state = HelpfulViewState.Idle;
    }
  }

  @override
  Future<HelpfulModel?> createUserWithEmailandPasswordHelpful(String email, String sifre, HelpfulModel users) async {
    try {
      _user = await _userRepository.createUserWithEmailandPasswordHelpful(email, sifre,users);
      return _user;
    } finally {
      state = HelpfulViewState.Idle;
    }
  }

  @override
  Future<HelpfulModel?> currentHelpful() async {
    try {
      state = HelpfulViewState.Busy;
      _user = await _userRepository.currentHelpful();
      if (_user != null)
        return _user!;
    } catch (e) {
      return null;
    } finally {
      state = HelpfulViewState.Idle;
    }
  }

  @override
  Future<HelpfulModel?> signInWithEmailandPasswordHelpful(String email, String sifre) async {
    try {

      _user = await _userRepository.signInWithEmailandPasswordHelpful(email, sifre);
      return _user!;

    } finally {
      state = HelpfulViewState.Idle;
    }
  }


}