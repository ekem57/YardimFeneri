import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:yardimfeneri/ChattApp/SohbetPageYonetici.dart';
import 'package:yardimfeneri/ChattApp/alluserModel-Needy-Charities.dart';
import 'package:yardimfeneri/ChattApp/alluserModelYonetici.dart';
import 'package:yardimfeneri/ChattApp/chat_view_model_Needy_Charities.dart';
import 'package:yardimfeneri/ChattApp/chat_view_model_Yonetici.dart';
import 'package:yardimfeneri/ChattApp/mesajkisiSec.dart';
import 'package:yardimfeneri/ChattApp/sohbetpageNeedy_Charities.dart';
import 'package:yardimfeneri/extantion/size_extension.dart';
import 'package:yardimfeneri/model/konusma.dart';
import 'package:timeago/timeago.dart' as timeago;
import 'package:yardimfeneri/servis/needy_service.dart';


class NeedyChat extends StatefulWidget {
  @override
  _NeedyChatState createState() => _NeedyChatState();
}

class _NeedyChatState extends State<NeedyChat> {
  bool isSearching = false;
  List<Konusma> totalKonusma = [];
  List data=[];
  bool _isLoading = false;
  bool _isyenikullanici = false;
  ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    setState(() {

    });
  }


  Widget usersWidget() {

    final _kullanicilarModel = Provider.of<AllUserViewModelNeedy_Charities>(context);

    if (_kullanicilarModel.tumKonusma.length> _kullanicilarModel.kullanicilarListesi.length) {
      _kullanicilarModel.refresh();
      setState(() {
        _isyenikullanici=true;
      });
    }

    return Consumer<AllUserViewModelNeedy_Charities>(
      builder: (context, AllUserViewModelNeedy_Charities model, child) {
        if (model.state == AllUserViewStateNeedy_Charities.Busy || _isLoading) {
          return Center(
            child: CircularProgressIndicator(),
          );

        } else if (model.state == AllUserViewStateNeedy_Charities.Loaded) {
          return RefreshIndicator(
            onRefresh: model.refresh,
            child: ListView.builder(
              controller: _scrollController,
              itemBuilder: (context, index) {

                if (model.kullanicilarListesi.length == 0) {
                  return _kullaniciYokUi();
                } else if (model.hasMoreLoading && index == model.kullanicilarListesi.length) {
                  return _yeniElemanlarYukleniyorIndicator();
                }
                else if (model.tumKonusma.isEmpty) {
                  return _yeniElemanlarYukleniyorIndicator();
                }

                else {

                  return _userListeElemaniOlustur(index, model.tumKonusma);
                }
              },
              itemCount: model.tumKonusma.length,
            ),
          );
        } else {
          return Container();
        }
      },
    );
  }



  Widget _userListeElemaniOlustur(int index ,List<Konusma> konusmalar) {
    final _ogretmenModel = Provider.of<NeedyService>(context, listen: true);
    final _tumKullanicilarViewModel = Provider.of<AllUserViewModelNeedy_Charities>(context);
    var _oankiUser = _tumKullanicilarViewModel.kullanicilarListesi[index];
    print("emree");

    return  _ogretmenModel.user.userId == _oankiUser.userId ? Container() :

    Slidable(
      actionPane: SlidableDrawerActionPane(),
      actionExtentRatio: 0.45,
      child: Padding(
        padding:
        EdgeInsets.symmetric(horizontal: 21.0.w, vertical: 7.0.h),
        child: GestureDetector(
          onTap: () {

            Navigator.of(context, rootNavigator: true).push(
              MaterialPageRoute(
                builder: (context) => ChangeNotifierProvider(
                  create: (context) => ChatViewModelNeedy_Charities(currentUser: _ogretmenModel.user, sohbetEdilenUser: _oankiUser),
                  child: SohbetPageNeedy_Charities(fotourl: _oankiUser.logo,userad: _oankiUser.isim,userid: _oankiUser.userId,),
                ),
              ),
            );
          },
          child: Container(
            width: 323.3333333333333.w,
            height: 66.0.h,
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
                _oankiUser.isim.toString(),
                style: TextStyle(
                    color: const Color(0xff343633),
                    fontWeight: FontWeight.w600,
                    fontFamily: "OpenSans",
                    fontStyle: FontStyle.normal,
                    fontSize: 16.7.h),
                overflow: TextOverflow.visible,
                maxLines: 1,
              ),


              trailing: Padding(
                padding: EdgeInsets.only(top: 4.0.h),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Text(
                      konusmalar[index].sonOkunmaZamani != null ?  _saatDakikaGoster(konusmalar[index].sonOkunmaZamani):"",

                      style: TextStyle(
                          color: const Color(0xff343633),
                          fontWeight: FontWeight.w400,
                          fontFamily: "Arial",
                          fontStyle: FontStyle.normal,
                          fontSize: 12.3.h),
                    ),
                  ],
                ),
              ),


              subtitle:  konusmalar[index].goruldu ? Text(
                konusmalar[index].son_yollanan_mesaj.toString(),
                style: TextStyle(
                    color: const Color(0xff343633),
                    fontWeight: FontWeight.w400,
                    fontFamily: "OpenSans",
                    fontStyle: FontStyle.normal,
                    fontSize: 15.3.h),
                overflow: TextOverflow.ellipsis,
              ) : Text(
                konusmalar[index].son_yollanan_mesaj.toString(),
                style:  TextStyle(
                    color: const Color(0xff343633),
                    fontWeight: FontWeight.bold,
                    fontFamily: "OpenSans",
                    fontStyle: FontStyle.normal,
                    fontSize: 15.3.h) ,
                overflow: TextOverflow.ellipsis,
              ),
            ),
          ),
        ),
      ),
      secondaryActions: <Widget>[

        Container(
          height: 70,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.all(Radius.circular(20.70)),

          ),
          child: IconSlideAction(
              caption: 'Sil',
              color: Colors.red,
              icon: Icons.delete,
              onTap: () async {
                FirebaseFirestore.instance.collection("helpful").doc(_ogretmenModel.user.userId).collection("sohbetler").doc(_oankiUser.userId).delete();
              }
          ),
        ),
      ],
    );

  }



  _yeniElemanlarYukleniyorIndicator() {
    return Padding(
      padding: EdgeInsets.all(8),
      child: Center(
        child: CircularProgressIndicator(),
      ),
    );
  }

  void dahaFazlaKullaniciGetir() async {
    if (_isLoading == false) {
      _isLoading = true;
      final _tumKullanicilarViewModel = Provider.of<AllUserViewModelNeedy_Charities>(context);
      await _tumKullanicilarViewModel.dahaFazlaUserGetir();
      _isLoading = false;
    }
  }

  void _listeScrollListener() {
    if (_scrollController.offset >= _scrollController.position.maxScrollExtent && !_scrollController.position.outOfRange) {
      print("Listenin en altındayız");
      // dahaFazlaKullaniciGetir();
    }
  }

  Widget _kullaniciYokUi() {
    return SingleChildScrollView(
      physics: AlwaysScrollableScrollPhysics(),
      child: Container(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Icon(
                Icons.supervised_user_circle,
                color: Theme.of(context).primaryColor,
                size: 120,
              ),
              Text(
                "Henüz Kullanıcı Yok",
                style: TextStyle(fontSize: 36),
              )
            ],
          ),
        ),
        height: MediaQuery.of(context).size.height - 150,
      ),
    );
  }

  String _saatDakikaGoster(Timestamp date) {
    initializeDateFormatting();
    var _formatterTime = DateFormat.Hm('tr_TR');
    var _formatterDate = DateFormat.yMd('tr_TR');
    var _formatlanmisTarih="";
    String time= timeago.format(date.toDate()).toString();

    if( time.contains("hours") || time.contains("minute")  ){
      _formatlanmisTarih = _formatterTime.format(date.toDate());
    }else{
      _formatlanmisTarih = _formatterDate.format(date.toDate());
    }

    return _formatlanmisTarih;
  }

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      backgroundColor: Colors.green,
      appBar: AppBar(
        backgroundColor:  Colors.white,
        title: Text("Mesajlarım",
          style: TextStyle(
              color: Colors.black,
              fontWeight: FontWeight.w700,
              fontFamily: "OpenSans",
              fontStyle: FontStyle.normal,
              fontSize: 21.7.spByWidth),
        ),

        elevation: 0.0,
        brightness: Brightness.light,
        automaticallyImplyLeading: false,
        // status bar brightness

      ),
      /*
      floatingActionButton:  Padding(
        padding: const EdgeInsets.only(bottom: 80),
        child: FloatingActionButton(
          onPressed: () {

            Navigator.of(context, rootNavigator: true).push(MaterialPageRoute(builder: (context) => ChattKisiSecHelpful()),);
          },
          child: Icon(
            Icons.add,
            size: 30.0.w,
            color: const Color(0xff343633),
          ),
        ),
      ),
      
       */
      body: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        color: Colors.white,
        child: usersWidget(),
      ),
    );
  }
}
