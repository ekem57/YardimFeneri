import 'package:yardimfeneri/model/helpful_model.dart';

abstract class AuthBaseHelpful{

  Future<HelpfulModel?> currentHelpful();

  Future<HelpfulModel?> signInWithEmailandPasswordHelpful(String email, String sifre);

  Future<HelpfulModel?> createUserWithEmailandPasswordHelpful(String email, String sifre,HelpfulModel users);

  Future<bool> signOut();

}