import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:yardimfeneri/CONSTANTS/background_color.dart';
import 'package:yardimfeneri/UI/sign_in/common_sign_in.dart';


class SignInPage extends StatefulWidget {


  @override
  _SignInPageState createState() => _SignInPageState();
}



class _SignInPageState extends State<SignInPage> {
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
       arkaPlan(context),
        Center(
            child: Column(
              children: [
                SizedBox(height: 250,),
                Container(
                  child: Text("LOGO",style: TextStyle(color:Colors.black),),
                ),
                SizedBox(height: 150,),
                Container(
                  child: Text("YARDIM FENERİ",style: TextStyle(
                    color: Colors.black,
                    fontSize: 30,
                  ),
                  ),
                ),
                SizedBox(height: 100,),

                // !!!!!!!!!!!!!!!!!!!!!!!!!!!!1
                InkWell(
                  onTap: () {
                    Navigator.push(context, CupertinoPageRoute(builder:(context) => CommonSignIn(getButtonText: "kurulus",)));
                  },
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: specialButton("Yardım Kuruluşları Girişi"),
                  ),
                ),
                InkWell(
                  onTap: (){
                    Navigator.push(context, CupertinoPageRoute(builder: (context) =>CommonSignIn(getButtonText: "yardımsever",)));
                  },
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: specialButton("Yardım-Sever Girişi"),
                  ),
                ),
                InkWell(
                  onTap: (){
                    Navigator.push(context, CupertinoPageRoute(builder: (context) => CommonSignIn(getButtonText: "ihtiyac",)));
                  },
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: specialButton("İhtiyaç Sahibi Girişi"),
                  ),
                ),
              ],
            ),
        ),
      ],
    );
  }
}



Widget specialButton(String buttonName){
  return  Container(

    width: 350,
    height: 80,
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(14),
      color: Color(0xFFED4C67),

    ),
    child: Center(
      child: Text("$buttonName", style: TextStyle(
        color: Colors.white,
        fontWeight: FontWeight.bold,
        fontSize: 18,
      ),),
    ),
  );
}