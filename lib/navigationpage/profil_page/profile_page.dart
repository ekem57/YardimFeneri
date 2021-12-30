import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:yardimfeneri/UI/helpful/profil_settings.dart';
import 'package:yardimfeneri/UI/helpful/yardimettigiinsanlar.dart';
import 'package:yardimfeneri/model/helpful_model.dart';
import 'package:yardimfeneri/navigationpage/profil_page/profile_widget.dart';
import 'package:yardimfeneri/servis/helpful_service.dart';
import 'appbar_page.dart';
import 'button.dart';
import 'number_widget.dart';

class ProfilPageHelpful extends StatefulWidget {
  const ProfilPageHelpful({Key key}) : super(key: key);

  @override
  _ProfilPageHelpfulState createState() => _ProfilPageHelpfulState();
}

class _ProfilPageHelpfulState extends State<ProfilPageHelpful> {
  @override
  Widget build(BuildContext context) {
    final _helpfulService = Provider.of<HelpfulService>(context, listen: true);
    return Scaffold(
      appBar: buildAppBar(context),
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

  Widget buildName(HelpfulModel _user) => Column(
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

  Widget buildUpgradeButton(HelpfulModel user) => ButtonWidget(
    text: 'Profilimi Düzenle',
    onClicked: () {
      setState(() {
        Navigator.of(context).push(MaterialPageRoute(builder: (context) => ProfilSettings(user: user,)));
      });

    },
  );

  Widget buildAbout(HelpfulModel _user) => Container(
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