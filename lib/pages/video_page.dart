import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart';

import 'package:inhalen/pages/information.dart';
import 'package:inhalen/services/colors.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

class VideoPage extends StatefulWidget {
  final String videoId;

  VideoPage({
    Key key,
    @required this.videoId,
  }) : super(key: key);

  @override
  _VideoPageState createState() => _VideoPageState();
}

class _VideoPageState extends State<VideoPage> {
  YoutubePlayerController _controller;
  void initState() {
    try {
      _controller = YoutubePlayerController(
          initialVideoId: widget.videoId,
          flags: YoutubePlayerFlags(
            autoPlay: true,
          ));
    } catch (e) {
      print(widget.videoId);
      print('video id not found');
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: CustomColors.yellow,
      appBar: BackAppbar(),
      body: Center(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              "video",
              style: Theme.of(context).textTheme.subtitle1,
              textAlign: TextAlign.center,
            ).tr(),
            Container(
                padding: const EdgeInsets.all(16.0),
                child: YoutubePlayer(
                  controller: _controller,
                  showVideoProgressIndicator: true,
                )),
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    // _controller.close();
    super.dispose();
  }
}
