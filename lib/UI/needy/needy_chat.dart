import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:yardimfeneri/SERVICE/needy_service.dart';

class NeedyChat extends StatefulWidget {
  const NeedyChat({Key? key}) : super(key: key);

  @override
  _NeedyChatState createState() => _NeedyChatState();
}

class _NeedyChatState extends State<NeedyChat> {
  @override
  Widget build(BuildContext context) {
    final _needyService = Provider.of<NeedyService>(context, listen: true);
    return Scaffold(
      body: Center(child: Text("emre"),),
    );
  }
}
