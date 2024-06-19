import 'dart:convert';

import 'package:fitness_storm/core/api_manager/api_service.dart';
import 'package:http/http.dart' as http;

const urlAuthentication = 'https://api.vimeo.com/oauth/authorize/client';

const clientId = '9353127f0c5d3848970ed83590f3989b7d4aeabf';

const clientSecrute =
    'lsL75LeVC88hMQALy4KlRbaR0srz72eq9RqDJQuAbopBD1rxhQK5XxLM0KDCniZZ3QDC2iuatIk+kNstylUffDxbVm/sUNxhPg7E02OY8nT82I6uOjRObMiMdD9jsGBw';

Future<String> getVimeoToken() async {
  final headers = {
    'Authorization': 'basic ${base64Encode(utf8.encode("$clientId:$clientSecrute"))}',
    'Content-Type': 'application/json',
    'Accept': "application/vnd.vimeo.*+json;version=3.4",
  };

  final body = {
    "grant_type": "client_credentials",
    "scope": "private",
  };

  final response = await http.post(Uri.parse(urlAuthentication),
      headers: headers, body: jsonEncode(body));


  final accessToken = jsonDecode(response.body)['access_token'] ?? '';

  return accessToken;

}
