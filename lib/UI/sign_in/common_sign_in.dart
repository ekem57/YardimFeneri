import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:yardimfeneri/UI/sign_in/common_sign_up.dart';
import 'package:yardimfeneri/UI/sign_in/sign_in_page.dart';


class CommonSignIn extends StatefulWidget {
  final String? getButtonText;
  CommonSignIn({
    this.getButtonText,
});
  @override
  _CommonSignInState createState() => _CommonSignInState();
}

class _CommonSignInState extends State<CommonSignIn> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  @override
  void setState(VoidCallback fn) {
    print("Girilen Sayfa: ${this.widget}");
    super.setState(fn);
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: Column(
          children: [
            SizedBox(
              height: 100,
            ),
            widget.getButtonText == "kurulus" ? Text("Yardım Kuruşları Girişine Hoşgeldiniz!",style: TextStyle(color: Theme.of(context).primaryColor,fontSize: 20),) : Container(),
            widget.getButtonText == "yardımsever" ? Text("Yardım-Sever Girişine Hoşgeldiniz!",style: TextStyle(color: Theme.of(context).primaryColor,fontSize: 20),) : Container(),
            widget.getButtonText == "ihtiyac" ? Text("İhtiyaç Sahibi Girişine Hoşgeldiniz!",style: TextStyle(color: Theme.of(context).primaryColor,fontSize: 20),) : Container(),
            Padding(
              padding: const EdgeInsets.all(50.0),
              child: Form(
                key: _formKey,
                child: Column(
                  children: [
                    SizedBox(
                      height: 300,
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Container(
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(25.0),
                            border: Border.all(
                              color:Theme.of(context).primaryColor,
                            )
                        ),
                        child: TextFormField(
                          keyboardType: TextInputType.emailAddress,
                          decoration: InputDecoration(
                            prefixIcon: Icon(
                              Icons.person,
                              color: Colors.black,
                            ),
                            hintText: "E-posta adresinizi giriniz.. ",
                            hintStyle: TextStyle(color: Color(0xFFED4B50),),
                            enabledBorder: InputBorder.none,
                            focusColor: Color(0xFFED4B50),
                            focusedBorder: InputBorder.none,
                          ),
                          cursorColor: Theme.of(context).primaryColor,
                          validator: (String? value){
                            if(value == null || value.isEmpty){
                              return 'Bu kısım boş bırakılamaz';
                            }
                            return null;
                          },
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Container(
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(25.0),
                            border: Border.all(
                              color: Theme.of(context).primaryColor,
                            )
                        ),
                        child: TextFormField(
                          obscureText: true ,
                          decoration: InputDecoration(
                            prefixIcon: Icon(
                              Icons.password,
                              color: Colors.black,
                            ),
                            hintText: "Şifrenizi giriniz.. ",
                            hintStyle: TextStyle(color:Theme.of(context).primaryColor,),
                            enabledBorder: InputBorder.none,
                            focusColor: Theme.of(context).primaryColor,
                            focusedBorder: InputBorder.none,
                          ),
                          cursorColor: Color(0xFFED4B50),
                          validator: (String? value){
                            if(value == null || value.isEmpty){
                              return 'Bu kısım boş bırakılamaz';
                            }
                            return null;
                          },
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 50,
                    ),
                    specialButton("Giriş Yap"),
                    SizedBox(
                      height: 25,
                    ),
                    RichText(
                      text: TextSpan(children: [
                        TextSpan(
                          text: 'Hesabınız mı yok?',
                          style: TextStyle(
                            fontSize: 15,
                            color: Colors.black,
                          ),
                        ),
                        TextSpan(
                          recognizer: TapGestureRecognizer()..onTap =() {
                            Navigator.push(context, CupertinoPageRoute(builder: (context) => CommonSignUp(getButtonText: widget.getButtonText == "kurulus" ? "kurulus" : widget.getButtonText == "yardımsever" ? "yardımsever" : widget.getButtonText == "ihtiyac" ? "ihtiyac" : "Hata",)));
                          } ,
                          text: '  Hemen Kaydolun.',
                          style: TextStyle(
                            color: Theme.of(context).primaryColor,
                            fontWeight: FontWeight.bold,
                            fontSize: 18,
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
    );
  }
}
