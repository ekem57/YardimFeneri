import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:yardimfeneri/EXTENSIONS/theme.dart';
import 'package:yardimfeneri/ROUTING/navigation/navigator_route_service.dart';
import 'package:yardimfeneri/SERVICE/charities_service.dart';
import 'package:yardimfeneri/SERVICE/helpful_service.dart';
import 'package:yardimfeneri/SERVICE/needy_service.dart';
import 'package:yardimfeneri/locator.dart';
import 'ROUTING/navigation/navigation_service.dart';

Future<void> main() async {

  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  setupLocator();

  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp])
      .then((_) {
    runApp( MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => NeedyService()),
        ChangeNotifierProvider(create: (_) => HelpfulService()),
        ChangeNotifierProvider(create: (_) => CharitiesService()),
      ],
      child: MyApp(),
    ));
  });
}


class MyApp extends StatefulWidget {
  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'YardımFeneri',
      initialRoute: '/splash',
      theme: myTheme,
      onGenerateRoute: (settings) =>
          NavigationRouteManager.onRouteGenerate(settings),
      navigatorKey: NavigationService.instance.navigatorKey,
    );
  }
}
