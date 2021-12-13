import 'package:yardimfeneri/model/needy_model.dart';

abstract class AuthBaseNeedy{

  Future<NeedyModel> currentNeedy();

  Future<NeedyModel> signInWithEmailandPasswordNeedy(String email, String sifre);

  Future<NeedyModel> createUserWithEmailandPasswordNeedy(String email, String sifre,NeedyModel users);

  Future<bool> signOut();

}