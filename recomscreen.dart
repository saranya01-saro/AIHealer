import 'package:flash_chat/audioplayer_with_url.dart';
import 'package:flash_chat/fooddisplay.dart';
import 'package:flash_chat/quotesdisplay.dart';
import 'package:flutter/material.dart';
import 'package:flash_chat/constants.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:modal_progress_hud/modal_progress_hud.dart';
import 'components/rounded_button.dart';

class Recomscreen extends StatefulWidget {
  static String id = 'recomscreen';
  @override
  _RecomscreenState createState() => _RecomscreenState();
}

class _RecomscreenState extends State<Recomscreen> {
  final messageTextController = TextEditingController();
  var url = "https://mysterious-oasis-43260.herokuapp.com/quotes";
  var url1 = "https://mysterious-oasis-43260.herokuapp.com/food";
  var url2 = "https://mysterious-oasis-43260.herokuapp.com/song";
  Future<dynamic> getData(review) async {
    String requesturl = '$url?Query=$review';
    http.Response response = await http.get(requesturl);
    if (response.statusCode == 200) {
      var decodedData = jsonDecode(response.body);
      print(decodedData);
      quotes = decodedData.toString();
      // showAlert(
      //   context: context,
      //   title: "$ans",
      // );

      messageTextController.clear();
    } else {
      print(response.statusCode);
      throw 'Problem with request';
    }
  }

  Future<dynamic> getData1(review) async {
    String requesturl = '$url1?Query=$review';
    http.Response response = await http.get(requesturl);
    if (response.statusCode == 200) {
      var decodedData = jsonDecode(response.body);
      print(decodedData);
      food = decodedData.toString();
      // showAlert(
      //   context: context,
      //   title: "$ans",
      // );

      messageTextController.clear();
    } else {
      print(response.statusCode);
      throw 'Problem with request';
    }
  }

  Future<dynamic> getData2(review) async {
    String requesturl = '$url2?Query=$review';
    http.Response response = await http.get(requesturl);
    if (response.statusCode == 200) {
      var decodedData = jsonDecode(response.body);
      print(decodedData);
      link = decodedData.toString();

      messageTextController.clear();
    } else {
      print(response.statusCode);
      throw 'Problem with request';
    }
  }

  bool showSpinner = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ModalProgressHUD(
        inAsyncCall: showSpinner,
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Text(
                "Your mood is " + sentiment,
                textAlign: TextAlign.center,
                //overflow: TextOverflow.ellipsis,
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Colors.brown,
                    height: 10,
                    fontSize: 20),
              ),
              SizedBox(
                height: 50,
              ),
              RoundedButton(
                buttonTitle: 'see quotes',
                colour: Colors.deepOrangeAccent,
                onPressed: () async {
                  setState(() {
                    showSpinner = true;
                  });
                  try {
                    await getData(sentiment);
                    await Navigator.pushNamed(context, QuotesDisplay.id);
                    setState(() {
                      showSpinner = false;
                    });
                  } catch (e) {
                    print(e);
                  }
                },
              ),
              SizedBox(
                height: 10,
              ),
              RoundedButton(
                buttonTitle: 'see foods',
                colour: Colors.deepOrangeAccent,
                onPressed: () async {
                  setState(() {
                    showSpinner = true;
                  });
                  try {
                    await getData1(sentiment);
                    await Navigator.pushNamed(context, FoodDisplay.id);
                    setState(() {
                      showSpinner = false;
                    });
                  } catch (e) {
                    print(e);
                  }
                },
              ),
              SizedBox(
                height: 10,
              ),
              RoundedButton(
                buttonTitle: 'Hear songs',
                colour: Colors.deepOrangeAccent,
                onPressed: () async {
                  setState(() {
                    showSpinner = true;
                  });
                  try {
                    await getData2(sentiment);
                    await Navigator.pushNamed(context, Audioplayerwithurl.id);
                    setState(() {
                      showSpinner = false;
                    });
                  } catch (e) {
                    print(e);
                  }
                },
              ),
            ],
          ),
        ),
      ),
      backgroundColor: Colors.white,
    );
  }
}