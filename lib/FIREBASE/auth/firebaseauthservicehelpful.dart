import 'package:firebase_auth/firebase_auth.dart';
import 'package:yardimfeneri/BASE/authbasehelpful.dart';
import 'package:yardimfeneri/model/helpful_model.dart';

class FirebaseAuthServiceHelpful implements AuthBaseHelpful {
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;

  @override
  Future<bool> signOut() async {
    try {
      await _firebaseAuth.signOut();
      return true;
    } catch (e) {
      print("sign out hata:" + e.toString());
      return false;
    }
  }


  @override
  Future<HelpfulModel?> currentHelpful() async {
    try {
      User? user = await _firebaseAuth.currentUser;
      return _userFromFirebaseCharities(user!);
    } catch (e) {
      print("HATA CURRENT USER" + e.toString());
      return null;
    }
  }

  HelpfulModel? _userFromFirebaseCharities(User? user) {
    if (user == null) {
      return null;
    } else {
      return HelpfulModel(userId: user.uid);
    }
  }


  @override
  Future<HelpfulModel?> createUserWithEmailandPasswordHelpful(String email, String sifre, HelpfulModel users) async
  {
    UserCredential sonuc = await _firebaseAuth.createUserWithEmailAndPassword(email: email, password: sifre);
    return _userFromFirebaseCharities(sonuc.user!);
  }

  @override
  Future<HelpfulModel?> signInWithEmailandPasswordHelpful(String email, String sifre) async {
    print("sign girdi");
    UserCredential sonuc = await _firebaseAuth.signInWithEmailAndPassword(
        email: email, password: sifre);
    print("giris yapıldı");
    return _userFromFirebaseCharities(sonuc.user!);
  }



}





