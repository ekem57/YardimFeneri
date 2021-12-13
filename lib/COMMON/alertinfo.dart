import 'package:flutter/material.dart';
import 'package:yardimfeneri/extantion/size_extension.dart';
import 'myButton.dart';


class AlertBilgilendirme extends StatefulWidget {
  final Color bgColor;
  final String baslik;
  final String icerik;
  final String BtnText;
  VoidCallback Pressed;
   double circularBorderRadius;

  AlertBilgilendirme({
    this.baslik,
    this.icerik,
    this.circularBorderRadius = 15.0,
    this.bgColor = Colors.white,
    this.BtnText,
    this.Pressed,
  })  : assert(bgColor != null),
        assert(circularBorderRadius != null);

  @override
  _AlertBilgilendirmeState createState() => _AlertBilgilendirmeState();
}

class _AlertBilgilendirmeState extends State<AlertBilgilendirme> {
  final Color positiveButonColor = Colors.green;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: AlertDialog(
        title: widget.baslik != null ? Text(widget.baslik) : null,
        content: widget.icerik != null
            ? Padding(
          padding:
          EdgeInsets.only(top: 30.0.h),
          child: Text(
            widget.icerik,
            style: TextStyle(
              fontSize: 18.0.spByWidth,
              fontWeight: FontWeight.w600,
              fontFamily: "OpenSans",
              height: 2,
            ),
            textAlign: TextAlign.center,
          ),
        )
            : null,
        backgroundColor: widget.bgColor,
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(widget.circularBorderRadius)),
        actions: <Widget>[

          Padding(
            padding:  EdgeInsets.symmetric(horizontal: 50.0.w,vertical: 4.0.h),
            child: Center(
              child: MyButton(
                  text: "Tamam",
                  onPressed: widget.Pressed,
                  butonColor: positiveButonColor,
                  textColor: Colors.black,
                  fontSize: 12.3.spByWidth,
                  width: 180.0.w,
                  height: 29.0.h),
            ),
          ),


        ],
      ),
    );
  }
}
