


import 'package:get_it/get_it.dart';
import 'package:yardimfeneri/firebasedb/auth/firebaseauthservicecharities.dart';
import 'package:yardimfeneri/firebasedb/auth/firebaseauthservicehelpful.dart';
import 'package:yardimfeneri/firebasedb/database/firebasedbcharities.dart';
import 'package:yardimfeneri/firebasedb/database/firebasedbhelpful.dart';
import 'package:yardimfeneri/repo/charities_repo.dart';
import 'package:yardimfeneri/repo/helpfulrepo.dart';
import 'package:yardimfeneri/repo/needyrepo.dart';
import 'firebasedb/auth/firebaseauthserviceneedy.dart';
import 'firebasedb/database/firebasedbneedy.dart';
import 'firebasedb/db/firebase_db_needy.dart';
import 'firebasedb/firebase_auth_service_needy.dart';

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
  locator.registerLazySingleton(() => FirebaseAuthServiceNeedy2());
  locator.registerLazySingleton(() => FirestoreDBServiceNeedy2());

}