import 'package:firebase_auth/firebase_auth.dart';
import 'package:yardimfeneri/base_class/authbasecharities.dart';
import 'package:yardimfeneri/model/charities_model.dart';

class FirebaseAuthServiceCharities implements AuthBaseCharities {
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
  Future<CharitiesModel?> currentCharities() async {
    try {
      User? user = await _firebaseAuth.currentUser;
      return _userFromFirebaseCharities(user!);
    } catch (e) {
      print("HATA CURRENT USER" + e.toString());
      return null;
    }
  }

  CharitiesModel? _userFromFirebaseCharities(User? user) {
    if (user == null) {
      return null;
    } else {
      return CharitiesModel(userId: user.uid);
    }
  }


  @override
  Future<CharitiesModel?> createUserWithEmailandPasswordCharities(String email, String sifre, CharitiesModel users) async
  {
    UserCredential sonuc = await _firebaseAuth.createUserWithEmailAndPassword(email: email, password: sifre);
    return _userFromFirebaseCharities(sonuc.user!);
  }

  @override
  Future<CharitiesModel?> signInWithEmailandPasswordCharities(String email, String sifre) async {
    print("sign girdi");
    UserCredential sonuc = await _firebaseAuth.signInWithEmailAndPassword(
        email: email, password: sifre);
    print("giris yapıldı");
    return _userFromFirebaseCharities(sonuc.user!);
  }

}





