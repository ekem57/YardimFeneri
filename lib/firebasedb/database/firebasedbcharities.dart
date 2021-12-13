import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:yardimfeneri/model/charities_model.dart';

class FirestoreDBServiceCharities {


  final FirebaseFirestore _firebaseDB = FirebaseFirestore.instance;

  @override
  Future<bool> saveCharities(CharitiesModel user) async {
    await _firebaseDB
        .collection("charities")
        .doc(user.userId)
        .set(user.toMap());
    return true;
  }

  @override
  Future<CharitiesModel> readCharities(String userID, String email) async {
    print("gelen userid read charities: "+userID.toString());
    DocumentSnapshot _okunanUser = await _firebaseDB.collection("charities").doc(userID).get();
    Map<String, dynamic> _okunanUserBilgileriMap = _okunanUser.data();
    print("okunan user: "+_okunanUserBilgileriMap.toString());
    if(_okunanUser.data != null){
      CharitiesModel _okunanUserNesnesi;
      _okunanUserNesnesi = CharitiesModel.fromMap(_okunanUserBilgileriMap);
      print("Okunan user nesnesi :" + _okunanUserNesnesi.toString());
      return _okunanUserNesnesi;
    }else{
      return null;
    }

  }


}