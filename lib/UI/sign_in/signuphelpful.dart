import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:yardimfeneri/COMMON/loginscreenindicator.dart';
import 'package:yardimfeneri/data/cities.dart';
import 'package:intl/intl.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import 'package:yardimfeneri/COMMON/alertinfo.dart';
import 'package:yardimfeneri/COMMON/multilinetextfield.dart';
import 'package:yardimfeneri/COMMON/myButton.dart';
import 'package:yardimfeneri/COMMON/myinput.dart';
import 'package:yardimfeneri/EXTENSIONS/size_extension.dart';
import 'package:yardimfeneri/FIREBASE/auth/errortext.dart';
import 'package:yardimfeneri/ROUTING/navigation/navigation_service.dart';
import 'package:yardimfeneri/ROUTING/routeconstants.dart';
import 'package:yardimfeneri/SERVICE/charities_service.dart';
import 'package:yardimfeneri/SERVICE/helpful_service.dart';
import 'package:yardimfeneri/SERVICE/needy_service.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import 'package:yardimfeneri/UI/helpful/ilsearch.dart';
import 'package:yardimfeneri/model/charities_model.dart';
import 'package:yardimfeneri/model/helpful_model.dart';
import 'package:yardimfeneri/model/needy_model.dart';
import 'package:intl/date_symbol_data_local.dart';


class SignUpHelpful extends StatefulWidget {
  final String? getButtonText;
  SignUpHelpful(
      {
        this.getButtonText,
      });
  @override
  _SignUpHelpfulState createState() => _SignUpHelpfulState();
}

class _SignUpHelpfulState extends State<SignUpHelpful> {
  final TextEditingController? _emailcontroller = TextEditingController();
  final TextEditingController? _sifrecontroller = TextEditingController();
  final TextEditingController? _isimcontroller = TextEditingController();
  final TextEditingController? _soyisimcontroller = TextEditingController();
  final TextEditingController? _telefoncontroller = TextEditingController();
  final TextEditingController? _adrescontroller = TextEditingController();
  var controllertel = new MaskTextInputFormatter(mask: '### - ### - ## - ##');
  var controller = new MaskTextInputFormatter(mask: '000-000-00-00');
  String il = "İl Seçiniz";
  final _formKey1 = GlobalKey<FormState>();
  bool _validate = false;
  PickedFile? _image;
  var imageUrl;
  DateTime? _dateTime;
  final f = new DateFormat('yyyy-MM-dd');

  bool _loadingVisible = false;
  Future<void> _changeLoadingVisible() async {
    setState(() {
      _loadingVisible = !_loadingVisible;
    });
  }

