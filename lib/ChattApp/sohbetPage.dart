import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:yardimfeneri/ChattApp/chat_view_model.dart';
import 'package:yardimfeneri/ChattApp/chat_view_model_Yonetici.dart';
import 'package:yardimfeneri/extantion/size_extension.dart';
import 'package:timeago/timeago.dart' as timeago;
import 'package:yardimfeneri/model/mesaj.dart';


class SohbetPageHelpful extends StatefulWidget {
  final String fotourl;
  final String userad;
  final String userid;

  SohbetPageHelpful({ this.fotourl,this.userad,this.userid});
  @override
  _SohbetPageHelpfulState createState() => _SohbetPageHelpfulState();
}

class _SohbetPageHelpfulState extends State<SohbetPageHelpful> {
  var _mesajController = TextEditingController();
  ScrollController _scrollController = new ScrollController();
  bool _isLoading = false;
  DocumentSnapshot sohetsahibi;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _scrollController.addListener(_scrollListener);
  }


  @override
  Widget build(BuildContext context) {
    final _chatModel = Provider.of<ChatViewModel>(context);
    print("chat model: "+_chatModel.currentUser.userId.toString());
    print("chat model sohbet user : "+_chatModel.sohbetEdilenUser.userId.toString());
    return Scaffold(
      backgroundColor:  Colors.green,
      appBar: AppBar(
        title: Text("Sohbet"),
        elevation: 0.0,
        brightness: Brightness.dark,
        toolbarHeight: 60.0.h,
        backgroundColor: Colors.green,

      ),
      body: _sayfaYapisi(),
    );
  }
  Widget _sayfaYapisi(){
  return Container(
    width: MediaQuery.of(context).size.width,
    height: MediaQuery.of(context).size.height,

    decoration: BoxDecoration(
      borderRadius: BorderRadius.only(
          topLeft: Radius.circular(20.70),
          topRight: Radius.circular(20.70)),
      color: Colors.white,
      boxShadow: [
        BoxShadow(
            color: const Color(0x5c000000),
            offset: Offset(0, 0),
            blurRadius: 33.06,
            spreadRadius: 4.94)
      ],
    ),
    child: Center(
      child: Column(
        children: <Widget>[
          _buildMesajListesi(),
          _buildYeniMesajGir(),
        ],
      ),
    ),
  );

  }
  Widget _buildMesajListesi() {
    return Consumer<ChatViewModel>(builder:
        (context, chatModel, child) {
      return Expanded(
        child: ListView.builder(
          controller: _scrollController,
          reverse: true,
          itemBuilder: (context, index) {
            print("mesaj listesi:"+ chatModel.mesajlarListesi.length.toString());
            if (chatModel.hasMoreLoading && chatModel.mesajlarListesi.length == index) {
              return _yeniElemanlarYukleniyorIndicator();
            } else
              return _SohbetkonusmaBalonuOlustur(chatModel.mesajlarListesi[index],chatModel.mesajlarListesi[0].goruldumu);
          },
          itemCount: chatModel.hasMoreLoading
              ? chatModel.mesajlarListesi.length + 1
              : chatModel.mesajlarListesi.length,
        ),
      );
    });
  }

  Widget _buildYeniMesajGir() {
    final _chatModel = Provider.of<ChatViewModel>(context);
    return Container(
      padding: EdgeInsets.only(bottom: 8.0.h, left: 8.0.w, right:8.0.w),
      child: Row(
        children: <Widget>[

          Flexible(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(21.5.h)),
                  boxShadow: [
                    BoxShadow(color: const Color(0x47000000), offset: Offset(0, 2), blurRadius: 11, spreadRadius: 0)
                  ],
                  color: Theme.of(context).backgroundColor,
                ),
                child: TextField(
                  controller: _mesajController,
                  cursorColor: Colors.blueGrey,
                  style: new TextStyle(
                    fontSize: 16.0,
                    color: Colors.black,
                  ),
                  maxLines: 4,
                  minLines: 1,
                  decoration: InputDecoration(
                    focusedErrorBorder: InputBorder.none,
                    disabledBorder: InputBorder.none,
                    errorBorder: InputBorder.none,
                    focusedBorder: InputBorder.none,
                    enabledBorder: InputBorder.none,
                    fillColor: Colors.white,
                    filled: true,
                    hintText: "Mesajınızı Yazın",
                    border:  OutlineInputBorder(
                        borderRadius: new BorderRadius.circular(20.0),
                        borderSide: BorderSide.none),
                  ),
                ),
              ),
            ),
          ),
          GestureDetector(
            onTap: ()  async {

              print("kimden "+_chatModel.currentUser.toString());
              print("kime "+_chatModel.sohbetEdilenUser.userId.toString());
              if (_mesajController.text.trim().length > 0) {
                Mesaj _kaydedilecekMesaj =  new Mesaj(
                  kimden: _chatModel.currentUser.userId.toString(),
                  kime: _chatModel.sohbetEdilenUser.userId.toString(),
                  bendenMi: true,
                  goruldumu: false,
                  konusmaSahibi: _chatModel.currentUser.userId.toString(),
                  mesaj: _mesajController.text, date: Timestamp.now(),
                );
                _mesajController.clear();
                bool sonuc = await _chatModel.saveMessage(_kaydedilecekMesaj, _chatModel.currentUser);
                if (sonuc) {

                  _scrollController.animateTo(
                    0,
                    curve: Curves.easeOut,
                    duration: const Duration(milliseconds: 10),
                  );
                }
              }
            },
            child: Container(
              width: 42.0.w,
              height: 42.0.w,
              alignment: Alignment.center,
              decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  boxShadow: [
                    BoxShadow(
                        color: const Color(0x70000000), offset: Offset(1, 2), blurRadius: 8, spreadRadius: 0)
                  ],
                  color: Colors.green),
              child: Icon(
                Icons.send,
                color: Colors.black,
                size: 18.0.h,
              ),
            ),
          ),

        ],
      ),
    );
  }

  Widget _SohbetkonusmaBalonuOlustur(Mesaj oankiMesaj,bool sonmesajgorunme) {
    Color _gelenMesajRenk = Colors.blue;
    Color _gidenMesajRenk = Theme.of(context).primaryColor;
    final _chatModel = Provider.of<ChatViewModel>(context);
    var _saatDakikaDegeri = "";
    final icon = sonmesajgorunme ? Icon(Icons.done_all,color: Colors.blue,size: 16.0.h,) : oankiMesaj.goruldumu ? Icon(Icons.done_all,color: Colors.blue,size: 16.0.h,) : Icon(Icons.done,color: Colors.black38,size: 16.0.h,);

    try
    {
      _saatDakikaDegeri = _saatDakikaGoster(oankiMesaj.date);
    } catch (e)
    {
      print("hata var:" + e.toString());
    }

    var _benimMesajimMi = oankiMesaj.bendenMi;
    if (_benimMesajimMi)
    {
      return Padding(
        padding: EdgeInsets.symmetric(horizontal: 18.0.w, vertical: 6.2.h),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Container(),

            Column(
              children: [
                Container(
                  width: 206.66666666666666.w,
                  margin: EdgeInsets.only(left: 8.0.w),
                  padding: EdgeInsets.all(15.0),
                  decoration: BoxDecoration(
                      color: const Color(0xffcccdce),
                      borderRadius:  BorderRadius.only(
                          topRight: Radius.circular(15.0),
                          topLeft: Radius.circular(15.0),
                          bottomRight: Radius.circular(15.0)),
                         ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        oankiMesaj.mesaj.toString(),
                        style:  TextStyle(
                            color: const Color(0xff343633),
                            fontWeight: FontWeight.w400,
                            fontFamily: "OpenSans",
                            fontStyle: FontStyle.normal,
                            fontSize: 14.3.spByWidth),
                        textAlign: TextAlign.left,
                        overflow: TextOverflow.visible,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Text(
                             _saatDakikaGoster(oankiMesaj.date),
                              style:  TextStyle(
                                  color: const Color(0xff343633),
                                  fontFamily: "OpenSans",
                                  fontStyle: FontStyle.normal,
                                  fontSize: 13.3.spByWidth),
                              textAlign: TextAlign.right,
                              overflow: TextOverflow.visible),

                          Padding(
                            padding: const EdgeInsets.only(left: 3),
                            child: icon,
                          ),
                          SizedBox(
                            width: 8.0.w,
                          )
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ],
        ),
      );
    }
    else {
      return  Padding(
        padding: EdgeInsets.symmetric(horizontal: 18.0.w, vertical: 6.2.h),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [

            Column(
              children: [
                Container(
                  width: 206.66666666666666.w,
                  margin: EdgeInsets.only(left: 8.0.w),
                  padding: EdgeInsets.all(15.0),
                  decoration: BoxDecoration(
                      color: const Color(0xff91c4f2),
                      borderRadius:  BorderRadius.only(
                          topRight: Radius.circular(15.0),
                          topLeft: Radius.circular(15.0),
                          bottomLeft: Radius.circular(15.0))),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        oankiMesaj.mesaj.toString(),
                        style:  TextStyle(
                            color: const Color(0xff343633),
                            fontWeight: FontWeight.w400,
                            fontFamily: "OpenSans",
                            fontStyle: FontStyle.normal,
                            fontSize: 14.3.spByWidth),
                        textAlign: TextAlign.left,
                        overflow: TextOverflow.visible,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Text(
                              _saatDakikaGoster(oankiMesaj.date),
                              style:  TextStyle(
                                  color: const Color(0xff343633),
                                  fontWeight: FontWeight.w400,
                                  fontFamily: "OpenSans",
                                  fontStyle: FontStyle.normal,
                                  fontSize: 13.3.spByWidth),
                              textAlign: TextAlign.right,
                              overflow: TextOverflow.visible),

                          SizedBox(
                            width: 8.0.h,
                          )
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ],
        ),
      );
    }
  }



  String _saatDakikaGoster(Timestamp date) {
    initializeDateFormatting();
    var _formatterTime = DateFormat.Hm('tr_TR');
    var _formatterDate = DateFormat.yMd('tr_TR');
    var _formatlanmisTarih="";
    String time= timeago.format(date.toDate()).toString();

    if( time.contains("hours") || time.contains("minute") || time.contains("moment")  ){
      _formatlanmisTarih = _formatterTime.format(date.toDate());
    }else{
      _formatlanmisTarih = _formatterDate.format(date.toDate());
    }



    return _formatlanmisTarih;
  }

  void _scrollListener() {
    if (_scrollController.offset >=
        _scrollController.position.maxScrollExtent &&
        !_scrollController.position.outOfRange) {
      eskiMesajlariGetir();

      print("scroll listener oldu");
    }
  }

  void eskiMesajlariGetir() async {
    final _chatModel = Provider.of<ChatViewModel>(context,listen: false);
    if (_isLoading == false) {
      _isLoading = true;
      await _chatModel.dahaFazlaMesajGetir();
      _isLoading = false;
    }
  }

  _yeniElemanlarYukleniyorIndicator() {
    return Padding(
      padding: EdgeInsets.all(8),
      child: Center(
        child: CircularProgressIndicator(),
      ),
    );
  }
}
