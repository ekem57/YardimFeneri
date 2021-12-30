import 'dart:convert';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_credit_card/flutter_credit_card.dart';
import 'package:http/http.dart' as http;
import 'package:iyzico/iyzico.dart';
import 'package:provider/provider.dart';
import 'package:yardimfeneri/UI/odeme/odeme_basarili.dart';
import 'package:yardimfeneri/common/alertinfo.dart';
import 'package:yardimfeneri/extantion/size_extension.dart';
import 'package:yardimfeneri/model/iyizico_payment.dart';
import 'package:yardimfeneri/servis/charities_service.dart';


class KampanyaOdeme extends StatefulWidget {
  Map<String, dynamic> destek;
  String bagis;
  KampanyaOdeme({Key key, this.destek,this.bagis}) : super(key: key);

  @override
  _KampanyaOdemeState createState() => _KampanyaOdemeState();
}

class _KampanyaOdemeState extends State<KampanyaOdeme> {
  String cardNumber = '';
  String expiryDate = '';
  String cardHolderName = '';
  String cvvCode = '';
  bool isCvvFocused = false;
  bool registerCard = false;
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  bool _isLoading = false;

  void onCreditCardModelChange(CreditCardModel creditCardModel) {
    setState(() {
      cardNumber = creditCardModel.cardNumber;
      expiryDate = creditCardModel.expiryDate;
      cardHolderName = creditCardModel.cardHolderName;
      cvvCode = creditCardModel.cvvCode;
      isCvvFocused = creditCardModel.isCvvFocused;
    });
  }



  bool _loadingVisible = false;
  Future<void> _changeLoadingVisible() async {
    setState(() {
      _loadingVisible = !_loadingVisible;
    });
  }

