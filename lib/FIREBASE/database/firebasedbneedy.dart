import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:yardimfeneri/model/charities_model.dart';
import 'package:yardimfeneri/model/needy_model.dart';

class FirestoreDBServiceNeedy {


  final FirebaseFirestore _firebaseDB = FirebaseFirestore.instance;

  @override
  Future<bool> saveNeedy(NeedyModel user) async {
    await _firebaseDB
        .collection("needy")
        .doc(user.userId)
        .set(user.toMap());
    return true;
  }

  @override
  Future<NeedyModel> readNeedy(String? userID, String? email) async {
    print("gelen userid read charities: "+userID.toString());
    DocumentSnapshot<Map<String, dynamic>> _okunanUser = await _firebaseDB.collection("needy").doc(userID).get();
    Map<String, dynamic>? _okunanUserBilgileriMap = _okunanUser.data();
    print("okunan user: "+_okunanUserBilgileriMap.toString());
    if(_okunanUser.data != null){
      NeedyModel _okunanUserNesnesi;
      _okunanUserNesnesi = NeedyModel.fromMap(_okunanUserBilgileriMap!);
      print("Okunan user nesnesi :" + _okunanUserNesnesi.toString());
      return _okunanUserNesnesi;
    }else{
      return null!;
    }
  }


}