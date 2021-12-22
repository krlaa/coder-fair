import 'package:chewie/chewie.dart';
import 'package:coder_fair/widgets/vimeoplayer/src/quality_links.dart';
import "package:flutter/material.dart";
import 'package:video_player/video_player.dart';

class CustomVideo extends StatefulWidget {
  final String videoId;
  const CustomVideo({Key? key, required this.videoId}) : super(key: key);

  @override
  _CustomVideoState createState() => _CustomVideoState();
}

class _CustomVideoState extends State<CustomVideo> {
  Widget playerWidget = Center(child: CircularProgressIndicator());
  @override
  void initState() {
    super.initState();

    loadVideo();
  }

  @override
  Widget build(BuildContext context) {
    return playerWidget;
  }

  void loadVideo() async {
    var x = QualityLinks(widget.videoId);
    var link = await x.getQualitiesAsync();
    final videoPlayerController =
        VideoPlayerController.network(link?["360p 23"]);

    await videoPlayerController.initialize();

    final chewieController = ChewieController(
      allowFullScreen: false,
      allowMuting: false,
      videoPlayerController: videoPlayerController,
      autoPlay: false,
      looping: true,
    );

    playerWidget = Chewie(
      controller: chewieController,
    );
    setState(() {});
  }
}
