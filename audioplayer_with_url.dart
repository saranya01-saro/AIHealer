import 'package:flutter/material.dart';
import 'package:audioplayers/audioplayers.dart';
import 'package:flash_chat/constants.dart';

class Audioplayerwithurl extends StatefulWidget {
  static String id = 'Audioplayerwithurl';
  @override
  _AudioplayerwithurlState createState() => _AudioplayerwithurlState();
}

class _AudioplayerwithurlState extends State<Audioplayerwithurl> {
  AudioPlayer audioplayer = AudioPlayer();
  AudioPlayerState audioPlayerState = AudioPlayerState.PAUSED;
  String url = link;
  @override
  void initState() {
    super.initState();

    audioplayer.onPlayerStateChanged.listen((AudioPlayerState s) {
      setState(() {
        audioPlayerState = s;
      });
    });
  }

  @override
  void dispose() {
    super.dispose();
    audioplayer.release();
    audioplayer.dispose();
  }

  playMusic() async {
    await audioplayer.play(url);
  }

  pauseMusic() async {
    await audioplayer.pause();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: null,
        actions: <Widget>[

        ],
        title: Text('Click the play button'),
        backgroundColor: Colors.deepOrangeAccent,
      ),
      body: Container(

        alignment: Alignment.center,
        decoration: BoxDecoration(
            image: DecorationImage(
                image: AssetImage("assets/musicbg.png"), fit: BoxFit.cover)),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [

          Ink(
        decoration: const ShapeDecoration(
        color: Colors.lightBlue,
          shape: CircleBorder(),
        ),
              child: new IconButton(

                  iconSize: 100,
                  //color: ,

                  icon: Icon(
                      audioPlayerState == AudioPlayerState.PLAYING
                      ? Icons.pause_circle_filled
                      : Icons.play_arrow
                  ),
                  onPressed: () {
                    audioPlayerState == AudioPlayerState.PLAYING
                        ? pauseMusic()
                        : playMusic();


                  })

              )


          ],
        ),
      ),
    );
  }
}
