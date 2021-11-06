import 'package:flutter/material.dart';
import 'package:yardimfeneri/UI/sign_in/sign_in_page.dart';

class CommonSignUp extends StatefulWidget {
  final String? getButtonText;
  CommonSignUp(
      {
        this.getButtonText,
      });
  @override
  _CommonSignUpState createState() => _CommonSignUpState();
}

class _CommonSignUpState extends State<CommonSignUp> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Container(
        child: Column(
          children: [
            SizedBox(
              height: 30,
            ),
            widget.getButtonText == "kurulus" ? Text("Yardım Kuruşları Kayıt Sayfası",style: TextStyle(color: Theme.of(context).primaryColor,fontSize: 20),) : Container(),
            widget.getButtonText == "yardımsever" ? Text("Yardım Sever Kayıt Sayfası",style: TextStyle(color: Theme.of(context).primaryColor,fontSize: 20),) : Container(),
            widget.getButtonText == "ihtiyac" ? Text("İhtiyaç Sahibi Kayıt Sayfası",style: TextStyle(color: Theme.of(context).primaryColor,fontSize: 20),) : Container(),
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: Form(
                key: _formKey,
                child: Column(
                  children: [
                    SizedBox(
                      height: 50,
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
