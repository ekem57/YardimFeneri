import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:yardimfeneri/service/needy_service.dart';

class YardimTalebindeBulunma extends StatefulWidget {
  const YardimTalebindeBulunma({Key? key}) : super(key: key);

  @override
  _YardimTalebindeBulunmaState createState() => _YardimTalebindeBulunmaState();
}

class _YardimTalebindeBulunmaState extends State<YardimTalebindeBulunma> {
  @override
  Widget build(BuildContext context) {
    final _needyService = Provider.of<NeedyService>(context, listen: true);
    return Scaffold(
      body: Center(child: Text("emre"),),
    );
  }
}
