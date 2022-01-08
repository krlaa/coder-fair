import 'package:chewie/chewie.dart';
import 'package:coder_fair/constants/app_colors.dart';
import 'package:coder_fair/widgets/vimeoplayer/src/quality_links.dart';
import "package:flutter/material.dart";
import 'package:video_player/video_player.dart';
import 'package:visibility_detector/visibility_detector.dart';

class CustomVideo extends StatefulWidget {
  final String videoId;
  const CustomVideo({Key? key, required this.videoId}) : super(key: key);

  @override
  _CustomVideoState createState() => _CustomVideoState();
}

class _CustomVideoState extends State<CustomVideo>
    with AutomaticKeepAliveClientMixin {
  Widget playerWidget = Center(
      child: CircularProgressIndicator(
    color: AppColor.buttonGreen,
  ));
  ChewieController? chewieController;
  VideoPlayerController? videoPlayerController;
  @override
  void initState() {
    super.initState();

    if (mounted) loadVideo();
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return playerWidget;
  }

  void loadVideo() async {
    var x = QualityLinks(widget.videoId);
    var link = await x.getQualitiesAsync();
    videoPlayerController = VideoPlayerController.network(link?["360p"]);

    await videoPlayerController?.initialize();

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
      videoPlayerController: videoPlayerController!,
      autoPlay: true,
      looping: false,
    );
    if (mounted) {
      chewieController?.setVolume(0);
    }
    playerWidget = VisibilityDetector(
      onVisibilityChanged: (visibilityInfo) {
        var visiblePercentage = visibilityInfo.visibleFraction * 100;
        debugPrint(
            'Widget ${visibilityInfo.key} is ${visiblePercentage}% visible');
        if (visiblePercentage == 0) {
          if (mounted) {
            chewieController?.pause();
          }
        }
        if (mounted) {
          chewieController?.setVolume(0);
        }
      },
      key: Key("${widget.videoId}${chewieController.hashCode}"),
      child: Theme(
        data: ThemeData(
          progressIndicatorTheme: ProgressIndicatorTheme.of(context)
              .copyWith(color: AppColor.buttonGreen),
        ),
        child: Chewie(
          controller: chewieController!,
        ),
      ),
    );
    if (mounted) {
      setState(() {});
    }
  }

  @override
  bool get wantKeepAlive => true;

  @override
  void dispose() {
    super.dispose();
    videoPlayerController?.dispose();
    chewieController?.dispose();
  }
}
