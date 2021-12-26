import 'package:chewie/chewie.dart';
import 'package:coder_fair/constants/app_colors.dart';
import 'package:coder_fair/widgets/vimeoplayer/src/quality_links.dart';
import "package:flutter/material.dart";
import 'package:video_player/video_player.dart';

class CustomVideo extends StatefulWidget {
  final String videoId;
  const CustomVideo({Key? key, required this.videoId}) : super(key: key);

  @override
  _CustomVideoState createState() => _CustomVideoState();
}

class _CustomVideoState extends State<CustomVideo>
    with AutomaticKeepAliveClientMixin {
  Widget playerWidget = Center(child: CircularProgressIndicator());
  late ChewieController chewieController;
  late final videoPlayerController;
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
    videoPlayerController = VideoPlayerController.network(link?["360p"]);

    await videoPlayerController.initialize();

    chewieController = ChewieController(
      materialProgressColors: ChewieProgressColors(
          playedColor: Colors.green.shade900,
          handleColor: AppColor.buttonGreen),
      cupertinoProgressColors: ChewieProgressColors(
          playedColor: Colors.green.shade900,
          handleColor: AppColor.buttonGreen),
      allowFullScreen: false,
      showOptions: false,
      autoInitialize: true,
      allowMuting: false,
      videoPlayerController: videoPlayerController,
      autoPlay: true,
      looping: false,
    );
    chewieController.setVolume(0);
    playerWidget = Chewie(
      controller: chewieController,
    );
    if (mounted) {
      setState(() {});
    }
  }

  @override
  // TODO: implement wantKeepAlive
  bool get wantKeepAlive => true;

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    videoPlayerController.dispose();
    chewieController.dispose();
  }
}
