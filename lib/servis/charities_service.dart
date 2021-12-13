import 'package:flutter/material.dart';
import 'package:yardimfeneri/base_class/authbasecharities.dart';
import 'package:yardimfeneri/locator.dart';
import 'package:yardimfeneri/model/charities_model.dart';
import 'package:yardimfeneri/repo/charities_repo.dart';


enum CharitiesViewState { Idle, Busy }

class CharitiesService with ChangeNotifier implements AuthBaseCharities {
  CharitiesViewState _state = CharitiesViewState.Idle;
  CharitiesRepo _userRepository = locator<CharitiesRepo>();
  CharitiesModel? _user;

  CharitiesModel? get user => _user;

  CharitiesViewState get state => _state;

  set state(CharitiesViewState value) {
    _state = value;
    notifyListeners();
  }

  CharitiesService() {
    currentCharities();
  }



  @override
  Future<bool> signOut() async {
    try {
      state = CharitiesViewState.Busy;
      bool sonuc = await _userRepository.signOut();
      _user = null;
      return sonuc;
    } catch (e) {
      return false;
    } finally {
      state = CharitiesViewState.Idle;
    }
  }

  @override
  Future<CharitiesModel?> createUserWithEmailandPasswordCharities(String email, String sifre, CharitiesModel users) async {
    try {
      _user = await _userRepository.createUserWithEmailandPasswordCharities(email, sifre,users);
      return _user;
    } finally {
      state = CharitiesViewState.Idle;
    }
  }

  @override
  Future<CharitiesModel?> currentCharities() async {
    try {
      print("service charities");
      state = CharitiesViewState.Busy;
      _user = await _userRepository.currentCharities();
      if (_user != null)
        return _user!;
    } catch (e) {
      return null;
    } finally {
      state = CharitiesViewState.Idle;
    }
  }


  @override
  Future<CharitiesModel?> signInWithEmailandPasswordCharities(String email, String sifre) async {
    try {

      _user = await _userRepository.signInWithEmailandPasswordCharities(email, sifre);
      return _user!;

    } finally {
      state = CharitiesViewState.Idle;
    }
  }


}