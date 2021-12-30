import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import 'package:yardimfeneri/UI/odeme/odeme_sayfasi.dart';
import 'package:yardimfeneri/common/alertinfo.dart';
import 'package:yardimfeneri/common/myButton.dart';
import 'package:yardimfeneri/extantion/size_extension.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import 'package:yardimfeneri/servis/charities_service.dart';
import 'package:yardimfeneri/servis/needy_service.dart';

class YardimaIhtiyacKampanyaKatilimNeedy extends StatefulWidget {
  String yardim_id;
  String kurum;
  String kampanya_ismi;
  String bagis;
  YardimaIhtiyacKampanyaKatilimNeedy({Key key, this.yardim_id, this.kurum,this.bagis, this.kampanya_ismi}) : super(key: key);


  @override
  _YardimaIhtiyacKampanyaKatilimNeedyState createState() => _YardimaIhtiyacKampanyaKatilimNeedyState();
}

class _YardimaIhtiyacKampanyaKatilimNeedyState extends State<YardimaIhtiyacKampanyaKatilimNeedy> {
  PickedFile _image;
  var imageUrl;
  final picker = ImagePicker();

  bool _loadingVisible = false;
  Future<void> _changeLoadingVisible() async {
    setState(() {
      _loadingVisible = !_loadingVisible;
    });
  }

  TextEditingController _destek = new TextEditingController();
  TextEditingController _mesaj = new TextEditingController();


  @override
  Widget build(BuildContext context) {
    final _needyModel = Provider.of<NeedyService>(context, listen: true);

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        iconTheme: IconThemeData(color: Colors.black),
      ),
      body: ListView(
        children: [
          SizedBox(height: 30.0.h,),
          Center(
            child: Text("Kampanya Destek", style: TextStyle(
                fontSize: 26.0.spByWidth, fontWeight: FontWeight.bold, color: Colors.black),),
          ),
          SizedBox(height: 20.0.h,),
          _golgelitextpara("Destek Miktarı", _destek, 1,10),
          SizedBox(height: 20.0.h,),
          _golgelitext("Mesajınız", _mesaj, 9,10),
          SizedBox(height: 20.0.h,),
          Padding(
            padding:  EdgeInsets.all(25.0.h),
            child: MyButton(text: "Destek Ol", onPressed: () async {

              Map<String, dynamic> destek = Map();

              destek['userid'] = _needyModel.user.userId;
              destek['isim'] = _needyModel.user.isim;
              destek['soyisim'] = _needyModel.user.soyisim;
              destek['date'] = Timestamp.now();
              destek['mesaj'] = _mesaj.text;
              destek['bagis_miktari'] = int.parse(_destek.text);
              destek['yardim_id'] = widget.yardim_id;
              destek['kurumid'] = widget.kurum;


              Navigator.push(context, MaterialPageRoute(builder: (context) =>PaymentPage(destek: destek,bagis: widget.bagis,)),);


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
    File file = File(filePath);
    try {
      await firebase_storage.FirebaseStorage.instance.ref('anasayfa/icerik/$id').putFile(file);
      String downloadURL =
      await firebase_storage.FirebaseStorage.instance.ref('anasayfa/icerik/$id').getDownloadURL();
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

  Widget _golgelitextpara(String _text,TextEditingController control,int satir,double paddingtop) {
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
                keyboardType: TextInputType.number,
                inputFormatters: <TextInputFormatter>[
                  FilteringTextInputFormatter.digitsOnly
                ], // Only numbers
                style: TextStyle(
                  fontSize: 16,
                  color: Colors.grey,
                ),
                cursorColor: Colors.blue,
                decoration: InputDecoration(
                    contentPadding: EdgeInsets.only(left: 15,top: 0),
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
