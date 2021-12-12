import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:yardimfeneri/COMMON/myButton.dart';
import 'package:yardimfeneri/EXTENSIONS/size_extension.dart';
import 'package:yardimfeneri/SERVICE/helpful_service.dart';

class YardimEttigiInsanlar extends StatefulWidget {
  const YardimEttigiInsanlar({Key? key}) : super(key: key);

  @override
  _YardimEttigiInsanlarState createState() => _YardimEttigiInsanlarState();
}

class _YardimEttigiInsanlarState extends State<YardimEttigiInsanlar> {
  @override
  Widget build(BuildContext context) {
    final _helpfulService = Provider.of<HelpfulService>(context, listen: true);
    return Scaffold(
    appBar:  AppBar(
      brightness: Brightness.light,
      backgroundColor: Colors.grey.shade300,
      elevation: 0.0,
      iconTheme: new IconThemeData(color: Colors.black),
      title: Text(
        "Yardım Ettiğin İnsanlar",
        style: TextStyle(
            fontSize: 25.0.spByWidth,
            fontWeight: FontWeight.bold,
            color: Colors.black),
      ),
    ),
      body: Padding(
        padding: const EdgeInsets.all(15.0),
        child: Center(
          child: SingleChildScrollView(
            child: Column(
              children: [
                needyCard(
                  imagePath: "assets/alican.jpg",
                  username: "Alican Kesen",
                  userCity: "Konya",
                  donation: "500 TL bağışlandı!",
                ),
            needyCard(
                  imagePath: "assets/ortak_avatar.png",
                  username: "Alican Kesen",
                  userCity: "Konya",
                  donation: "500 TL bağışlandı!",
                ),
            needyCard(
                  imagePath: "assets/alican.jpg",
                  username: "Alican Kesen",
                  userCity: "Konya",
                  donation: "500 TL bağışlandı!",
                ),
                needyCard(
                  imagePath:  "assets/ortak_avatar.png",
                  username:"Emre Ekşisu",
                  userCity: "İstanbul",
                  donation: "1500 TL bağışlandı!"
                ),
                needyCard(
                    imagePath: "assets/alican.jpg",
                    username:"Fırat Yorulmaz",
                    userCity: "Ankara",
                    donation: "250 TL",
                ),
                needyCard(
                  imagePath:  "assets/ortak_avatar.png",
                  username: "Alican Kesen",
                  userCity: "Konya",
                  donation: "500 TL bağışlandı!",
                ),
                needyCard(
                  imagePath: "assets/alican.jpg",
                  username: "Alican Kesen",
                  userCity: "Konya",
                  donation: "500 TL bağışlandı!",
                ),
                needyCard(
                  imagePath: "assets/alican.jpg",
                  username: "Alican Kesen",
                  userCity: "Konya",
                  donation: "500 TL bağışlandı!",
                ),

              ],
            ),
          ),
        ),
      ),
    );
  }
}

Widget needyCard({String? username, String? userCity, String? donation, String? imagePath}){
  return  Padding(
    padding: const EdgeInsets.all(8.0),
    child: Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: Colors.white,
          boxShadow: [
            BoxShadow(
              offset: Offset(1,1),
              blurRadius: 2,
              spreadRadius: 3,
              color: Colors.grey,
            ),
          ]
      ),
      child: Row(
        children: [
          Padding(
            padding: const EdgeInsets.all(15.0),
            child: ClipOval(
              child: Image.asset(imagePath!,
                  height: 100,
                  width: 100,
                  fit: BoxFit.cover
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left:10.0,),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children:  [
                Text(username!, style: TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                  fontSize: 20,
                ),
                ),
                 Text(userCity!, style: TextStyle(
                  color: Colors.black,
                  fontSize: 15,
                ),
                  textAlign: TextAlign.left,
                ),
                SizedBox(height: 10,),
                ElevatedButton(
                  onPressed: (){},
                  style: ElevatedButton.styleFrom(
                    shape: StadiumBorder(),
                    onPrimary: Colors.white,
                    padding: EdgeInsets.symmetric(horizontal: 50, vertical: 8),
                  ),
                  child: Text(donation!, style: TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.bold,
                  ),),

                ),

              ],
            ),
          ),
        ],
      ),
    ),
  );
}
