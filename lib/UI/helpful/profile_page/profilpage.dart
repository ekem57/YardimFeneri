import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:yardimfeneri/COMMON/myButton.dart';
import 'package:yardimfeneri/SERVICE/helpful_service.dart';
import 'package:yardimfeneri/UI/helpful/profile_page/profile_widget.dart';
import 'package:yardimfeneri/model/helpful_model.dart';

import '../yardimettigiinsanlar.dart';
import 'appbar_page.dart';
import 'button.dart';
import 'number_widget.dart';

class ProfilPageHelpful extends StatefulWidget {
  const ProfilPageHelpful({Key? key}) : super(key: key);

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
            imagePath: "assets/alican.jpg" ,
            onClicked: () async {},
          ),
          const SizedBox(height: 24),
          buildName(),
          const SizedBox(height: 24),
          Center(child: buildUpgradeButton()),
          const SizedBox(height: 24),
          NumbersWidget(),
          const SizedBox(height: 48),
          buildAbout(),

        ],
      ),
    );
  }

  Widget buildName() => Column(
    children: [
      Text(
        "Alican KESEN",
        style: TextStyle(fontWeight: FontWeight.bold, fontSize: 24),
      ),
      const SizedBox(height: 4),
      Text(
        "942alicankesen@gmail.com",
        style: TextStyle(color: Colors.grey),
      )
    ],
  );

  Widget buildUpgradeButton() => ButtonWidget(
    text: 'Bağışlarım',
    onClicked: () {
      setState(() {
        YardimEttigiInsanlar();
      });

    },
  );

  Widget buildAbout() => Container(
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
        "Lorem Ipsum, dizgi ve baskı endüstrisinde kullanılan mıgır metinlerdir."
            " Lorem Ipsum, adı bilinmeyen bir matbaacının bir hurufat numune kitabı"
            "oluşturmak üzere bir yazı galerisini alarak karıştırdığı 1500'lerden beri endüstri standardı"
            " sahte metinler olarak kullanılmıştır.",
          style: TextStyle(fontSize: 16, height: 1.4),
        ),
      ],
    ),
  );
  }

Widget? _getBody(int index) {
  switch (index) {
    case 0:
      return YardimEttigiInsanlar();
  }
}