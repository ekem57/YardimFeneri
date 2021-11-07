import 'package:yardimfeneri/BASE/authbasehelpful.dart';
import 'package:yardimfeneri/FIREBASE/auth/firebaseauthservicehelpful.dart';
import 'package:yardimfeneri/FIREBASE/database/firebasedbhelpful.dart';
import 'package:yardimfeneri/locator.dart';
import 'package:yardimfeneri/model/helpful_model.dart';

enum AppMode { DEBUG, RELEASE }

class HelpfulRepo implements AuthBaseHelpful {
  FirebaseAuthServiceHelpful _firebaseAuthService = locator<FirebaseAuthServiceHelpful>();

  FirestoreDBServiceHelpful _firestoreDBService = locator<FirestoreDBServiceHelpful>();


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

}