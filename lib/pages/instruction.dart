import 'package:flutter/material.dart';
import 'package:inhalen/pages/information.dart';
import 'package:inhalen/services/colors.dart';
import 'package:youtube_player_iframe/youtube_player_iframe.dart';

class Instruction extends StatelessWidget {
  final YoutubePlayerController _controller = YoutubePlayerController(
    initialVideoId: 'sWQy4zv1ZeU',
    params: YoutubePlayerParams(
      showControls: true,
      showFullscreenButton: true,
    ),
  );

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
            Container(
                child: YoutubePlayerIFrame(
              controller: _controller,
              aspectRatio: 16 / 9,
            )),
          ],
        ),
      ),
    );
  }
}
