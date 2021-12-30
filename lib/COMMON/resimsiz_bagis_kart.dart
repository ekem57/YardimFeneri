import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:yardimfeneri/extantion/size_extension.dart';

class ResimsizBagisCard extends StatelessWidget {
  final String bagisyapan;
  final String bagisyapilankampanya;
  final String iletisim;
  final String bagismiktar;
  final String mesaj;
  final VoidCallback onPressed;


  const ResimsizBagisCard(
      {Key key,
        this.bagisyapan,
        this.bagisyapilankampanya,
        this.iletisim,
        this.bagismiktar,
        this.mesaj,
        this.onPressed,
      })
      : assert(bagisyapan != null ),
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 21.0.w,vertical: 10.0.h),
      child:  GestureDetector(
        onTap: onPressed,
        child: Container(
          width: MediaQuery.of(context).size.width,
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
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 20.0.h,),
              Padding(
                padding: EdgeInsets.only(left: 20.0.w),
                child: Align(
                  alignment: Alignment.topLeft,
                  child: Text(
                    bagisyapan,
                    textAlign: TextAlign.left,
                    style: TextStyle(
                        color: const Color(0xff343633),
                        fontWeight: FontWeight.bold,
                        fontFamily: "OpenSans",
                        fontStyle: FontStyle.italic,
                        fontSize: 16.7.spByWidth),
                  ),
                ),
              ),
              SizedBox(height: 15.0.h,),
              Row(
                children: [

                  Padding(
                    padding: EdgeInsets.only(left: 20.0.w),
                    child: Align(
                      alignment: Alignment.topLeft,
                      child: Text(
                        "Bağış Miktarı : ",
                        textAlign: TextAlign.left,
                        style: TextStyle(
                            color: const Color(0xff343633),
                            fontWeight: FontWeight.bold,
                            fontFamily: "OpenSans",
                            fontStyle: FontStyle.italic,
                            fontSize: 16.7.spByWidth),
                      ),
                    ),
                  ),
                  SizedBox(height: 15.0.h,),
                  Align(
                    alignment: Alignment.topRight,
                    child: Text(
                      bagismiktar+" ₺",
                      textAlign: TextAlign.left,
                      style: TextStyle(
                          color: const Color(0xff343633),
                          fontWeight: FontWeight.w600,
                          fontFamily: "OpenSans",
                          fontStyle: FontStyle.normal,
                          fontSize: 16.7.spByWidth),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 15.0.h,),
              Column(
                children: [

                  Padding(
                    padding: EdgeInsets.only(left: 20.0.w),
                    child: Align(
                      alignment: Alignment.topLeft,
                      child: Text(
                        "Bağış Yapılan Kampanya: ",
                        textAlign: TextAlign.left,
                        style: TextStyle(
                            color: const Color(0xff343633),
                            fontWeight: FontWeight.bold,
                            fontFamily: "OpenSans",
                            fontStyle: FontStyle.italic,
                            fontSize: 16.7.spByWidth),
                      ),
                    ),
                  ),
                  SizedBox(height: 10.0.h,),
                  Padding(
                    padding:  EdgeInsets.symmetric(horizontal: 20.0.w),
                    child: Align(
                      alignment: Alignment.topLeft,
                      child: Text(
                        bagisyapilankampanya,
                        textAlign: TextAlign.left,
                        maxLines: 2,
                        style: TextStyle(
                            color: Colors.red,
                            fontWeight: FontWeight.w600,
                            fontFamily: "OpenSans",
                            fontStyle: FontStyle.normal,
                            fontSize: 16.7.spByWidth),
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 10.0.h,),
              Padding(
                padding:  EdgeInsets.all(20.0.h),
                child: Align(
                  alignment: Alignment.topLeft,
                  child: Text(
                    mesaj,
                    textAlign: TextAlign.left,
                    style: TextStyle(
                        color: const Color(0xff343633),
                        fontWeight: FontWeight.w600,
                        fontFamily: "OpenSans",
                        fontStyle: FontStyle.normal,
                        fontSize: 16.7.spByWidth),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );

  }
}
