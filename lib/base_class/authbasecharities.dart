import 'package:yardimfeneri/model/charities_model.dart';

abstract class AuthBaseCharities{

  Future<CharitiesModel> currentCharities();

  Future<CharitiesModel> signInWithEmailandPasswordCharities(String email, String sifre);

  Future<CharitiesModel> createUserWithEmailandPasswordCharities(String email, String sifre,CharitiesModel users);

  Future<bool> signOut();

}