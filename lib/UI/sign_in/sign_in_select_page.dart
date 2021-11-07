import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:yardimfeneri/COMMON/loginscreenindicator.dart';
import 'package:yardimfeneri/CONSTANTS/background_color.dart';
import 'package:yardimfeneri/EXTENSIONS/size_extension.dart';
import 'package:yardimfeneri/UI/sign_in/common_sign_in.dart';


class SignInPage extends StatefulWidget {


  @override
  _SignInPageState createState() => _SignInPageState();
}

class _SignInPageState extends State<SignInPage> {

  bool _loadingVisible = false;
  Future<void> _changeLoadingVisible() async {
    setState(() {
      _loadingVisible = !_loadingVisible;
    });
  }

  @override
  Widget build(BuildContext context) {
    return LoadingScreen(
      inAsyncCall: _loadingVisible,
      child: Scaffold(
        body: Stack(
          children: [
            arkaPlan(context),
            Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(height: 50.0.h,),
                  Image.asset("assets/logo.png",
                    scale: 6,
                    fit: BoxFit.contain,
                  ),

                  SizedBox(height: 100.0.h,),

                  InkWell(
                    onTap: () {
                      Navigator.push(context, CupertinoPageRoute(builder:(context) => CommonSignIn(getButtonText: "kurulus",)));
                    },
                    child: Padding(
                      padding:  EdgeInsets.all(8.0.h),
                      child: specialButton("Yardım Kuruluşları Girişi"),
                    ),
                  ),
                  InkWell(
                    onTap: (){
                      Navigator.push(context, CupertinoPageRoute(builder: (context) =>CommonSignIn(getButtonText: "yardımsever",)));
                    },
                    child: Padding(
                      padding:  EdgeInsets.all(8.0.h),
                      child: specialButton("Yardım-Sever Girişi"),
                    ),
                  ),
                  InkWell(
                    onTap: (){
                      Navigator.push(context, CupertinoPageRoute(builder: (context) => CommonSignIn(getButtonText: "ihtiyac",)));
                    },
                    child: Padding(
                      padding:  EdgeInsets.all(8.0.h),
                      child: specialButton("İhtiyaç Sahibi Girişi"),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}



Widget specialButton(String buttonName){
  return  Container(

    width: 310.0.w,
    height: 60.0.h,
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(14),
      color: Color(0xFFED4C67),

    ),
    child: Center(
      child: Text("$buttonName", style: TextStyle(
        color: Colors.white,
        fontWeight: FontWeight.bold,
        fontSize: 18.0.spByWidth,
      ),),
    ),
  );
}