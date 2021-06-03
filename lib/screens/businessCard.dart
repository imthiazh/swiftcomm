import 'dart:convert';
import 'dart:math';

import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:nfc_in_flutter/nfc_in_flutter.dart';
import 'package:touchngo/models/card.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:gradient_app_bar/gradient_app_bar.dart';
import 'package:touchngo/External/constant.dart';
import 'package:touchngo/Model/RawData.dart';
import 'package:flutter_nfc_reader/flutter_nfc_reader.dart';
// import 'package:touchngo/External/constant.dart';
// import 'package:touchngo/Model/RawData.dart';

class BusinessCard extends StatefulWidget {
  static const routeName = '/businessCard';

  @override
  _BusinessCardState createState() => _BusinessCardState();
}

class _BusinessCardState extends State<BusinessCard> {

  List<Card_obj> user_cards=[];
  bool isNull = true;

  @override
  initState() {
    super.initState();
    FlutterNfcReader.onTagDiscovered().listen((onData) {
      print(onData.id);
      
      String raw_json = onData.content;

      dynamic json_content =  raw_json.substring(7);

      print(json.decode(json_content));
      
      json_content = json.decode(json_content) as Map<String, dynamic>;

         
      
      setState(() {
        isNull = false;
        user_cards.add(Card_obj(
        name: json_content["n"],
        c_role: json_content["c"],
        phn:json_content["p"],
        email:json_content["e"],
        link:json_content["l"],
        addr:json_content["a"],
        
      ));
      
      });
      
      
    });
  }

  int _current = 0;

  final Text titleText =  new Text(
    // CommonText.paymentOption,
    "Your Collection",
    style: new TextStyle(
        color: Colors.black,
        fontSize: 20,
        fontWeight: FontWeight.bold
    ),
    textAlign: TextAlign.left,
  );

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
        appBar: GradientAppBar( 
            backgroundColorStart: Colors.blue[600], backgroundColorEnd: Colors.cyan,
            title: Text(
              'Business Cards',
                    style: TextStyle(
                      fontFamily: 'OpenSans',
                    )),
        ),
        backgroundColor: Colors.white,

