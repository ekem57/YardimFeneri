import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:intl/intl.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import 'package:yardimfeneri/COMMON/alertinfo.dart';
import 'package:yardimfeneri/COMMON/loginscreenindicator.dart';
import 'package:yardimfeneri/COMMON/multilinetextfield.dart';
import 'package:yardimfeneri/COMMON/myButton.dart';
import 'package:yardimfeneri/COMMON/myinput.dart';
import 'package:yardimfeneri/EXTENSIONS/size_extension.dart';
import 'package:yardimfeneri/ROUTING/navigation/navigation_service.dart';
import 'package:yardimfeneri/ROUTING/routeconstants.dart';
import 'package:yardimfeneri/SERVICE/charities_service.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import 'package:yardimfeneri/model/charities_model.dart';
import 'package:intl/date_symbol_data_local.dart';


class SignUpCharities extends StatefulWidget {
  final String? getButtonText;
  SignUpCharities(
      {
        this.getButtonText,
      });
  @override
  _SignUpCharitiesState createState() => _SignUpCharitiesState();
}

class _SignUpCharitiesState extends State<SignUpCharities> {
  final TextEditingController? _emailcontroller = TextEditingController();
  final TextEditingController? _sifrecontroller = TextEditingController();
  final TextEditingController? _isimcontroller = TextEditingController();
  final TextEditingController? _baskancontroller = TextEditingController();
  final TextEditingController? _telefoncontroller = TextEditingController();
  final TextEditingController? _adrescontroller = TextEditingController();
  final TextEditingController? _faaliyetalanicontroller = TextEditingController();
  var controllertel = new MaskTextInputFormatter(mask: '### - ### - ## - ##');
  var controller = new MaskTextInputFormatter(mask: '000-000-00-00');

