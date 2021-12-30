import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import 'package:yardimfeneri/COMMON/alertinfo.dart';
import 'package:yardimfeneri/COMMON/loginscreenindicator.dart';
import 'package:yardimfeneri/COMMON/myButton.dart';
import 'package:yardimfeneri/UI/needy/yardim_istenecek_kurumlar.dart';
import 'package:yardimfeneri/common/resimlicard.dart';
import 'package:yardimfeneri/extantion/size_extension.dart';
import 'package:yardimfeneri/servis/charities_service.dart';
import 'package:yardimfeneri/servis/needy_service.dart';


class YardimTalebindeBulunma extends StatefulWidget {
  const YardimTalebindeBulunma({Key key}) : super(key: key);

  @override
  _YardimTalebindeBulunmaState createState() => _YardimTalebindeBulunmaState();
}

class _YardimTalebindeBulunmaState extends State<YardimTalebindeBulunma> {
  PickedFile _image;
  var imageUrl;
  final picker = ImagePicker();



  bool _loadingVisible = false;
  Future<void> _changeLoadingVisible() async {
    setState(() {
      _loadingVisible = !_loadingVisible;
    });
  }

  TextEditingController _icerik = new TextEditingController();


  @override
  Widget build(BuildContext context) {
    final _needyModel = Provider.of<NeedyService>(context, listen: true);

    return LoadingScreen(
      inAsyncCall: _loadingVisible,
      child: Scaffold(
        body: ListView(
          children: [
            SizedBox(height: 30.0.h,),
            Center(
              child: Text("Yardım Talebi", style: TextStyle(
                  fontSize: 26.0.spByWidth, fontWeight: FontWeight.bold, color: Colors.black),),
            ),
            SizedBox(height: 20.0.h,),
            _golgelitext("içerik", _icerik, 9,10),
            SizedBox(height: 10.0.h,),
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


            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [


                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: InkWell(
                    onTap: () async {
                      final value = await  Navigator.of(context).push(MaterialPageRoute(builder: (c) => YardimIstenecekKurumlar(),),);
                      print("value değeri: "+value.toString());
                      if(value!=null) {
                        if (etkinlikozelKatilimci.length==1)
                        {
                          etkinlikozelKatilimci.clear();
                        }
                        etkinlikozelKatilimci.add(value);
                      }
                      setState(() {

                      });
                    },
                    child: Container(
                      width: MediaQuery.of(context).size.width,
                      height: 40.0.h,
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.all(Radius.circular(11.70)),
                          boxShadow: [
                            BoxShadow(
                                color: const Color(0x26000000),
                                offset: Offset(0, 0),
                                blurRadius: 5.50,
                                spreadRadius: 0.5)
                          ],
                          color: Colors.white),
                      child: ListTile(
                        title: Text(
                          "Talep edilecek kurum",
                          style: TextStyle(
                              color: const Color(0xff343633),
                              fontWeight: FontWeight.w600,
                              fontFamily: "OpenSans",
                              fontStyle: FontStyle.normal,
                              fontSize: 16.7.h),
                        ),
                        trailing: Icon(Icons.arrow_forward_ios_outlined,size: 30,),
                      ),
                    ),
                  ),
                ),

                ListView.builder(
                  shrinkWrap: true,
                  physics: NeverScrollableScrollPhysics(),
                  itemCount: etkinlikozelKatilimci.length,
                  itemBuilder: (_, int index) {
                    return Slidable(
                      actionPane: SlidableDrawerActionPane(),
                      actionExtentRatio: 0.45,
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 7.0),
                        child: InkWell(
                          onTap: () async {
                            final value = await Navigator.of(context).push(MaterialPageRoute(builder: (c) => YardimIstenecekKurumlar(),),);
                            print("value değeri: "+value.toString());
                            if(value!=null)
                            {
                              if (etkinlikozelKatilimci.length==1)
                              {
                                etkinlikozelKatilimci.clear();
                              }
                              etkinlikozelKatilimci.add(value);
                            }
                            setState(() {

                            });
                          },
                          child: Container(
                            width: MediaQuery.of(context).size.width,
                            height: 60.0.h,
                            alignment: Alignment.center,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.all(Radius.circular(11.70)),
                                boxShadow: [
                                  BoxShadow(
                                      color: const Color(0x26000000),
                                      offset: Offset(0, 0),
                                      blurRadius: 5.50,
                                      spreadRadius: 0.5)
                                ],
                                color: Colors.white),
                            child: ListTile(
                              title: Text(
                                etkinlikozelKatilimci[index]['isim'].toString(),
                                style: TextStyle(
                                    color: const Color(0xff343633),
                                    fontWeight: FontWeight.w600,
                                    fontFamily: "OpenSans",
                                    fontStyle: FontStyle.normal,
                                    fontSize: 16.7.h),
                              ),
                              leading: CircleAvatar(
                                backgroundImage: NetworkImage(
                                  etkinlikozelKatilimci[index]['logo'].toString(),
                                ),
                                radius: 26.0,
                              ),
                            ),
                          ),
                        ),
                      ),
                      secondaryActions: <Widget>[
                        Container(
                          height: 70.0.h,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.all(Radius.circular(20.70)),
                          ),
                          child: IconSlideAction(
                              caption: 'Sil',
                              color: Colors.red,
                              icon: Icons.delete,
                              onTap: () async {
                                etkinlikozelKatilimci.removeAt(index);
                                setState(() {});
                              }),
                        ),
                      ],
                    );
                  },
                ),
              ],
            ),
            SizedBox(height: 10.0.h,),
            Padding(
              padding:  EdgeInsets.all(25.0.h),
              child: MyButton(text: "Gönder", onPressed: () async {
                SystemChannels.textInput.invokeMethod('TextInput.hide');
                await _changeLoadingVisible();
                try {
                  DocumentReference _reference = await FirebaseFirestore.instance
                      .collection("charities").doc(etkinlikozelKatilimci[0]['userID'].toString())
                      .collection("ihtiyac_sahipleri_yardim_istekleri").doc(_needyModel.user.userId);

                  Map<String, dynamic> talep = Map();

                  talep['date'] = Timestamp.now();
                  talep['foto'] = await uploadDuyuruImage(_reference.id);
                  talep['mesaj'] = _icerik.text;
                  talep['userid'] = _needyModel.user.userId;
                  talep['yardim_id'] = _reference.id;

                  _reference.set(talep).then((value) {
                    var dialogBilgi = AlertBilgilendirme(
                      icerik: "Talep Gönderildi.",
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
                      etkinlikozelKatilimci.clear();
                      _loadingVisible = false;
                    });
                  });

                }catch(e){
                  print(e);
                  var dialogBilgi = AlertBilgilendirme(
                    icerik: "Talep gönderilemedi üzgünüz. Lütfen tekrar deneyiniz... \n",
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
            SizedBox(height: 150.0.h,),

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


}