  final picker = ImagePicker();
  @override
  Widget build(BuildContext context) {
    return LoadingScreen(
      inAsyncCall: _loadingVisible,
      child: Scaffold(
        appBar: AppBar(
          title: Text("Yardım Etmek İsteyen Kayıt",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 20.0.spByWidth,color: Colors.black),),
          backgroundColor: Colors.transparent,
          elevation: 0,
          iconTheme: IconThemeData(color: Colors.black),
        ),
        resizeToAvoidBottomInset: false,
        body: Container(
          child: ListView(
            children: [

              Padding(
                padding: const EdgeInsets.all(20.0),
                child: Form(
                  key: _formKey1,
                  child: Column(
                    children: [
                      SizedBox(
                        height: 10.0.h,
                      ),

                      Myinput(hintText:"İsim" ,icon: Icon(Icons.person,color: Colors.green,),onSaved: validateEmail,controller: _isimcontroller!,keybordType: TextInputType.emailAddress,passwordVisible: false),
                      Myinput(hintText:"Soyisim" ,icon: Icon(Icons.person,color: Colors.green,),onSaved: validateEmail,controller: _soyisimcontroller!,keybordType: TextInputType.emailAddress,passwordVisible: false),
                      Padding(
                        padding:  EdgeInsets.all(16.0.w),
                        child: Container(
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(20.0.w),
                            boxShadow: <BoxShadow>[
                              BoxShadow(color: Colors.grey.withOpacity(0.8), offset: const Offset(4, 4), blurRadius: 8),
                            ],
                          ),
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(10.0.h),
                            child: SizedBox(
                              height: 55.0.h,
                              child: Padding(
                                padding:  EdgeInsets.only(top: 0, left: 20.0.w),
                                child: TextFormField(
                                  inputFormatters: [controllertel],
                                  controller: _telefoncontroller,
                                  autocorrect: false,
                                  keyboardType: TextInputType.number,
                                  style: const TextStyle(
                                    color: const Color(0xff343633),
                                    fontWeight: FontWeight.w600,
                                    fontFamily: "OpenSans",
                                    fontStyle: FontStyle.normal,
                                    fontSize: 25.0,
                                  ),
                                  cursorColor: Colors.blue,
                                  decoration: InputDecoration(
                                    errorStyle: TextStyle(fontSize: 15),
                                    focusedBorder: InputBorder.none,
                                    enabledBorder: InputBorder.none,
                                    errorBorder: InputBorder.none,
                                    disabledBorder: InputBorder.none,
                                    border: InputBorder.none,
                                    // contentPadding:  const EdgeInsets.only(top: 40,left: 30),
                                    hintText: "5xx - xxx - xx - xx",
                                    hintStyle: TextStyle(
                                      color: Colors.black87,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                      Myinput(hintText:"E-mail" ,icon: Icon(Icons.email,color: Colors.green,),onSaved: validateEmail,controller: _emailcontroller!,keybordType: TextInputType.emailAddress,passwordVisible: false),
                      Myinput(hintText:"Şifre" ,icon: Icon(Icons.lock,color: Colors.green,),onSaved: validateSifre,controller: _sifrecontroller!,keybordType: TextInputType.emailAddress,passwordVisible: true),
                      InkWell(
                        onTap: () {
                          var result = showSearch<String>(
                              context: context, delegate: CitySearch(cities));
                          result.then((value) => setState(()=>il=value ?? "İl Seçiniz"));
                        },
                        child: Padding(
                          padding:  EdgeInsets.all(16.0.w),
                          child: Container(

                            height: 55.0.h,
                            padding:  EdgeInsets.only(left:8.0.w),
                            alignment: Alignment.centerLeft,
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(40.0.w),
                              boxShadow: <BoxShadow>[
                                BoxShadow(
                                    color: Colors.grey.withOpacity(0.8),
                                    offset: const Offset(4, 4),
                                    blurRadius: 8),
                              ],
                            ),
                            child: Text(il,style: TextStyle(color: Colors.black,fontSize: 15.0.spByWidth),),
                          ),
                        ),
                      ),
                      MultilineTextField(hintText:"Adres" ,icon: Icon(Icons.home_filled,color: Colors.green,),satir:4,onSaved: validateEmail,controller: _adrescontroller!,keybordType: TextInputType.emailAddress,passwordVisible: false),
                      InkWell(
                        onTap: () {
                          showCupertinoDatePicker(context);
                        },
                        child: Column(
                          children: [
                            Padding(
                              padding:  EdgeInsets.only(left: 20.0.w),
                              child: Align(
                                alignment: Alignment.topLeft,
                                child:  Text(
                                    "Doğum Tarihi" ,
                                    //_dateTime,
                                    style: TextStyle(
                                        color: const Color(0xd9343633),
                                        fontWeight: FontWeight.w400,
                                        fontFamily: "OpenSans",
                                        fontStyle: FontStyle.normal,
                                        fontSize: 15.0.spByWidth),
                                    textAlign: TextAlign.left),
                              ),
                            ),
                            SizedBox(height: 8.0.h,),
                            Padding(
                              padding:  EdgeInsets.all(16.0.w),
                              child: Container(
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(40.0.w),
                                  boxShadow: <BoxShadow>[
                                    BoxShadow(
                                        color: Colors.grey.withOpacity(0.8),
                                        offset: const Offset(4, 4),
                                        blurRadius: 8),
                                  ],
                                ),
                                height: 55.0.h,
                                child: DropdownButtonFormField(
                                  items: [],
                                  hint: Text( _dateTime == null ? "Doğum Tarihinizi Seçiniz" : formatTheDate(_dateTime!, format: DateFormat("dd.MM.y")),),
                                  decoration:InputDecoration(
                                    helperText: "   ",
                                    icon: Padding(
                                      padding:  EdgeInsets.only(top: 13.0.h,left: 10.0.w),
                                      child: Icon(Icons.date_range,color: Colors.green,),
                                    ),
                                    focusedBorder: InputBorder.none,
                                    enabledBorder: InputBorder.none,
                                    errorBorder: InputBorder.none,
                                    disabledBorder: InputBorder.none,
                                    border: InputBorder.none,
                                    contentPadding:  const EdgeInsets.only(),
                                    errorStyle: TextStyle(fontSize: 16,fontWeight: FontWeight.bold),
                                  ),

                                ),
                              ),
                            ),

                          ],
                        ),
                      ),
                      SizedBox(height: 10.0.h,),

                      Center(
                        child: MyButton(text: "Kayıt", fontSize: 18.0.spByWidth,butonColor: Colors.yellowAccent,width: 300.0.w,height: 50.0.h,
                          onPressed: (){
                            _validateInputsRegister(context);
                          }, textColor: Colors.green,),
                      ),
                      SizedBox(height: 30.0.h,),
                      SizedBox(
                        height: 25.0.h,
                      ),
                      RichText(
                        text: TextSpan(children: [
                          TextSpan(
                            text: 'Hesabınız var mı?',
                            style: TextStyle(
                              fontSize: 15,
                              color: Colors.black,
                            ),
                          ),
                          TextSpan(
                            text: '  Giriş Yapın.',
                            style: TextStyle(
                              color: Theme.of(context).primaryColor,
                              fontWeight: FontWeight.bold,
                              fontSize: 18,
                            ),
                          ),
                        ]),
                      ),
                      SizedBox(
                        height: 30.0.h,
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



  Future<dynamic> showCupertinoDatePicker(BuildContext context) {
    return showModalBottomSheet(
        context: context,
        builder: (BuildContext bc) {
          return Container(
              height: MediaQuery.of(context).copyWith().size.height / 3,
              child: CupertinoDatePicker(
                onDateTimeChanged: (DateTime newdate) {
                  setState(() {
                    _dateTime = newdate;
                  });
                },
                maximumYear: DateTime.now().year,
                initialDateTime: DateTime.now(),
                mode: CupertinoDatePickerMode.date,
              ));
        });
  }

  void _validateInputsRegister(BuildContext context) async {
    if (_formKey1.currentState!.validate()) {
      if(il=="İl Seçiniz")
      {
        var dialogBilgi = AlertBilgilendirme(
          icerik: "Lütfen il seçiniz.",
          Pressed: () {
            Navigator.pop(context);
          },
        );
        showDialog(
            context: context,
            builder: (BuildContext context) => dialogBilgi);
      }else if(_dateTime==null)
      {
        var dialogBilgi = AlertBilgilendirme(
          icerik: "Lütfen doğum tarihi seçiniz.",
          Pressed: () {
            Navigator.pop(context);
          },
        );
        showDialog(
            context: context,
            builder: (BuildContext context) => dialogBilgi);
      }else {
        SystemChannels.textInput.invokeMethod('TextInput.hide');
        await _changeLoadingVisible();
        final _userModel = Provider.of<HelpfulService>(context, listen: false);
        HelpfulModel needyModel =
        new HelpfulModel(userId: "userid",
            email: _emailcontroller!.text,
            password: _sifrecontroller!.text,
            isim: _isimcontroller!.text,
            soyisim: _soyisimcontroller!.text,
            il: il,
            adres: _adrescontroller!.text,
            dogumTarihi: _dateTime!,
            telefon: _telefoncontroller!.text);
        HelpfulModel? createuser = await _userModel
            .createUserWithEmailandPasswordHelpful(
            _emailcontroller!.text, _sifrecontroller!.text, needyModel);
        if (createuser != null) {
          NavigationService.instance.navigateToReset(
              RouteConstants.LANDINGPAGE);
        }
      }
    }
  }

  void _validateInputs(BuildContext context) async {
    var _userModel;

    if(widget.getButtonText=="kurulus")
    {
      _userModel = Provider.of<CharitiesService>(context,listen: false);
    }else if( widget.getButtonText == "yardımsever")
    {
      _userModel = Provider.of<HelpfulService>(context,listen: false);
    }else{
      _userModel = Provider.of<NeedyService>(context,listen: false);
    }


    if (_formKey1.currentState!.validate()) {
      SystemChannels.textInput.invokeMethod('TextInput.hide');
      await _changeLoadingVisible();
      try {

        CharitiesModel? _usercharities = null;
        NeedyModel? _userneedy;
        HelpfulModel? _userhelpful;

        if(widget.getButtonText=="kurulus")
        {
          _usercharities = (await _userModel.signInWithEmailandPasswordCharities(_emailcontroller!.text, _sifrecontroller!.text))!;

        }else if( widget.getButtonText == "yardımsever")
        {
          _userhelpful = (await _userModel.signInWithEmailandPasswordHelpful(_emailcontroller!.text, _sifrecontroller!.text))!;

        }else{
          _userneedy = (await _userModel.signInWithEmailandPasswordNeedy(_emailcontroller!.text, _sifrecontroller!.text))!;
        }



        // print("Giris yapan user: "+_girisYapanUser.toString());

        Navigator.pop(context);
        if (_usercharities!=null || _userhelpful!=null || _userneedy != null){
          setState(() {
            _loadingVisible=false;
          });
        }else{

        }

      } on FirebaseAuthException catch (e) {
        var dialogBilgi = AlertBilgilendirme(
          icerik: ErrorText.goster(e.code),
          Pressed: () {
            Navigator.pop(context);
          },
        );

        showDialog(
            context: context,
            builder: (
                BuildContext context) => dialogBilgi);

        setState(() {
          _loadingVisible=false;
        });
      }catch (e) {
        var dialogBilgi = AlertBilgilendirme(
          icerik: "Bir Hata Oluştu...",
          Pressed: () {
            Navigator.pop(context);
          },
        );

        showDialog(
            context: context,
            builder: (
                BuildContext context) => dialogBilgi);
        setState(() {
          _loadingVisible=false;
        });
      }

    } else {

      setState(() {
        _validate = true;
      });
    }
  }

  void _showPicker(context) {
    showModalBottomSheet(
        context: context,
        builder: (BuildContext bc) {
          return SafeArea(
            child: Container(
              child: new Wrap(
                children: <Widget>[
                  new ListTile(
                      leading: new Icon(Icons.photo_library),
                      title: new Text('Galeri'),
                      onTap: () {
                        _imgFromGallery();
                        Navigator.of(context).pop();
                      }),
                  new ListTile(
                    leading: new Icon(Icons.photo_camera),
                    title: new Text('Kamera'),
                    onTap: () {
                      _imgFromCamera();
                      Navigator.of(context).pop();
                    },
                  ),
                ],
              ),
            ),
          );
        });
  }

  _imgFromCamera() async {
    PickedFile? image = await picker.getImage(source: ImageSource.camera, imageQuality: 25);

    setState(() {
      _image = image!;
    });
  }

  _imgFromGallery() async {
    PickedFile? image = await picker.getImage(source: ImageSource.gallery, imageQuality: 25);

    setState(() {
      _image = image!;
      print(_image!.path);
    });
  }

  String formatTheDate(DateTime selectedDate, {DateFormat? format}) {
    final DateTime now = selectedDate;
    final DateFormat formatter = format ?? DateFormat('dd.MM.y', "tr_TR");
    final String formatted = formatter.format(now);
    initializeDateFormatting("tr_TR");
    return formatted;
  }

  Future<String> uploadDuyuruImage(String id) async {
    //final _modelYonetici = Provider.of<YoneticiModel>(context, listen: false);
    if(_image == null)
      return "";
    String filePath = _image!.path;
    String userId = "_modelYonetici.user.userId";
    String fileName = "${userId}-${id}}.jpg";
    File file = File(filePath);
    try {
      await firebase_storage.FirebaseStorage.instance.ref('duyuru/$fileName').putFile(file);
      String downloadURL =
      await firebase_storage.FirebaseStorage.instance.ref('duyuru/$fileName').getDownloadURL();
      return downloadURL;
    } on FirebaseException catch (e) {
      // e.g, e.code == 'canceled'
      return "error";
      print("Error on uploading image file ${e.code}");
    }
  }

}
