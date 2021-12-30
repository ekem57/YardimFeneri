import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import 'package:yardimfeneri/COMMON/myButton.dart';
import 'package:yardimfeneri/common/alertinfo.dart';
import 'package:yardimfeneri/extantion/size_extension.dart';
import 'package:yardimfeneri/servis/charities_service.dart';

class YardimKampanyasiAcmaCharities extends StatefulWidget {
  const YardimKampanyasiAcmaCharities({Key key}) : super(key: key);

  @override
  _YardimKampanyasiAcmaCharitiesState createState() => _YardimKampanyasiAcmaCharitiesState();
}

class _YardimKampanyasiAcmaCharitiesState extends State<YardimKampanyasiAcmaCharities> {
  PickedFile _image;
  var imageUrl;
  final picker = ImagePicker();

  bool _loadingVisible = false;
  Future<void> _changeLoadingVisible() async {
    setState(() {
      _loadingVisible = !_loadingVisible;
    });
  }

  TextEditingController _baslik = new TextEditingController();
  TextEditingController _icerik = new TextEditingController();


  @override
  Widget build(BuildContext context) {
    final _charitiesModel = Provider.of<CharitiesService>(context, listen: true);

    return Scaffold(
      body: ListView(
          children: [
            SizedBox(height: 30.0.h,),
            Center(
              child: Text("Yardım Kampanyası Başlat", style: TextStyle(
                  fontSize: 22.0.spByWidth, fontWeight: FontWeight.bold, color: Colors.black),),
            ),
            SizedBox(height: 20.0.h,),
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
                      File(_image.path),
                      width: 312.0.w,
                      height: 146.0.h,
                      fit: BoxFit.fitWidth,
                    ),
                  ),
                ),
              ),
            ),
            _golgelitext("Başlık", _baslik, 9,15),
            SizedBox(height: 13.0.h,),
            Padding(
              padding:  EdgeInsets.all(25.0.h),
              child: MyButton(text: "Kampanyayı Başlat", onPressed: () async {

                SystemChannels.textInput.invokeMethod('TextInput.hide');
                await _changeLoadingVisible();
                try {
                  DocumentReference _reference = await FirebaseFirestore.instance.collection("anasayfa").doc();
                  DocumentReference _myreference = await FirebaseFirestore.instance.collection("charities").doc(_charitiesModel.user.userId).collection("yardim_kampanyalarim").doc(_reference.id);

                  Map<String, dynamic> etkinliklerim = Map();

                  etkinliklerim['bicim'] = "kampanya";
                  etkinliklerim['date'] = Timestamp.now();
                  etkinliklerim['foto'] = await uploadDuyuruImage(_reference.id);
                  etkinliklerim['icerik'] = _baslik.text;
                  etkinliklerim['kurumid'] = _charitiesModel.user.userId;
                  etkinliklerim['postid'] = _reference.id;
                  etkinliklerim['like'] = 0;
                  etkinliklerim['toplanan_tutar'] = 0;
                  etkinliklerim['tamamlandi'] = false;

                  _reference.set(etkinliklerim).then((value) async {
                    await _myreference.set(etkinliklerim);
                    var dialogBilgi = AlertBilgilendirme(
                      icerik: "İçeriğiniz paylaşıldı.",
                      Pressed: () {
                        Navigator.pop(context);
                      },
                    );

                    showDialog(
                        context: context,
                        builder: (BuildContext context) => dialogBilgi);

                    setState(() {
                      _icerik.clear();
                      _image=null;
                      _loadingVisible = false;
                    });
                  });

                }catch(e){
                  print(e);
                  var dialogBilgi = AlertBilgilendirme(
                    icerik: "İçerik paylaşılamadı üzgünüz. Lütfen tekrar deneyiniz... \n",
                    Pressed: () {
                      Navigator.pop(context);
                    },
                  );

                  showDialog(
                      context: context,
                      builder: (BuildContext context) => dialogBilgi);

                  setState(() {
                    _loadingVisible = false;
                    _baslik.clear();
                  });
                }


              }, textColor: Colors.white, fontSize: 16.0.spByWidth, width: 50.0.w, height: 55.0.h,butonColor: Colors.green,),
            ),

          ],
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

                  fontSize: 16,
                  color: Colors.grey,
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
