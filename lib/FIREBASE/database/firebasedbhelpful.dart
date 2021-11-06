import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:yardimfeneri/model/helpful_model.dart';

class FirestoreDBServiceHelpful {


  final FirebaseFirestore _firebaseDB = FirebaseFirestore.instance;

  @override
  Future<bool> saveHelpful(HelpfulModel user) async {
    await _firebaseDB
        .collection("ogrenci")
        .doc(user.userId)
        .set(user.toMap());
    return true;
  }

  @override
  Future<HelpfulModel> readHelpful(String userID, String email) async {
    DocumentSnapshot _okunanUser = await _firebaseDB.collection("ogrenci").doc(userID).get();
    Map<String, dynamic>? _okunanUserBilgileriMap = _okunanUser.data() as Map<String, dynamic>?;
    if(_okunanUser.data!=null){
      HelpfulModel _okunanUserNesnesi;
      _okunanUserNesnesi = HelpfulModel.fromMap(_okunanUserBilgileriMap!);
      print("Okunan user nesnesi :" + _okunanUserNesnesi.toString());
      return _okunanUserNesnesi;
    }else{
      return null!;
    }

  }


}