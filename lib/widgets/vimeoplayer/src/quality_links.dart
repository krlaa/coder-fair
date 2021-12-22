import 'package:http/http.dart' as http;
import 'dart:convert';
import 'dart:async';
import "dart:collection";

//throw UnimplementedError();

class QualityLinks {
  String videoId;

  QualityLinks(this.videoId);

  getQualitiesSync() {
    return getQualitiesAsync();
  }

  Future<SplayTreeMap?> getQualitiesAsync() async {
    try {
      var response = await http.post(Uri.parse('https://ogzhcm.deta.dev/proxy'),
          body: {"link": "https://player.vimeo.com/video/$videoId/config"});

      var jsonData =
          jsonDecode(response.body)['request']['files']['progressive'];

      SplayTreeMap videoList = SplayTreeMap.fromIterable(jsonData,
          key: (item) => "${item['quality']} ${item['fps']}",
          value: (item) => item['url']);
      print(videoList);
      return videoList;
    } catch (error) {
      print('=====> REQUEST ERROR: $error');
      return null;
    }
  }
}