        body: isNull ? Center(child: Text('''              No Cards Found
Tap a NFC tag to add contacts
        ''',style: TextStyle(
            color: Colors.grey,
            fontSize: 20.0,
          ),)) : new SafeArea(
            top: true,

            child: Column (

              crossAxisAlignment: CrossAxisAlignment.center,

              children: <Widget>[
                SizedBox(height: 20,),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    
                    SizedBox(width: 15,),
                    titleText,

                  ],
                ),

                CarouselSlider(
                  aspectRatio: 16/9,
                  viewportFraction: 0.85,
                  initialPage: 0,
                  enableInfiniteScroll: true,
                  reverse: false,
                  pauseAutoPlayOnTouch: Duration(seconds: 10),
                  enlargeCenterPage: true,
                  scrollDirection: Axis.horizontal,
                  height: 250.0,
                  onPageChanged: (index) {
                    setState(() {
                      _current = index;
                      print(index);
                    });
                  },
                  //usercard_

                  items: user_cards.map((curr_card) {
                    return Builder(
                      builder: (BuildContext context) {
                        return Container(
                            margin: EdgeInsets.all(5.0),
                            child: homeUI(curr_card, _current)
                        );
                      },
                    );
                  }).toList(),
                ),
                // Text(_current.toString()),
                // isNull ? Text("Nothing") : Text(user_cards[0].name),

              ],
            )

        )
    );
  }
  Random random = new Random();
  Widget homeUI(Card_obj curr_card, int curr_color) {

    final BoxDecoration boxDecoration = new BoxDecoration(
      shape: BoxShape.rectangle,
      // color: RawData().cardList[curr_color].backColor.withOpacity(1.0) ,
      color: Colors.blue ,
      image: new DecorationImage(
        image: new AssetImage(
            AppImages.backPattern
        ),
        fit: BoxFit.cover,),
      borderRadius: new BorderRadius.all(
          const Radius.circular(10)
      ),
    );

    // final Container cardName =  new Container(
    //   width: (MediaQuery.of(context).size.width - 188), //left 20 +  right 20 // Image 65 //space 10 // 50 Carousel Side
    //   child: new Text(
    //       RawData().cardList[index].cardName.toString(),
    //       textAlign: TextAlign.left,
    //       style: new TextStyle(
    //         color: Colors.white,
    //         fontSize: 20,
    //         fontWeight: FontWeight.w600,
    //       )
    //   ),
    // );

    // final Image cardImage  = new Image(
    //   image: new AssetImage( RawData().cardList[index].cardImage),
    //   width: 65, height: 65,
    //   fit: BoxFit.scaleDown, alignment: Alignment.centerRight,
    // );

    // final Container startText =  new Container(
    //   child:new Text(
    //       CommonText.starText,textAlign: TextAlign.center,
    //       style: new TextStyle(
    //         color: Colors.white,
    //         fontSize: 40,
    //         fontWeight: FontWeight.w600,
    //       )
    //   ),
    //   height: 50,
    //   width: (MediaQuery.of(context).size.width - 170), //left 10 +  right 10 // cardNo 100 //space 1 // 50 Carousel Side
    //   padding:new EdgeInsets.only(top: 5,bottom: 5),);

    // final Container cardNumber = new Container(
    //   height:40,
    //   child:  new Text(
    //       RawData().cardList[index].cardNumber.toString(),textAlign: TextAlign.center,
    //       style: new TextStyle(
    //         color: Colors.white,
    //         fontSize: 30,
    //         fontWeight: FontWeight.w600,
    //       )
    //   ),
    // );

    // final Container cardHolderName =  new Container(
    //   width: (MediaQuery.of(context).size.width - 190), //left 20 +  right 20 // expDate 90 //space 10 // 50 Carousel Side
    //   child: new Text(
    //       RawData().cardList[index].cardHolderName.toString(),
    //       textAlign: TextAlign.left,
    //       style: new TextStyle(
    //         color: Colors.white,
    //         fontSize: 20,
    //         fontWeight: FontWeight.w400,
    //       )
    //   ),
    // );

    // final Container expDate =  new Container(
    //   width: 70, //left 20 +  right 20 // Image 65 //space 10 // 50 Carousel Side
    //   child:  new Text(
    //       RawData().cardList[index].expDate.toString(),
    //       textAlign: TextAlign.right,
    //       style: new TextStyle(
    //         color: Colors.white,
    //         fontSize: 20,
    //         fontWeight: FontWeight.w400,
    //       )
    //   ),
    // );


    return new  Container(

      margin: EdgeInsets.only(top: 20,),

      height: 250, decoration: boxDecoration,

      width: MediaQuery.of(context).size.width,

      child:  Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // SizedBox(width: 20,),
          Container(
            padding: EdgeInsets.all(10),
            child: Image.asset('Images/boss.png', width: 70  , height: 70)),
          new Column(

              crossAxisAlignment: CrossAxisAlignment.end,

              mainAxisAlignment: MainAxisAlignment.spaceEvenly,

              children: <Widget>[

                new Row(

                  crossAxisAlignment: CrossAxisAlignment.center,

                  // mainAxisAlignment: MainAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.end,


                  children: <Widget>[
                    
                    // new Padding(padding: EdgeInsets.only(left: 20)),

                    // cardName,

                    new Padding(padding: EdgeInsets.only(right: 60)),

                    // cardImage,
                    Text(curr_card.name, style: TextStyle(fontSize: 15, fontFamily: 'OpenSans', color:Colors.white, fontWeight: FontWeight.bold)),

                    new Padding(padding: EdgeInsets.only(right: 20)),

                  ],

                ),

                new Row(

                  crossAxisAlignment: CrossAxisAlignment.center,

                  // mainAxisAlignment: MainAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.end,

                  children: <Widget>[

                    // new Padding(padding: EdgeInsets.only(left: 10)),

                    // startText,

                    // cardNumber,
                    Text("Intern, "+curr_card.c_role, style: TextStyle(fontSize: 15, fontFamily: 'OpenSans', color:Colors.white, fontWeight: FontWeight.bold)),

                    new Padding(padding: EdgeInsets.only(right: 10)),

                  ],
                ),
                SizedBox(height: 20),
                new Row(

                  crossAxisAlignment: CrossAxisAlignment.center,

                  // mainAxisAlignment: MainAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.end,

                  children: <Widget>[

                    // new Padding(padding: EdgeInsets.only(left: 10)),

                    // startText,

                    // cardNumber,
                    RichText(text: TextSpan(text: "+91 "+curr_card.phn, style: TextStyle(fontSize: 18, fontFamily: 'OpenSans', color:Colors.blue[100],
                     fontWeight: FontWeight.bold,
                     ),
                     recognizer: new TapGestureRecognizer()
                    // ..onTap = () { launch('tel://9840847951');
                    ..onTap = () { launch('https://wa.me/+91'+curr_card.phn+'?text=Hi! This is Imthiaz, nice to meet you! 😄');
                  },
                     )),

                    new Padding(padding: EdgeInsets.only(right: 10)),

                  ],
                ),

                new Row(

                  crossAxisAlignment: CrossAxisAlignment.center,

                  // mainAxisAlignment: MainAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.end,

                  children: <Widget>[

                    // new Padding(padding: EdgeInsets.only(left: 10)),

                    // startText,

                    // cardNumber,
                    //Text("imthiazdps@gmail.com", style: TextStyle(fontSize: 12, fontFamily: 'OpenSans', color:Colors.blue[100], fontWeight: FontWeight.bold)),
                    RichText(text: TextSpan(text: curr_card.email+"@gmail.com", style: TextStyle(fontSize: 18, fontFamily: 'OpenSans', color:Colors.blue[100],
                     fontWeight: FontWeight.bold,
                     ),
                     recognizer: new TapGestureRecognizer()
                    ..onTap = () { launch('mailto:'+curr_card.email+'@gmail.com');
                  },
                     )),
                    new Padding(padding: EdgeInsets.only(right: 10)),

                  ],
                ),

                new Row(

                  crossAxisAlignment: CrossAxisAlignment.center,

                  // mainAxisAlignment: MainAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.end,

                  children: <Widget>[

                    // new Padding(padding: EdgeInsets.only(left: 10)),

                    // startText,

                    // cardNumber,
                    //Text("imthiazh"+"@linkedin", style: TextStyle(fontSize: 16, fontFamily: 'OpenSans', color:Colors.blue[100], fontWeight: FontWeight.bold,)),
                    RichText(text: TextSpan(text: curr_card.link+"@link", style: TextStyle(fontSize: 15, fontFamily: 'OpenSans', color:Colors.blue[100],
                     fontWeight: FontWeight.bold,
                     ),
                     recognizer: new TapGestureRecognizer()
                    ..onTap = () { launch('https://www.linkedin.com/in/'+curr_card.link);
                  },
                  )),
                    new Padding(padding: EdgeInsets.only(right: 10)),

                  ],
                ),

                new Row(

                  crossAxisAlignment: CrossAxisAlignment.center,

                  // mainAxisAlignment: MainAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.end,

                  children: <Widget>[

                    // new Padding(padding: EdgeInsets.only(left: 10)),

                    // startText,

                    // cardNumber,
                    InkWell(
                      child: Text(curr_card.addr, style: TextStyle(fontSize: 10, fontFamily: 'OpenSans', color:Colors.white)),
                      onTap: () => launch('https://www.google.com/maps/search/?api=1&query='+curr_card.addr),
                    ),
                    //RichText(text: TextSpan(text: "1600 Mountain View, CA 94043, United States", style: TextStyle(fontSize: 10, fontFamily: 'OpenSans', color:Colors.white))),
                    new Padding(padding: EdgeInsets.only(right: 10)),

                  ],
                ),

                // new Row(

                //   crossAxisAlignment: CrossAxisAlignment.center,

                //   mainAxisAlignment: MainAxisAlignment.start,

                //   children: <Widget>[

                //     new Padding(padding: EdgeInsets.only(left: 20)),

                //     cardHolderName,

                //     expDate,

                //     new Padding(padding: EdgeInsets.only(right: 20)),

                //   ],
                // ),

              ]

          ),
        ],
      ),

    );
  }
  }

  