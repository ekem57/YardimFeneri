import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:yardimfeneri/ChattApp/chat_view_model.dart';
import 'package:yardimfeneri/ChattApp/mesajkisiSec.dart';
import 'package:yardimfeneri/ChattApp/sohbetPage.dart';
import 'package:yardimfeneri/ChattApp/alluserModel.dart';
import 'package:yardimfeneri/extantion/size_extension.dart';
import 'package:yardimfeneri/model/konusma.dart';

import 'mesaj_kisi_sec_firebase.dart';

class MesajlarimAnasayfa extends StatefulWidget {
  @override
  _MesajlarimAnasayfaState createState() => _MesajlarimAnasayfaState();
}

class _MesajlarimAnasayfaState extends State<MesajlarimAnasayfa> {
  bool _isLoading = false;
  ScrollController _scrollController = ScrollController();
  bool isSearching = false;
  List<DocumentSnapshot> totalUsers = [];
  List data=[];
  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_listeScrollListener);
  }



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor:  Colors.white,
        title: !isSearching
            ? Text("Kişi Seç",
            style: TextStyle(
                color: Colors.black,
                fontWeight: FontWeight.w700,
                fontFamily: "OpenSans",
                fontStyle: FontStyle.normal,
                fontSize: 21.7.spByWidth),
            textAlign: TextAlign.center)
            : TextField(

          style: TextStyle(color: Colors.white),
          decoration: InputDecoration(
              icon: Icon(
                Icons.search,
                color: Colors.white,
              ),
              hintText: "Arayınız...",
              hintStyle: TextStyle(color: Colors.white)),
        ),

        elevation: 0.0,
        brightness: Brightness.light,
        // status bar brightness
        actions: <Widget>[
          isSearching
              ? IconButton(
            icon: Icon(Icons.cancel,color: Colors.blue,),
            onPressed: () {
              // totalUsers=[];
              setState(() {
                isSearching = false;
                userBloc.userController.sink.add(null);

              });


            },
          )
              : IconButton(
            icon: Icon(Icons.search,color: Colors.blue,),
            onPressed: () {
              // totalUsers=[];
              setState(() {
                isSearching = true;

              });



            },
          )
        ],
      ),
      floatingActionButton:  Padding(
        padding: const EdgeInsets.only(bottom: 80),
        child: FloatingActionButton(
          onPressed: () {
            Navigator.of(context, rootNavigator: true).push(
              MaterialPageRoute(builder: (context) => ChattKisiSec()),
            );
          },
          child: Icon(
            Icons.add,
            size: 30.0,
            color: const Color(0xff343633),
          ),
        ),
      ),
      body: Consumer<AllUserViewModel>(
        builder: (context, model, child) {
          if (model.state == AllUserViewState.Busy || _isLoading) {
            return Center(
              child: CircularProgressIndicator(),
            );

          } else if (model.state == AllUserViewState.Loaded) {
            return RefreshIndicator(
            //  onRefresh: model.refresh,
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
                    return _userListeElemaniOlustur(index,model.tumKonusma);
                  }
                },
                itemCount: model.hasMoreLoading
                    ? model.kullanicilarListesi.length +1
                    : model.kullanicilarListesi.length,
              ),
            );
          } else {
            return Container();
          }
        },
      ),
    );
  }

  Widget _kullaniciYokUi() {
    final _kullanicilarModel = Provider.of<AllUserViewModel>(context,listen: false);
    return RefreshIndicator(
     // onRefresh: _kullanicilarModel.refresh,
      child: SingleChildScrollView(
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
                  style: TextStyle(fontSize: 36.0.spByWidth),
                )
              ],
            ),
          ),
          height: MediaQuery.of(context).size.height - 150,
        ),
      ),
    );
  }

  Widget _userListeElemaniOlustur(int index ,List<Konusma> konusmalar) {
    final _userModel = Provider.of<UserModel>(context);
    final _tumKullanicilarViewModel = Provider.of<AllUserViewModel>(context);
    var _oankiUser = _tumKullanicilarViewModel.kullanicilarListesi[index];


      print("konusmalar "+ (konusmalar[index].sonOkunmaZamani.toDate().subtract(Duration(days: 1)).millisecond > DateTime.now().millisecond).toString());

    return Padding(
      padding:
      const EdgeInsets.symmetric(horizontal: 21.0, vertical: 7.0),
      child: GestureDetector(
        onTap: () {
          Navigator.of(context, rootNavigator: true).push(
            MaterialPageRoute(
              builder: (context) => ChangeNotifierProvider(
                create: (context) => ChatViewModel(currentUser: _userModel.user, sohbetEdilenUser: _oankiUser),
                child: SohbetPage(fotourl: _oankiUser.foto,userad: _oankiUser.isim,userid: _oankiUser.userId,),
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
              color: Theme.of(context).backgroundColor),
          child: ListTile(
            title: Container(
              width: MediaQuery.of(context).size.width-200,
              child: Text(
                _oankiUser.isim,
                style: TextStyle(
                    color: const Color(0xff343633),
                    fontWeight: FontWeight.w600,
                    fontFamily: "OpenSans",
                    fontStyle: FontStyle.normal,
                    fontSize: 16.7.h),
                overflow: TextOverflow.visible,
                maxLines: 1,
              ),
            ),
            leading: CircleAvatar(
              backgroundImage: NetworkImage(_oankiUser.foto),
              radius: 26.0,
            ),
            trailing: Padding(
              padding: EdgeInsets.only(top: 4.0.h),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Text(
                    konusmalar[index].sonOkunmaZamani.toDate().millisecond > DateTime.now().millisecond
                        ? formatTheDate(konusmalar[index].sonOkunmaZamani.toDate(),format: DateFormat("HH:ss", "tr_TR"))
                        : formatTheDate(konusmalar[index].sonOkunmaZamani.toDate()),

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
            subtitle: Text(
                konusmalar[index].son_yollanan_mesaj,
              style: TextStyle(
                  color: const Color(0xff343633),
                  fontWeight: FontWeight.w400,
                  fontFamily: "OpenSans",
                  fontStyle: FontStyle.normal,
                  fontSize: 15.3.h),
              overflow: TextOverflow.ellipsis,
            ),
          ),
        ),
      ),
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
      final _tumKullanicilarViewModel = Provider.of<AllUserViewModel>(context);
      await _tumKullanicilarViewModel.dahaFazlaUserGetir();
      _isLoading = false;
    }
  }

  void _listeScrollListener() {
    if (_scrollController.offset >= _scrollController.position.maxScrollExtent && !_scrollController.position.outOfRange) {
      print("Listenin en altındayız");
      dahaFazlaKullaniciGetir();
    }
  }
}
