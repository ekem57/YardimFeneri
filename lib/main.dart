import 'package:flutter/material.dart';
import 'package:yardimfeneri/EXTENSIONS/size_config.dart';
import 'package:yardimfeneri/EXTENSIONS/theme.dart';
import 'package:yardimfeneri/ROUTING/navigation/navigator_route_service.dart';
import 'ROUTING/navigation/navigation_service.dart';

void main() {
  runApp(MyApp());

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
