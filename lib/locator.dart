import 'package:get_it/get_it.dart';
import 'package:yardimfeneri/FIREBASE/auth/firebaseauthservicecharities.dart';
import 'package:yardimfeneri/FIREBASE/auth/firebaseauthservicehelpful.dart';
import 'package:yardimfeneri/FIREBASE/auth/firebaseauthserviceneedy.dart';
import 'package:yardimfeneri/FIREBASE/database/firebasedbcharities.dart';
import 'package:yardimfeneri/FIREBASE/database/firebasedbhelpful.dart';
import 'package:yardimfeneri/FIREBASE/database/firebasedbneedy.dart';
import 'package:yardimfeneri/REPOSITORY/charities_repo.dart';
import 'package:yardimfeneri/REPOSITORY/helpfulrepo.dart';
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
  locator.registerLazySingleton(() => NeedyRepo());
}