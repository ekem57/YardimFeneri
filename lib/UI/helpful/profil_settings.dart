import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import 'package:yardimfeneri/COMMON/alertinfo.dart';
import 'package:yardimfeneri/COMMON/loginscreenindicator.dart';
import 'package:yardimfeneri/COMMON/myButton.dart';
import 'package:yardimfeneri/extantion/size_extension.dart';
import 'package:yardimfeneri/model/helpful_model.dart';
import 'package:yardimfeneri/navigationpage/profil_page/profile_widget.dart';
import 'package:yardimfeneri/servis/charities_service.dart';
import 'package:yardimfeneri/servis/helpful_service.dart';


class ProfilSettings extends StatefulWidget {
  HelpfulModel user;

   ProfilSettings({Key key,this.user}) : super(key: key);

  @override
  _ProfilSettingsState createState() => _ProfilSettingsState();
}

class _ProfilSettingsState extends State<ProfilSettings> {
  PickedFile _image;
  var imageUrl;
  final picker = ImagePicker();

  bool _loadingVisible = false;
  Future<void> _changeLoadingVisible() async {
    setState(() {
      _loadingVisible = !_loadingVisible;
    });
  }

  TextEditingController _email = new TextEditingController();
  TextEditingController _hakkimda = new TextEditingController();


  @override
  void initState() {
    super.initState();
    _email.text = widget.user.email;
    _hakkimda.text = widget.user.hakkimda;
  }

  @override
  Widget build(BuildContext context) {
    final _helpfulService = Provider.of<HelpfulService>(context, listen: true);

    return LoadingScreen(
      inAsyncCall: _loadingVisible,
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          iconTheme: IconThemeData(color: Colors.black),
          elevation: 0,
        ),
        body: ListView(
          children: [
            SizedBox(height: 30.0.h,),
            Center(
              child: Text("Profil Düzenle", style: TextStyle(
                  fontSize: 26.0.spByWidth, fontWeight: FontWeight.bold, color: Colors.black),),
            ),
            SizedBox(height: 20.0.h,),
            ProfileWidget(
              imagePath: _helpfulService.user.foto,
              onClicked: () {
                _showPicker(context);
              },
            ),

            _golgelitext("email", _email, 1,1),
            _golgelitext("hakkimda", _hakkimda, 8,10),
            SizedBox(height: 20.0.h,),
            Padding(
              padding:  EdgeInsets.all(25.0.h),
              child: MyButton(text: "Kaydet", onPressed: () async {
                SystemChannels.textInput.invokeMethod('TextInput.hide');
                await _changeLoadingVisible();
                try {
                  DocumentReference _reference = await FirebaseFirestore.instance
                      .collection("helpful").doc(_helpfulService.user.userId);

                  Map<String, dynamic> profil = Map();

                  profil['email'] = _email.text;
                  profil['hakkimda'] = _hakkimda.text;


                  _reference.update(profil).then((value) {
                    var dialogBilgi = AlertBilgilendirme(
                      icerik: "Bilgileriniz Kaydedildi.",
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
                  });

                }catch(e){
                  print(e);
                  var dialogBilgi = AlertBilgilendirme(
                    icerik: "Verileriniz kaydedilmedi üzgünüz. Lütfen tekrar deneyiniz... \n",
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

              }, textColor: Colors.white, fontSize: 16.0.spByWidth, width: 50.0.w, height: 55.0.h,butonColor: Colors.green,),
            ),

          ],
        ),
      ),
    );
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
    PickedFile image = await picker.getImage(source: ImageSource.camera, imageQuality: 25);

    setState(() {
      _image = image;
    });
  }

  _imgFromGallery() async {
    PickedFile image = await picker.getImage(source: ImageSource.gallery, imageQuality: 25);

    setState(() {
      _image = image;
      print(_image.path);
    });
  }


  Future<String> uploadDuyuruImage(String id) async {
    if(_image == null)
      return "";
    String filePath = _image.path;
    String userId = "_modelYonetici.user.userId";
    File file = File(filePath);
    try {
      await firebase_storage.FirebaseStorage.instance.ref('anasayfa/profil/$id').putFile(file);
      String downloadURL =
      await firebase_storage.FirebaseStorage.instance.ref('anasayfa/profil/$id').getDownloadURL();
      print(downloadURL);
      return downloadURL;
    } on FirebaseException catch (e) {
      // e.g, e.code == 'canceled'
      return "error";
      print("Error on uploading image file ${e.code}");
    }
  }

  Widget _golgelitext(String _text,TextEditingController control,int satir,double paddingtop) {
    return Padding(
      padding: const EdgeInsets.only(top: 16, left: 16, right: 16),
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(8),
          boxShadow: <BoxShadow>[
            BoxShadow(
                color: Colors.grey.withOpacity(0.8),
                offset: const Offset(4, 4),
                blurRadius: 8),
          ],
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(15),
          child: Container(
            padding: const EdgeInsets.all(1.0),
            constraints: const BoxConstraints(minHeight: 50, maxHeight: 250),
            color: Colors.white,
            child: SingleChildScrollView(

              child: TextField(

                controller: control,
                maxLines: satir,
                onChanged: (String txt) {},
                style: TextStyle(

                  fontSize: 18,
                  color: Colors.black,
                ),
                cursorColor: Colors.blue,
                decoration: InputDecoration(
                    contentPadding: EdgeInsets.only(left: 15,top: paddingtop),
                    border: InputBorder.none,
                    focusedErrorBorder: InputBorder.none,
                    disabledBorder: InputBorder.none,
                    errorBorder: InputBorder.none,
                    focusedBorder: InputBorder.none,
                    enabledBorder: InputBorder.none,
                    hintText: _text),
              ),
            ),
          ),
        ),
      ),
    );
  }


}
