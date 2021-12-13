

import 'package:yardimfeneri/BASE/authbasecharities.dart';
import 'package:yardimfeneri/BASE/authbaseneedy.dart';
import 'package:yardimfeneri/FIREBASE/auth/firebaseauthservicecharities.dart';
import 'package:yardimfeneri/FIREBASE/auth/firebaseauthserviceneedy.dart';
import 'package:yardimfeneri/FIREBASE/database/firebasedbcharities.dart';
import 'package:yardimfeneri/FIREBASE/database/firebasedbneedy.dart';
import 'package:yardimfeneri/locator.dart';
import 'package:yardimfeneri/model/charities_model.dart';
import 'package:yardimfeneri/model/needy_model.dart';

enum AppMode { DEBUG, RELEASE }

class NeedyRepo implements AuthBaseNeedy {
  FirebaseAuthServiceNeedy _firebaseAuthService = locator<FirebaseAuthServiceNeedy>();

  FirestoreDBServiceNeedy _firestoreDBService = locator<FirestoreDBServiceNeedy>();


  AppMode appMode = AppMode.RELEASE;
  @override
  Future<NeedyModel?> currentNeedy() async {
    print("object needy");
    NeedyModel? _user = await _firebaseAuthService.currentNeedy();

    return await _firestoreDBService.readNeedy(_user!.userId, _user.email.toString());

  }

  @override
  Future<bool> signOut() async {

    return await _firebaseAuthService.signOut();

  }



  @override
  Future<NeedyModel?> createUserWithEmailandPasswordNeedy(String email, String sifre,NeedyModel users) async {
    NeedyModel? _user = await _firebaseAuthService.createUserWithEmailandPasswordNeedy(email, sifre,users);
    users.userId = _user!.userId;
    bool _sonuc = await _firestoreDBService.saveNeedy(users);
    if (_sonuc) {
      return await _firestoreDBService.readNeedy(_user.userId,email);
    }
  }

  @override
  Future<NeedyModel?> signInWithEmailandPasswordNeedy(String email, String sifre) async {

    NeedyModel? _user = await _firebaseAuthService.signInWithEmailandPasswordNeedy(email, sifre);

    return await _firestoreDBService.readNeedy(_user!.userId,email);

  }


}