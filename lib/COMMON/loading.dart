import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:etkinlik_kafasi/extensions/size_extension.dart';

class Loading extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      child: Center(
        child: SpinKitChasingDots(
          color: Theme.of(context).primaryColor,
          size: 50.0.w,
        ),
      ),
    );
  }
}
