import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:yardimfeneri/service/needy_service.dart';

class ProfilNeedy extends StatefulWidget {
  const ProfilNeedy({Key? key}) : super(key: key);

  @override
  _ProfilNeedyState createState() => _ProfilNeedyState();
}

class _ProfilNeedyState extends State<ProfilNeedy> {
  @override
  Widget build(BuildContext context) {
    final _needyService = Provider.of<NeedyService>(context, listen: true);
    return Scaffold(
      body: Center(child: Text("emre"),),
    );
  }
}
