import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:yardimfeneri/COMMON/myButton.dart';
import 'package:yardimfeneri/servis/helpful_service.dart';

class HomePageHelpful extends StatefulWidget {
  const HomePageHelpful({Key key}) : super(key: key);

  @override
  _HomePageHelpfulState createState() => _HomePageHelpfulState();
}

class _HomePageHelpfulState extends State<HomePageHelpful> {
  @override
  Widget build(BuildContext context) {
    final _helpfulService = Provider.of<HelpfulService>(context, listen: true);
    return Scaffold(
      body: Column(
        children: [
          Center(child: Text("emre"),),
          MyButton(text: "text", onPressed: (){
            _helpfulService.signOut();
          }, textColor: Colors.red, fontSize: 20, width: 80, height: 100),
        ],
      ),
    );
  }
}
