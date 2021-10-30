import 'package:flutter/material.dart';

class SizeConfig{

  final BuildContext context;
  SizeConfig(this.context);
  static double? blockWidth;
  static double? blockHeight;
  static double? screenWidth;

  void init(){
    blockWidth = MediaQuery.of(context).size.width / 100.0;
    blockHeight = MediaQuery.of(context).size.height / 100.0;
    screenWidth = MediaQuery.of(context).size.width / 360.0;
  }
  static double setWidth(double value) => value / 3.6 * blockWidth!;
  static double setHeight(double value) => value / 6.40 * blockHeight!;
  static double setTextSp(double value) => blockWidth! > .6? value / 6.40 * blockHeight!: value/3.60*blockWidth!;
  static double setTextSpWithWidth (double value) => value*screenWidth!;



}