import 'package:flutter/material.dart';
import 'package:yardimfeneri/extantion/size_extension.dart';

class ResimliCard extends StatelessWidget {
  final String? textSubtitle;
  final String textTitle;
  final String? tarih;
  final String img;
  final VoidCallback onPressed;
  final double fontSize;
  Color? backcolor;


  ResimliCard(
      {Key? key,
        required this.textSubtitle,
        required this.textTitle,
        required this.onPressed,
        required this.fontSize,
        required this.img,
        required this.tarih,
        this.backcolor,
      })
      : assert(textTitle != null ),
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return textSubtitle != null ?
    Padding(
      padding:
      EdgeInsets.symmetric(horizontal: 21.0.w, vertical: 7.0.h),
      child: GestureDetector(
        onTap: onPressed,
        child: Container(
          width: MediaQuery.of(context).size.width,
          height: 60.0.h,
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
              color: backcolor == null ? Theme.of(context).backgroundColor : this.backcolor),
          child: ListTile(
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
            trailing: Padding(
              padding: EdgeInsets.only(top: 34.0.h),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Text(
                    tarih.toString(),
                    style: TextStyle(
                        color: const Color(0xff343633),
                        fontWeight: FontWeight.w400,
                        fontFamily: "Arial",
                        fontStyle: FontStyle.normal,
                        fontSize: 12.3.spByWidth),
                  ),
                ],
              ),
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
        ),
      ),
    ) :
    Padding(
      padding:
      EdgeInsets.symmetric(horizontal: 21.0.w, vertical: 2.0.h),
      child:  GestureDetector(
        onTap: onPressed,
        child: Container(
          width: MediaQuery.of(context).size.width,
          height: 60.0.h,
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
          child: ListTile(
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
              radius: 33.0.w,
            ),


          ),
        ),
      ),
    );
  }
}
