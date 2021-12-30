import 'package:flutter/material.dart';
import 'package:yardimfeneri/extantion/size_extension.dart';

class UyeKabulKart extends StatelessWidget {
  final String textSubtitle;
  final String textTitle;
  final String tarih;
  final String img;
  final VoidCallback onPressedKabul;
  final VoidCallback onPressedRed;
  final double fontSize;
  Color backcolor;


  UyeKabulKart(
      {Key key,
        this.textSubtitle,
        this.textTitle,
        this.onPressedKabul,
        this.onPressedRed,
        this.fontSize,
        this.img,
        this.tarih,
        this.backcolor,
      })
      : assert(textTitle != null ),
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return textSubtitle != null ?
    Padding(
      padding:
      EdgeInsets.symmetric(horizontal: 10.0.w, vertical: 10.0.h),
      child: Container(
        width: MediaQuery.of(context).size.width,
        height: 110.0.h,
        alignment: Alignment.center,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.all(Radius.circular(11.70.w)),
            boxShadow: [
              BoxShadow(
                  color: const Color(0x26000000),
                  offset: Offset(0, 0),
                  blurRadius: 5.50,
                  spreadRadius: 0.5)
            ],
            color: Colors.white),
        child: Column(
          children: [
            SizedBox(height: 10.0.h,),
            ListTile(
              title: Text(
                textTitle,
                style: TextStyle(
                    color: const Color(0xff343633),
                    fontWeight: FontWeight.w600,
                    fontFamily: "OpenSans",
                    fontStyle: FontStyle.normal,
                    fontSize: 16.7.h),
              ),
              leading: CircleAvatar(
                backgroundImage: NetworkImage(img),
                radius: 33.0.w,
              ),
              subtitle: Text(
                textSubtitle.toString(),
                style: TextStyle(
                    color: const Color(0xff343633),
                    fontWeight: FontWeight.w400,
                    fontFamily: "OpenSans",
                    fontStyle: FontStyle.normal,
                    fontSize: 13.3.spByWidth),
                overflow: TextOverflow.ellipsis,
              ),
            ),
            SizedBox(height: 10.0.h,),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Container(
                  width: 120.0.w,
                  height: 27.0.h,
                  child: ElevatedButton(
                    onPressed: onPressedKabul,
                    child: Text("Kabul Et"),
                    style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.all<Color>(Colors.green),
                    ),
                  ),
                ),
                Container(
                  width: 120.0.w,
                  height: 27.0.h,
                  child: ElevatedButton(
                    onPressed: onPressedRed,
                    child: Text("Reddet"),
                    style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.all<Color>(Colors.red),
                    ),
                  ),
                ),
              ],),
          ],
        ),
      ),
    ) :
    Padding(
      padding:
      EdgeInsets.symmetric(horizontal: 10.0.w, vertical: 10.0.h),
      child:  Container(
        width: MediaQuery.of(context).size.width,
        height: 100.0.h,
        alignment: Alignment.center,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.all(Radius.circular(11.70.w)),
            boxShadow: [
              BoxShadow(
                  color: const Color(0x26000000),
                  offset: Offset(0, 0),
                  blurRadius: 5.50,
                  spreadRadius: 0.5)
            ],
            color: Colors.white),
        child: Column(
          children: [
            SizedBox(height: 10.0.h,),
            ListTile(
              title: Text(
                textTitle,
                style: TextStyle(
                    color: const Color(0xff343633),
                    fontWeight: FontWeight.w600,
                    fontFamily: "OpenSans",
                    fontStyle: FontStyle.normal,
                    fontSize: 16.7.spByWidth),
              ),
              leading: CircleAvatar(
                backgroundImage: NetworkImage(img),
                radius: 40.0.w,
              ),

            ),
            SizedBox(height: 10.0.h,),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
              Container(
                width: 120.0.w,
                height: 27.0.h,
                child: ElevatedButton(
                  onPressed: onPressedKabul,
                  child: Text("Kabul Et"),
                  style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all<Color>(Colors.green),
                  ),
                ),
              ),
              Container(
                width: 120.0.w,
                height: 27.0.h,
                child: ElevatedButton(
                  onPressed: onPressedRed,
                  child: Text("Reddet"),
                  style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all<Color>(Colors.red),
                  ),
                ),
              ),
            ],),
          ],
        ),
      ),
    );
  }
}
