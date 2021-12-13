import 'package:yardimfeneri/COMMON/myButton.dart';
import 'package:flutter/material.dart';
import 'package:yardimfeneri/extantion/application_colors.dart';
import 'package:yardimfeneri/extantion/size_extension.dart';


class CustomAlertDialog extends StatelessWidget {
  final Color bgColor;
  final Color positiveButonColor = Appcolors.onayButonColor;
  final Color negativeButonColor = Appcolors.reddetButonColor;
  final String title;
  final String message;
  final String positiveBtnText;
  final String negativeBtnText;
  final Function onPostivePressed;
  final Function onNegativePressed;
  final double circularBorderRadius;

  CustomAlertDialog(this.bgColor, this.title, this.message, this.positiveBtnText, this.negativeBtnText, this.onPostivePressed, this.onNegativePressed, this.circularBorderRadius);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: AlertDialog(
        title: title != null ? Text(title) : null,
        content: message != null
            ? Padding(
                padding: EdgeInsets.only(top: 30.0.h),
                child: Text(
                  message,
                  style: TextStyle(
                    fontSize: 15.0.spByWidth,
                    fontWeight: FontWeight.w600,
                    fontFamily: "OpenSans",
                      height: 2.0.h,
                  ),
                  textAlign: TextAlign.center,
                ),
              )
            : null,
        backgroundColor: bgColor,
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(circularBorderRadius)),
        actions: <Widget>[

          Padding(
            padding:  EdgeInsets.symmetric(horizontal: 40.0.w,vertical: 20.0.h),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Center(
                  child: MyButton(
                      text: positiveBtnText,
                      onPressed: onPostivePressed(),
                      butonColor: positiveButonColor,
                      textColor: Colors.black,
                      fontSize: 12.3.spByWidth,
                      width: 83.0.w,
                      height: 29.0.h),
                ),
                SizedBox(width: 10.0.w,),
                Center(
                  child: MyButton(
                      text: negativeBtnText,
                      butonColor: negativeButonColor,
                      onPressed: () {
                        Navigator.of(context).pop();
                        if (onNegativePressed != null) {
                          onNegativePressed();
                        }
                      },
                      fontSize: 12.3.spByWidth,
                      width: 83.0.w,
                      height: 29.0.h, textColor: Appcolors.appbarButonColor,)
                ),
              ],
            ),
          ),


        ],
      ),
    );
  }
}
