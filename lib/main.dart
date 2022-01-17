import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:yardimfeneri/ChattApp/alluserModel-Helpful-Charities.dart';
import 'package:yardimfeneri/ChattApp/alluserModel-Needy-Charities.dart';
import 'package:yardimfeneri/ChattApp/alluserModelYonetici.dart';
import 'package:yardimfeneri/ChattApp/chat_view_model.dart';
import 'package:yardimfeneri/ChattApp/chat_view_model_Helpful_Charities.dart';
import 'package:yardimfeneri/ChattApp/chat_view_model_Needy_Charities.dart';
import 'package:yardimfeneri/ChattApp/chat_view_model_Yonetici.dart';
import 'package:yardimfeneri/extantion/theme_color.dart';
import 'package:yardimfeneri/locator.dart';
import 'package:yardimfeneri/servis/charities_service.dart';
import 'package:yardimfeneri/servis/helpful_service.dart';
import 'package:yardimfeneri/servis/needy_service.dart';
import 'ChattApp/alluserModel.dart';
import 'routing/navigation/navigation_service.dart';
import 'routing/navigation/navigator_route_service.dart';

Future<void> main() async {

  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  setupLocator();

  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp])
      .then((_) {
    runApp( MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => NeedyService()),
        ChangeNotifierProvider(create: (_) => CharitiesService()),
        ChangeNotifierProvider(create: (_) => HelpfulService()),
        ChangeNotifierProvider(create: (_) => AllUserViewModelHelpful()),
        ChangeNotifierProvider(create: (_) => AllUserViewModelNeedy()),
        ChangeNotifierProvider(create: (_) => ChatViewModel()),
        ChangeNotifierProvider(create: (_) => ChatViewModelNeedy()),
        ChangeNotifierProvider(create: (_) => AllUserViewModelNeedy_Charities()),
        ChangeNotifierProvider(create: (_) => AllUserViewModelHelpful_Charities()),
        ChangeNotifierProvider(create: (_) => ChatViewModelNeedy_Charities()),
        ChangeNotifierProvider(create: (_) => ChatViewModelHelpful_Charities()),
        ChangeNotifierProvider(create: (_) => ChatViewModelNeedy()),
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
