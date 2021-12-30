import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:yardimfeneri/UI/helpful/profil_settings.dart';
import 'package:yardimfeneri/UI/helpful/yardimettigiinsanlar.dart';
import 'package:yardimfeneri/UI/needy/profil_settings_needy.dart';
import 'package:yardimfeneri/model/helpful_model.dart';
import 'package:yardimfeneri/model/needy_model.dart';
import 'package:yardimfeneri/navigationpage/profil_page/appbar_page.dart';
import 'package:yardimfeneri/navigationpage/profil_page/button.dart';
import 'package:yardimfeneri/navigationpage/profil_page/profile_widget.dart';
import 'package:yardimfeneri/servis/helpful_service.dart';
import 'package:yardimfeneri/servis/needy_service.dart';


class ProfilPageNeedy extends StatefulWidget {
  const ProfilPageNeedy({Key key}) : super(key: key);

  @override
  _ProfilPageNeedyState createState() => _ProfilPageNeedyState();
}

class _ProfilPageNeedyState extends State<ProfilPageNeedy> {
  @override
  Widget build(BuildContext context) {
    final _helpfulService = Provider.of<NeedyService>(context, listen: true);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        actions: [
          IconButton(
            icon: Icon(Icons.exit_to_app),
            color: Colors.black,
            iconSize:40,
            onPressed: () {
              _helpfulService.signOut();
            },
          ),
        ],
      ),
      body: ListView(
        physics: BouncingScrollPhysics(),
        children: [
          ProfileWidget(
            imagePath: _helpfulService.user.foto,
            onClicked: () async {},
          ),
          const SizedBox(height: 24),
          buildName(_helpfulService.user),
          const SizedBox(height: 24),
          Center(child: buildUpgradeButton(_helpfulService.user)),
          const SizedBox(height: 48),
          buildAbout(_helpfulService.user),

        ],
      ),
    );
  }

  Widget buildName(NeedyModel _user) => Column(
    children: [
      Text(
        _user.isim+" "+_user.soyisim,
        style: TextStyle(fontWeight: FontWeight.bold, fontSize: 24),
      ),
      const SizedBox(height: 4),
      Text(
        _user.email,
        style: TextStyle(color: Colors.grey),
      )
    ],
  );

  Widget buildUpgradeButton(NeedyModel user) => ButtonWidget(
    text: 'Profilimi Düzenle',
    onClicked: () {
      setState(() {
        Navigator.of(context).push(MaterialPageRoute(builder: (context) => ProfilSettingsNeedy(user: user,)));
      });

    },
  );

  Widget buildAbout(NeedyModel _user) => Container(
    padding: EdgeInsets.symmetric(horizontal: 48),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Hakkında',
          style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 16),
        Text(
          _user.hakkimda,
          style: TextStyle(fontSize: 16, height: 1.4),
        ),
      ],
    ),
  );
}

Widget _getBody(int index) {
  switch (index) {
    case 0:
      return YardimEttigiInsanlar();
  }
}