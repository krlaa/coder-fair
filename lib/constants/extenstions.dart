import 'package:youtube_player_iframe/youtube_player_iframe.dart';

extension StringExtensions on String {
  String getThumbnailFromUrl() {
    return YoutubePlayerController.getThumbnail(
        videoId: YoutubePlayerController.convertUrlToId(this)!, webp: false);
  }
}
