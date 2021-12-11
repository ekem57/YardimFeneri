import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:yardimfeneri/service/needy_service.dart';

class HomePageNeedy extends StatefulWidget {
  const HomePageNeedy({Key? key}) : super(key: key);

  @override
  _HomePageNeedyState createState() => _HomePageNeedyState();
}

class _HomePageNeedyState extends State<HomePageNeedy> {
  @override
  Widget build(BuildContext context) {
    final _needyService = Provider.of<NeedyService>(context, listen: true);
    return Scaffold(
      body: Center(child: Text("emre"),),
    );
  }
}
