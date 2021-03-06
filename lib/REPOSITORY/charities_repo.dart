

import 'package:yardimfeneri/BASE/authbasecharities.dart';
import 'package:yardimfeneri/FIREBASE/auth/firebaseauthservicecharities.dart';
import 'package:yardimfeneri/FIREBASE/database/firebasedbcharities.dart';
import 'package:yardimfeneri/locator.dart';
import 'package:yardimfeneri/model/charities_model.dart';

enum AppMode { DEBUG, RELEASE }

class CharitiesRepo implements AuthBaseCharities {
  FirebaseAuthServiceCharities _firebaseAuthService = locator<FirebaseAuthServiceCharities>();

  FirestoreDBServiceCharities _firestoreDBService = locator<FirestoreDBServiceCharities>();


  AppMode appMode = AppMode.RELEASE;
  @override
  Future<CharitiesModel?> currentCharities() async {

    CharitiesModel? _user = await _firebaseAuthService.currentCharities();

    return await _firestoreDBService.readCharities(_user!.userId, _user.email.toString());

  }

  @override
  Future<bool> signOut() async {

    return await _firebaseAuthService.signOut();

  }



  @override
  Future<CharitiesModel?> createUserWithEmailandPasswordCharities(String email, String sifre,CharitiesModel users) async {
    CharitiesModel? _user = await _firebaseAuthService.createUserWithEmailandPasswordCharities(email, sifre,users);
    users.userId = _user!.userId;
    bool _sonuc = await _firestoreDBService.saveCharities(users);
    if (_sonuc) {
      return await _firestoreDBService.readCharities(_user.userId,email);
    }
  }

  @override
  Future<CharitiesModel?> signInWithEmailandPasswordCharities(String email, String sifre) async {

    CharitiesModel? _user = await _firebaseAuthService.signInWithEmailandPasswordCharities(email, sifre);

    return await _firestoreDBService.readCharities(_user!.userId,email);

  }


}