import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:yardimfeneri/COMMON/myButton.dart';
import 'package:yardimfeneri/SERVICE/needy_service.dart';

class NotApprovedPageNeedy extends StatelessWidget {
  const NotApprovedPageNeedy({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final _needyService = Provider.of<NeedyService>(context, listen: true);

    return Scaffold(
      body: Column(
        children: [
          Center(child: Text("HESAP ONAYLANMADI"),),
          MyButton(text: "text", onPressed: (){
            _needyService.signOut();
          }, textColor: Colors.red, fontSize: 20, width: 80, height: 100),
        ],
      ),
    );
  }
}
