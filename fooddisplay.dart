import 'package:flutter/material.dart';
import 'package:flash_chat/constants.dart';

class FoodDisplay extends StatefulWidget {
  static String id = 'FoodDisplay';
  @override
  _FoodDisplayState createState() => _FoodDisplayState();
}

class _FoodDisplayState extends State<FoodDisplay> {
  @override
  Widget build(BuildContext context) {
    /*
    return Container(
      child: Text(food),


    );
    */
    return Scaffold(
      appBar: AppBar(
        leading: null,
        actions: <Widget>[

        ],
        title: Text('Food Suggestions'),
        backgroundColor: Colors.deepOrangeAccent,
      ),

      body: Container(
        decoration: BoxDecoration(
            image: DecorationImage(
                image: AssetImage("assets/foodbg.jpg"), fit: BoxFit.cover)),
        //child: Container()

        child: Center(


            //child: Row



                child: Text(
                  "What about having these delights!\n"+food,

                  textAlign: TextAlign.center,
                  //overflow: TextOverflow.ellipsis,
                  style: TextStyle(fontWeight: FontWeight.bold,
                      color: Colors.brown,
                      height: 2, fontSize: 20),
                )




        ),
      ),
    );
  }
}
