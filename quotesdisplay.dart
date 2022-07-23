import 'package:flutter/material.dart';
import 'package:flash_chat/constants.dart';

class QuotesDisplay extends StatefulWidget {
  static String id = 'QuotesDisplay';
  @override
  _QuotesDisplayState createState() => _QuotesDisplayState();
}

class _QuotesDisplayState extends State<QuotesDisplay> {
  @override
  Widget build(BuildContext context) {
    /*
    return Container(
      child: Center(
        child: Text(quotes),
      ),
    );

     */
    return Scaffold(
      appBar: AppBar(
        leading: null,
        actions: <Widget>[

        ],
        title: Text('You Live Only Once!'),
        backgroundColor: Colors.deepOrangeAccent,
      ),

      body: Container(
        decoration: BoxDecoration(
            image: DecorationImage(
                image: AssetImage("assets/quotebg1.jpg"), fit: BoxFit.cover)),
        //child: Container()
        child: Center(


          //child: Row



            child: Text(
              "You are the BEST! \n"+quotes,

              textAlign: TextAlign.center,
              //overflow: TextOverflow.ellipsis,
              style: TextStyle(fontWeight: FontWeight.bold,
                  color: Colors.white,
                  height: 2, fontSize: 18),
            )




        ),

      ),
    );
  }
}
