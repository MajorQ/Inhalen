import 'package:flutter/material.dart';
import 'package:inhalen/pages/information.dart';
import 'package:inhalen/services/colors.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

class Instruction extends StatelessWidget {
  YoutubePlayerController _controller = YoutubePlayerController(
      initialVideoId: 'BE9ATY2Ygas',
      flags: YoutubePlayerFlags(autoPlay: true, mute: true));
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: CustomColors.yellow,
      appBar: BackAppbar(),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text("Yuk, belajar dari video ini!"),
            YoutubePlayer(
              controller: _controller,
              showVideoProgressIndicator: true,
            )
          ],
        ),
      ),
    );
  }
}
