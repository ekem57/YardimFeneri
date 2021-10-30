import 'package:flutter/material.dart';
import 'package:yardimfeneri/EXTENSIONS/size_config.dart';

extension ResponsiveSize on double{
  double get w => SizeConfig.setWidth(this);
  double get h => SizeConfig.setHeight(this);
  double get sp => SizeConfig.setTextSp(this);
  double get spByWidth => SizeConfig.setTextSpWithWidth(this);
}


