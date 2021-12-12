import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:yardimfeneri/common/alertinfo.dart';
import 'package:yardimfeneri/common/loginscreenindicator.dart';
import 'package:yardimfeneri/common/myButton.dart';
import 'package:yardimfeneri/common/myinput.dart';
import 'package:yardimfeneri/extensions/size_extension.dart';
import 'package:yardimfeneri/firebase/auth/errortext.dart';
import 'package:yardimfeneri/model/charities_model.dart';
import 'package:yardimfeneri/model/helpful_model.dart';
import 'package:yardimfeneri/model/needy_model.dart';
import 'package:yardimfeneri/routing/navigation/navigation_service.dart';
import 'package:yardimfeneri/routing/routeconstants.dart';
import 'package:yardimfeneri/service/charities_service.dart';
import 'package:yardimfeneri/service/helpful_service.dart';
import 'package:yardimfeneri/service/needy_service.dart';


class CommonSignIn extends StatefulWidget {
  final String? getButtonText;
  CommonSignIn({
    this.getButtonText,
});
  @override
  _CommonSignInState createState() => _CommonSignInState();
}

class _CommonSignInState extends State<CommonSignIn> {
  final TextEditingController? _emailcontroller = TextEditingController();
  final TextEditingController? _sifrecontroller = TextEditingController();
  final _formKey1 = GlobalKey<FormState>();
  bool _validate = false;
  bool _loadingVisible = false;  @override
  void setState(VoidCallback fn) {
    print("Girilen Sayfa: ${this.widget}");
    super.setState(fn);
  }

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
        appBar: AppBar(
          elevation: 0,
          backgroundColor: Colors.transparent,
          iconTheme: IconThemeData(color: Colors.black),
        ),
        body: Container(
          child: ListView(
            children: [
              SizedBox(
                height: 50.0.h,
              ),
              widget.getButtonText == "kurulus" ? Center(child: Text("Yardım Kuruşları Giriş!",style: TextStyle(color: Theme.of(context).primaryColor,fontSize: 25.0.spByWidth,fontWeight: FontWeight.bold),)) : Container(),
              widget.getButtonText == "yardımsever" ? Center(child: Text("Yardım-Sever Giriş!",style: TextStyle(color: Theme.of(context).primaryColor,fontSize: 25.0.spByWidth,fontWeight: FontWeight.bold),)) : Container(),
              widget.getButtonText == "ihtiyac" ? Center(child: Text("İhtiyaç Sahibi Giriş!",style: TextStyle(color: Theme.of(context).primaryColor,fontSize: 25.0.spByWidth,fontWeight: FontWeight.bold),)) : Container(),
              Padding(
                padding:  EdgeInsets.all(30.0.h),
                child: Form(
                  key: _formKey1,
                  child: Column(
                    children: [
                      SizedBox(
                        height: 50.0.h,
                      ),
                      Myinput(hintText:"E-mail" ,icon: Icon(Icons.email,color: Colors.green,),onSaved: validateEmail,controller: _emailcontroller!,keybordType: TextInputType.emailAddress,passwordVisible: false,validate: validateEmail,),
                      Myinput(hintText:"Şifre" ,icon: Icon(Icons.lock,color: Colors.green,),onSaved: validateSifre,controller: _sifrecontroller!,keybordType: TextInputType.emailAddress,passwordVisible: true, satir: null,validate: validateSifre,),
                      SizedBox(height: 10.0.h,),
                      Center(
                        child: MyButton(text: "Giriş", fontSize: 18.0.spByWidth,butonColor: Colors.green,width: 240.0.w,height: 50.0.h,
                          onPressed: (){
                            _validateInputs(context);
                          }, textColor: Colors.white,),
                      ),

                      SizedBox(
                        height: 25.0.h,
                      ),
                      RichText(
                        text: TextSpan(children: [
                          TextSpan(
                            text: 'Hesabınız mı yok?',
                            style: TextStyle(
                              fontSize: 14.0.spByWidth,
                              color: Colors.black,
                            ),
                          ),
                          TextSpan(
                            recognizer: TapGestureRecognizer()..onTap =() {

                              if(widget.getButtonText=="kurulus")
                              {
                                NavigationService.instance.navigate(RouteConstants.SIGNUPCHARITIES);
                              }else if( widget.getButtonText == "yardımsever")
                              {
                                NavigationService.instance.navigate(RouteConstants.SIGNUPHELPFUL);
                              }else{
                                NavigationService.instance.navigate(RouteConstants.SIGNUPNEEDY);                            }
                            } ,
                            text: '  Hemen Kaydolun.',
                            style: TextStyle(
                              color: Theme.of(context).primaryColor,
                              fontWeight: FontWeight.bold,
                              fontSize: 16.0.spByWidth,
                            ),
                          ),
                        ]),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
  String? validateEmail(String? value) {
    String pattern =
        r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
    RegExp regex = new RegExp(pattern);
    if (!regex.hasMatch(value!))
      return 'Email Geçersiz';
    else
      return null;
  }

  String? validateSifre(String? value) {
    if (value!.length<6)
      return 'Şifre Geçersiz';
    else
      return null;
  }


  void _validateInputs(BuildContext context) async {

    if (_formKey1.currentState!.validate()) {
      var _userModel;

      if (widget.getButtonText == "kurulus") {
        _userModel = Provider.of<CharitiesService>(context, listen: false);
      } else if (widget.getButtonText == "yardımsever") {
        _userModel = Provider.of<HelpfulService>(context, listen: false);
      } else {
        _userModel = Provider.of<NeedyService>(context, listen: false);
      }


      SystemChannels.textInput.invokeMethod('TextInput.hide');
      await _changeLoadingVisible();
      try {
        CharitiesModel? _usercharities;
        NeedyModel? _userneedy;
        HelpfulModel? _userhelpful;

        if (widget.getButtonText == "kurulus") {
          _usercharities =
          (await _userModel.signInWithEmailandPasswordCharities(
              _emailcontroller!.text, _sifrecontroller!.text))!;
        } else if (widget.getButtonText == "yardımsever") {
          _userhelpful = (await _userModel.signInWithEmailandPasswordHelpful(
              _emailcontroller!.text, _sifrecontroller!.text))!;
        } else {
          _userneedy = (await _userModel.signInWithEmailandPasswordNeedy(
              _emailcontroller!.text, _sifrecontroller!.text))!;
        }


        Navigator.pop(context);
        if (_usercharities != null || _userhelpful != null ||
            _userneedy != null) {
          setState(() {
            _loadingVisible = false;
          });
        } else {

        }
      } on FirebaseAuthException catch (e) {
        print("giris hatası: " + e.code);
        var dialogBilgi = AlertBilgilendirme(
          icerik: ErrorText.goster(e.code),
          Pressed: () {
            Navigator.pop(context);
          },
        );

        showDialog(
            context: context,
            builder: (BuildContext context) => dialogBilgi);

        setState(() {
          _loadingVisible = false;
        });
      }
    }
  }
}
