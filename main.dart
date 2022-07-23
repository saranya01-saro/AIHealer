import 'package:flash_chat/audioplayer_with_url.dart';
import 'package:flutter/material.dart';

import 'package:flash_chat/screens/chat_screen.dart';

import 'screens/chat_screen.dart';
import 'screens/login_screen.dart';
import 'screens/login_screen.dart';
import 'screens/registration_screen.dart';
import 'screens/registration_screen.dart';
import 'screens/welcome_screen.dart';
import 'audioplayer_with_url.dart';
import 'recomscreen.dart';
import 'quotesdisplay.dart';
import 'fooddisplay.dart';

void main() => runApp(FlashChat());

class FlashChat extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      initialRoute: WelcomeScreen.id,
      routes: {
        // When navigating to the "/" route, build the FirstScreen widget.
        WelcomeScreen.id: (context) => WelcomeScreen(),
        // When navigating to the "/second" route, build the SecondScreen widget.
        RegistrationScreen.id: (context) => RegistrationScreen(),
        LoginScreen.id: (context) => LoginScreen(),
        ChatScreen.id: (context) => ChatScreen(),
        Audioplayerwithurl.id: (context) => Audioplayerwithurl(),
        Recomscreen.id: (context) => Recomscreen(),
        QuotesDisplay.id: (context) => QuotesDisplay(),
        FoodDisplay.id: (context) => FoodDisplay()
      },
    );
  }
}
