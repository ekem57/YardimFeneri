import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:yardimfeneri/COMMON/myButton.dart';
import 'package:yardimfeneri/servis/helpful_service.dart';

class ProfilPageHelpful extends StatefulWidget {
  const ProfilPageHelpful({Key key}) : super(key: key);

  @override
  _ProfilPageHelpfulState createState() => _ProfilPageHelpfulState();
}

class _ProfilPageHelpfulState extends State<ProfilPageHelpful> {
  @override
  Widget build(BuildContext context) {
    final _helpfulService = Provider.of<HelpfulService>(context, listen: true);
    return Scaffold(
      body: Column(
        children: [
          Center(child: Text("EMRE"),),

        ],
      ),
    );
  }
}