  _pay2() async {
  //  final _charitiesModel = Provider.of<CharitiesService>(context, listen: false);

    String token = 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1c2VySWQiOiI2MDBlYWY2YjU3NTEwNzI3NDg5YjAxYWIiLCJpYXQiOjE2MTU0NDkxMzl9.YTRsYrZqMDmByiOK3XqE6IuEtOaBRmJwtV_qBXy0wVI';
    String paymentUrl = 'http://192.168.1.107:5000/api/payment/iyzico';

    const iyziConfig = IyziConfig(
        'sandbox-aHYVflgQYVBtt6llDZrt30NwFGgBu63a',
        'sandbox-5vFnPaU7zksagqiZXq8q7xdIjlFFGJaO',
        'https://sandbox-api.iyzipay.com');

    //Create an iyzico object
    final iyzico = Iyzico.fromConfig(configuration: iyziConfig);


    final double price = 1;
    // ignore: omit_local_variable_types
    final double paidPrice = 2.1;



    final paymentCard = PaymentCard(
      cardHolderName: 'John Doe',
      cardNumber: '5406670000000009',
      expireYear: '2030',
      expireMonth: '12',
      cvc: '123',
    );

    final shippingAddress = Address(
        address: 'Nidakule Göztepe, Merdivenköy Mah. Bora Sok. No:1',
        contactName: 'Jane Doe',
        zipCode: '34742',
        city: 'Istanbul',
        country: 'Turkey');
    final billingAddress = Address(
        address: 'Nidakule Göztepe, Merdivenköy Mah. Bora Sok. No:1',
        contactName: 'Jane Doe',
        city: 'Istanbul',
        country: 'Turkey');

    final buyer = Buyer(
        id: 'BY789',
        name: 'John',
        surname: 'Doe',
        identityNumber: '74300864791',
        email: 'email@email.com',
        registrationAddress: 'Nidakule Göztepe, Merdivenköy Mah. Bora Sok. No:1',
        city: 'Istanbul',
        country: 'Turkey',
        ip: '85.34.78.112');

    final basketItems = <BasketItem>[
      BasketItem(
          id: 'BI101',
          price: '0.3',
          name: 'Binocular',
          category1: 'Collectibles',
          category2: 'Accessories',
          itemType: BasketItemType.VIRTUAL),
      BasketItem(
          id: 'BI102',
          price: '1.5',
          name: 'Game code',
          category1: 'Game',
          category2: 'Online Game Items',
          itemType: BasketItemType.VIRTUAL),
      BasketItem(
          id: 'BI103',
          price: '0.2',
          name: 'Usb',
          category1: 'Electronics',
          category2: 'Usb / Cable',
          itemType: BasketItemType.VIRTUAL),
    ];
    final paymentResult = await iyzico.CreatePaymentRequest(
        price: 2.0,
        paidPrice: 0.1,
        paymentCard: paymentCard,
        buyer: buyer,
        shippingAddress: shippingAddress,
        billingAddress: billingAddress,
        basketItems: basketItems);

    print(paymentResult.status);

    if(paymentResult.status=="success")
    {
      SystemChannels.textInput.invokeMethod('TextInput.hide');
      await _changeLoadingVisible();
      try {
        DocumentReference _reference = await FirebaseFirestore.instance
            .collection("charities").doc(widget.destek['kurumid'].toString()).collection("kuruma_yapilan_bagis").doc();

        DocumentReference _referencepost = await FirebaseFirestore.instance.collection("anasayfa").doc(widget.destek['yardim_id']);

        DocumentReference _referencebildirim = await FirebaseFirestore.instance.collection("charities").doc(widget.destek['kurumid'].toString()).collection("bildirimler").doc();

        print("gelen kurumid: "+widget.destek['kurumid'].toString());
        Map<String, dynamic> bildirim = Map();

        bildirim['etid'] = widget.destek['yardim_id'];
        bildirim['icerik'] = "Kampanyaya yapılan desteklere "+widget.destek['bagis_miktari'].toString()+" ₺ değerinde destek yapılmıştır.";
        bildirim['okundu'] = false;
        bildirim['date'] = Timestamp.now();



        _reference.set(widget.destek).then((value) async {
          await _referencepost.update({'toplanan_tutar':widget.destek['bagis_miktari']+int.parse(widget.bagis)});
          await _referencebildirim.set(bildirim);

          var dialogBilgi = AlertBilgilendirme(
            icerik: "Yapmış olduğunuz desteklerden dolayı teşekkürler.",
            Pressed: () {
              Navigator.pop(context);
              Navigator.pop(context);
              Navigator.pop(context);
            },
          );

          showDialog(
              context: context,
              builder: (BuildContext context) => dialogBilgi);

          setState(() {

            _loadingVisible = false;
          });
        });

      }catch(e){
        print(e);
        var dialogBilgi = AlertBilgilendirme(
          icerik: "Ödeme alınamadı üzgünüz. Lütfen tekrar deneyiniz... \n",
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

    }
    else
    {
      var dialogBilgi = AlertBilgilendirme(
        icerik: "Üzgünüz ödeme alınamadı.",
        Pressed: () {
          Navigator.pop(context);
        },
      );

      showDialog(
          context: context,
          builder: (BuildContext context) => dialogBilgi);
    }


  }

  Future<void> _showMyDialog(String title, String content){
    return showDialog<void>(
        context: context,
        builder: (BuildContext context){
          return AlertDialog(
            title: Text(title),
            content: Text(content),
          );
        }).then((value) => {
      setState(() {
        _isLoading = false;
      })
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        resizeToAvoidBottomInset: true,
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
          iconTheme: IconThemeData(color: Colors.black),
        ),
        body: SafeArea(
          child: Column(
            children: <Widget>[
              CreditCardWidget(
                height: 155,
                cardNumber: cardNumber,
                expiryDate: expiryDate,
                cardHolderName: cardHolderName,
                cvvCode: cvvCode,
                showBackView: isCvvFocused,
                obscureCardNumber: true,
                obscureCardCvv: true,
              ),
              Expanded(
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      CreditCardForm(
                        formKey: formKey,
                        obscureCvv: true,
                        obscureNumber: true,
                        cardNumberDecoration: const InputDecoration(
                          border: OutlineInputBorder(),
                          labelText: 'Kart Numarası',
                          hintText: 'XXXX XXXX XXXX XXXX',
                        ),
                        expiryDateDecoration: const InputDecoration(
                          border: OutlineInputBorder(),
                          labelText: 'Son kullanma tarihi',
                          hintText: 'XX/XX',
                        ),
                        cvvCodeDecoration: const InputDecoration(
                          border: OutlineInputBorder(),
                          labelText: 'CVV',
                          hintText: 'XXX',
                        ),
                        cardHolderDecoration: const InputDecoration(
                          border: OutlineInputBorder(),
                          labelText: 'Kart sahibi',
                        ),
                        onCreditCardModelChange: onCreditCardModelChange,
                      ),
                      SizedBox(height: 10.0.h,),
                      RaisedButton(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8.0),
                          ),
                          child: Container(
                            margin: const EdgeInsets.all(12),
                            child: const Text(
                              'Ödeme Yap',
                              style: TextStyle(
                                color: Colors.white,
                                fontFamily: 'halter',
                                fontSize: 20,
                                package: 'flutter_credit_card',
                              ),
                            ),
                          ),
                          color: const Color(0xff1b447b),
                          onPressed: () => _pay2()
                      )
                    ],
                  ),
                ),
              )
            ],
          ),
        )
    );
  }
}