  final _formKey1 = GlobalKey<FormState>();
  bool _validate = false;
  String isim="";
  PickedFile? _image;
  var imageUrl;
  DateTime? _dateTime;
  final f = new DateFormat('yyyy-MM-dd');
  final picker = ImagePicker();

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
        appBar: AppBar(
          title: Text("Kuruluş Kayıt",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 22.0.spByWidth,color: Colors.black),),
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
                  autovalidate: _validate,
                  child: Column(
                    children: [
                      SizedBox(
                        height: 10.0.h,
                      ),

                      Myinput(hintText:"Kuruluş İsmi" ,icon: Icon(Icons.home_work_sharp,color: Colors.green,),onSaved: validateKurulusName,controller: _isimcontroller!,keybordType: TextInputType.emailAddress,passwordVisible: false,validate: validateKurulusName,),
                      Myinput(hintText:"Başkan Adı" ,icon: Icon(Icons.person,color: Colors.green,),onSaved: validateBaskan,controller: _baskancontroller!,keybordType: TextInputType.emailAddress,passwordVisible: false,validate: validateBaskan ,),
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
                                  validator: validateTelefon,
                                  autocorrect: false,
                                  keyboardType: TextInputType.number,
                                  style:  TextStyle(
                                    color: const Color(0xff343633),
                                    fontWeight: FontWeight.w600,
                                    fontFamily: "OpenSans",
                                    fontStyle: FontStyle.normal,
                                    fontSize: 20.0.spByWidth,
                                  ),
                                  cursorColor: Colors.blue,
                                  decoration: InputDecoration(
                                    errorStyle: TextStyle(fontSize: 15),
                                    focusedBorder: InputBorder.none,
                                    focusedErrorBorder: InputBorder.none,
                                    enabledBorder: InputBorder.none,
                                    errorBorder: InputBorder.none,
                                    disabledBorder: InputBorder.none,
                                    border: InputBorder.none,
                                    // contentPadding:  const EdgeInsets.only(top: 40,left: 30),
                                    hintText: "5xx - xxx - xx - xx",
                                    hintStyle: TextStyle(
                                      color: Colors.black87,
                                    ),
                                    icon: Icon(Icons.phone,color: Colors.green,size:24,),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                      Myinput(hintText:"E-mail" ,icon: Icon(Icons.email,color: Colors.green,),onSaved: validateEmail,controller: _emailcontroller!,keybordType: TextInputType.emailAddress,passwordVisible: false,validate: validateEmail,),
                      Myinput(hintText:"Şifre" ,icon: Icon(Icons.lock,color: Colors.green,),onSaved: validateSifre,controller: _sifrecontroller!,keybordType: TextInputType.emailAddress,passwordVisible: true,validate: validateSifre,),
                      MultilineTextField(hintText:"Adres" ,icon: Icon(Icons.home_sharp,color: Colors.green,),satir:4,onSaved: validateEmail,controller: _adrescontroller!,keybordType: TextInputType.emailAddress,passwordVisible: false,validate: validateAdres,),
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
                                    "Kuruluş Tarihi" ,
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
                                  hint: Text( _dateTime == null ? "Kuruluş Tarihi Seçiniz" : formatTheDate(_dateTime!, format: DateFormat("dd.MM.y")),),
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
                      Myinput(hintText:"Faaliyet Alanı" ,icon: Icon(Icons.work,color: Colors.green,),onSaved: validateEmail,controller: _faaliyetalanicontroller!,keybordType: TextInputType.emailAddress,passwordVisible: false,validate: validateFaaliyet,),
                      Padding(
                        padding:  EdgeInsets.only(left: 20.0.w),
                        child: Align(
                          alignment: Alignment.topLeft,
                          child: Opacity(
                            opacity: 0.85,
                            child: Text("Faaliyet Belgesi",
                                style: TextStyle(
                                    color: const Color(0xd9343633),
                                    fontWeight: FontWeight.w400,
                                    fontFamily: "OpenSans",
                                    fontStyle: FontStyle.normal,
                                    fontSize: 15.0.spByWidth),
                                textAlign: TextAlign.left),
                          ),
                        ),
                      ),
                      Padding(
                        padding:  EdgeInsets.only(left: 20.0.w,top: 5.0.h),
                        child: Align(
                          alignment: Alignment.topLeft,
                          child: Opacity(
                            opacity: 0.85,
                            child: Text("(Vakfın faaliyetde olduğunu gösteren belge)",
                                style: TextStyle(
                                    color: const Color(0xd9343633),
                                    fontWeight: FontWeight.w400,
                                    fontFamily: "OpenSans",
                                    fontStyle: FontStyle.normal,
                                    fontSize: 12.0.spByWidth),
                                textAlign: TextAlign.left),
                          ),
                        ),
                      ),
                      Padding(
                        padding:  EdgeInsets.only(right: 20.0.w,left: 20.0.w),
                        child: Container(
                          width: 312.0.w,
                          height: 146.0.h,
                          margin: EdgeInsets.symmetric(vertical: 20.0.h),
                          alignment: Alignment.center,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.all(Radius.circular(17)),
                              boxShadow: [
                                BoxShadow(
                                    color: const Color(0x30000000), offset: Offset(0, 2), blurRadius: 14, spreadRadius: 0)
                              ],
                              color: Colors.white),
                          child: GestureDetector(
                            onTap: () {
                              _showPicker(context);
                            },
                            child: _image == null
                                ? Container(
                              width: 56.0.w,
                              height: 56.0.w,
                              decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  boxShadow: [
                                    BoxShadow(
                                        color: const Color(0x36000000),
                                        offset: Offset(2, 3),
                                        blurRadius: 18,
                                        spreadRadius: 0)
                                  ],
                                  color: Colors.white),
                              child: Icon(Icons.camera_alt, size: 24.0.h, color: Theme.of(context).primaryColor),
                            )
                                : ClipRRect(
                              borderRadius: BorderRadius.circular(17),
                              child: Image.file(
                                File(_image!.path),
                                width: 312.0.w,
                                height: 146.0.h,
                                fit: BoxFit.fitWidth,
                              ),
                            ),
                          ),
                        ),
                      ),

                      SizedBox(height: 10.0.h,),


                      Center(
                        child: MyButton(text: "Kayıt", fontSize: 18.0.spByWidth,butonColor: Colors.green,width: 300.0.w,height: 50.0.h,
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
      _formKey1.currentState!.save();
      if(_image==null)
      {
        var dialogBilgi = AlertBilgilendirme(
          icerik: "Lütfen faaliyet belgesi ekleyiniz.",
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
        final _userModel = Provider.of<CharitiesService>(
            context, listen: false);
        CharitiesModel charitiesModel =
        new CharitiesModel(userId: "userid",
            email: _emailcontroller!.text,
            password: _sifrecontroller!.text,
            isim: _isimcontroller!.text,
            logo: "logo",
            faaliyetalani: _faaliyetalanicontroller!.text,
            kurulusTarihi: _dateTime!,
            telefon: _telefoncontroller!.text,
            hesaponay: false);
        CharitiesModel? createuser = await _userModel
            .createUserWithEmailandPasswordCharities(
            _emailcontroller!.text, _sifrecontroller!.text, charitiesModel);
        if (createuser != null) {
          NavigationService.instance.navigateToReset(
              RouteConstants.LANDINGPAGE);
        }
      }
    }else{
      var dialogBilgi = AlertBilgilendirme(
        icerik: "Lütfen gerekli alanları doldurunuz.",
        Pressed: () {
          Navigator.pop(context);
        },
      );

      showDialog(
          context: context,
          builder: (BuildContext context) => dialogBilgi);

      setState(() {
        _loadingVisible = false;
        _validate=true;
      });
    }
  }

  String? validateKurulusName(String? value) {
    if (value!.length < 3)
      return 'Kuruluş ismi en az 3 karakter olmalıdır.';
    else
      return null;
  }
  String? validateBaskan(String? value) {
    if (value!.length < 3)
      return 'Başkan Adı en az 3 karakter olmalıdır.';
    else
      return null;
  }
  String? validateTelefon(String? value) {
    if (value!.length < 11)
      return 'Lütfen Geçerli bir telefon numarası giriniz';
    else
      return null;
  }
  String? validateAdres(String? value) {
    if (value!.length < 6)
      return 'Adres en az 5 karakter olmalıdır.';
    else
      return null;
  }
  String? validateFaaliyet(String? value) {
    if (value!.length < 6)
      return 'Faaliyet Alanı en az 3 karakter olmalıdır.';
    else
      return null;
  }

  String? validateSurname(String? value) {
    if (value!.length < 3)
      return 'Soyisminiz en az 3 karakter olmalıdır.';
    else
      return null;
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
