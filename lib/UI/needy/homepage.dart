import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:yardimfeneri/COMMON/myButton.dart';
import 'package:yardimfeneri/SERVICE/needy_service.dart';

class HomePageNeedy extends StatefulWidget {
  const HomePageNeedy({Key? key}) : super(key: key);

  @override
  _HomePageNeedyState createState() => _HomePageNeedyState();
}

class _HomePageNeedyState extends State<HomePageNeedy> {
  @override
  Widget build(BuildContext context) {
    final _helpfulService = Provider.of<NeedyService>(context, listen: true);
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
