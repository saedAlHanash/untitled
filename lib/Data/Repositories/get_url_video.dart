import 'dart:convert';

import 'package:http/http.dart' as http;

var encodedCredentials = base64Encode(
  utf8.encode(
    "9353127f0c5d3848970ed83590f3989b7d4aeabf:lsL75LeVC88hMQALy4KlRbaR0srz72eq9RqDJQuAbopBD1rxhQK5XxLM0KDCniZZ3QDC2iuatIk+kNstylUffDxbVm/sUNxhPg7E02OY8nT82I6uOjRObMiMdD9jsGBw",
  ),
);

class GetUrlVideo {
  String clientId = '9353127f0c5d3848970ed83590f3989b7d4aeabf';
  String clientSecrute =
      'lsL75LeVC88hMQALy4KlRbaR0srz72eq9RqDJQuAbopBD1rxhQK5XxLM0KDCniZZ3QDC2iuatIk+kNstylUffDxbVm/sUNxhPg7E02OY8nT82I6uOjRObMiMdD9jsGBw';
  String urlAuthentication = 'https://api.vimeo.com/oauth/authorize/client';

  Future<dynamic> authrizationWithVimeo() async {
    var headers = {
      'Authorization': 'basic $encodedCredentials',
      'Content-Type': 'application/json',
      'Accept': "application/vnd.vimeo.*+json;version=3.4",
    };
    Map<String, String> data = {"grant_type": "client_credentials", "scope": "private"};

    final response = await http.post(Uri.parse(urlAuthentication),
        headers: headers, body: jsonEncode(data));

    var accessToken = jsonDecode(response.body)['access_token'];

    return accessToken;

    // headers = {
    //   'Authorization': "Bearer $accessToken",
    //   'Accept': "application/vnd.vimeo.*+json;version=3.4",
    // };
    // final response1 = await http.get(
    //     Uri.parse('https://player.vimeo.com/video/$videoId'),
    //     headers: headers);

    // final regex = RegExp(r'"progressive":\[(.*?)\]');
    // final match = regex.firstMatch(response1.body);
    // if (match != null) {
    //   final json = jsonDecode('[${match.group(1)}]')[0];
    //   final videoUrl = json['url'];
    //   return videoUrl;
    // }
    // return '';
  }
}
