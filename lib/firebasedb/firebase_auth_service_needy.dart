import 'package:firebase_auth/firebase_auth.dart';
import 'package:yardimfeneri/base_class/authbaseneedy.dart';
import 'package:yardimfeneri/model/needy_model.dart';

class FirebaseAuthServiceNeedy2 implements AuthBaseNeedy {
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
  Future<NeedyModel?> currentNeedy() async {
    try {
      User? user = await _firebaseAuth.currentUser;
      return _userFromFirebaseNeedy(user!);
    } catch (e) {
      print("HATA CURRENT USER" + e.toString());
      return null;
    }
  }

  NeedyModel? _userFromFirebaseNeedy(User? user) {
    if (user == null) {
      return null;
    } else {
      return NeedyModel(userId: user.uid);
    }
  }


  @override
  Future<NeedyModel?> createUserWithEmailandPasswordNeedy(String email, String sifre, NeedyModel users) async
  {
    UserCredential sonuc = await _firebaseAuth.createUserWithEmailAndPassword(email: email, password: sifre);
    return _userFromFirebaseNeedy(sonuc.user!);
  }

  @override
  Future<NeedyModel?> signInWithEmailandPasswordNeedy(String email, String sifre) async {
    print("sign girdi");
    UserCredential sonuc = await _firebaseAuth.signInWithEmailAndPassword(
        email: email, password: sifre);
    print("giris yapıldı");
    return _userFromFirebaseNeedy(sonuc.user!);
  }

}





