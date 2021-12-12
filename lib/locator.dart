import 'package:get_it/get_it.dart';
import 'package:yardimfeneri/firebase/auth/firebaseauthservicecharities.dart';
import 'package:yardimfeneri/firebase/auth/firebaseauthservicehelpful.dart';
import 'package:yardimfeneri/firebase/auth/firebaseauthserviceneedy.dart';
import 'package:yardimfeneri/firebase/database/firebasedbcharities.dart';
import 'package:yardimfeneri/firebase/database/firebasedbhelpful.dart';
import 'package:yardimfeneri/firebase/database/firebasedbneedy.dart';
import 'REPOSITORY/charities_repo.dart';
import 'REPOSITORY/helpfulrepo.dart';
import 'package:yardimfeneri/REPOSITORY/needyrepo.dart';


GetIt locator = GetIt.instance;

void setupLocator() {

  locator.registerLazySingleton(() => FirebaseAuthServiceCharities());
  locator.registerLazySingleton(() => FirestoreDBServiceCharities());
  locator.registerLazySingleton(() => CharitiesRepo());
  locator.registerLazySingleton(() => FirebaseAuthServiceHelpful());
  locator.registerLazySingleton(() => FirestoreDBServiceHelpful());
  locator.registerLazySingleton(() => HelpfulRepo());
  locator.registerLazySingleton(() => FirebaseAuthServiceNeedy());
  locator.registerLazySingleton(() => FirestoreDBServiceNeedy());
}