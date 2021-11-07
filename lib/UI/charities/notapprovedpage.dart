import 'package:flutter/material.dart';

class NotApprovedPageCharities extends StatelessWidget {
  const NotApprovedPageCharities({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Center(child: Text("HESAP ONAYLANMADI"),),
        ],
      ),
    );
  }
}
