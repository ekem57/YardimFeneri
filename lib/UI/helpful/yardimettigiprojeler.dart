import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:yardimfeneri/COMMON/myButton.dart';
import 'package:yardimfeneri/EXTENSIONS/size_extension.dart';
import 'package:yardimfeneri/SERVICE/helpful_service.dart';

class YardimEttigiProjeler extends StatefulWidget {

  const YardimEttigiProjeler({Key? key,}) : super(key: key);

  @override
  _YardimEttigiProjelerState createState() => _YardimEttigiProjelerState();
}

class _YardimEttigiProjelerState extends State<YardimEttigiProjeler> {
  @override
  Widget build(BuildContext context) {
    final _helpfulService = Provider.of<HelpfulService>(context, listen: true);
    return Scaffold(
      appBar: AppBar(
        brightness: Brightness.light,
        backgroundColor: Colors.grey.shade300,
        elevation: 0.0,
        iconTheme: new IconThemeData(color: Colors.black),
        title: Text(
          "Yardım Ettiğin Projeler",
          style: TextStyle(
              fontSize: 25.0.spByWidth,
              fontWeight: FontWeight.bold,
              color: Colors.black),
        ),
      ),
      body:  Center(
        child: Container(
          child: SingleChildScrollView(
            child: Column(
              children: <Widget>[
                Padding(
                  padding: EdgeInsets.all(10),
                ),
                charityCard(
                  charityName: "KIZILAY",
                  imagePath: "assets/kizilay.png",
                  campaign: "Bir yardımda sen bulun!",
                  donation: "500 TL bağışlandı!"
                ),
                charityCard(
                    charityName: "YEŞİLAY",
                    imagePath: "assets/yesilay.jpg",
                    campaign: "Bir yardımda sen bulun!",
                    donation: "500 TL bağışlandı!"
                ),
                charityCard(
                    charityName: "AFAD",
                    imagePath: "assets/afad.jpg",
                    campaign: "Bir yardımda sen bulun!",
                    donation: "500 TL bağışlandı!"
                ),

               charityCard(
                  charityName: "KIZILAY",
                  imagePath: "assets/kizilay.png",
                  campaign: "Bir yardımda sen bulun!",
                  donation: "500 TL bağışlandı!"
                ),
                charityCard(
                    charityName: "YEŞİLAY",
                    imagePath: "assets/yesilay.jpg",
                    campaign: "Bir yardımda sen bulun!",
                    donation: "500 TL bağışlandı!"
                ),
                charityCard(
                    charityName: "AFAD",
                    imagePath: "assets/afad.jpg",
                    campaign: "Bir yardımda sen bulun!",
                    donation: "500 TL bağışlandı!"
                ),

              ],
            ),
          ),
        ),
      ),
    );
  }
}

Widget charityCard({String? charityName, String? campaign, String? imagePath, String? donation}){
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
                  height: 100.0.h,
                  width: 100.0.w,
                  fit: BoxFit.cover
              ),
            ),
          ),
          Padding(
            padding:  EdgeInsets.only(left:10.0.w,),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children:  [
                Text(charityName!, style: TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                  fontSize: 20.0.spByWidth,
                ),
                ),
                Text(campaign!, style: TextStyle(
                  color: Colors.black,
                  fontSize: 15.0.spByWidth,
                ),
                  textAlign: TextAlign.left,
                ),
                SizedBox(height: 10.0.h,),
                ElevatedButton(
                  onPressed: (){},
                  style: ElevatedButton.styleFrom(
                    shape: StadiumBorder(),
                    onPrimary: Colors.white,
                    padding: EdgeInsets.symmetric(horizontal: 10.0.w, vertical: 8.0.h),
                  ),
                  child: Text(donation!, style: TextStyle(
                    fontSize: 15.0.spByWidth,
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