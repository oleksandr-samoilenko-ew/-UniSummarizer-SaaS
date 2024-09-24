import 'dart:convert';

import 'package:http/http.dart' as http;

class ApiService {
  final String baseUrl = 'http://localhost:3001/fetch-subtitles';

  Future<String> fetchSubtitles(String url) async {
    String subtitles = '';

    final response = await http.post(
      Uri.parse(baseUrl),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, String>{
        'url': url,
      }),
    );

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);

      subtitles = data['subtitles'].toString();
    } else {
      subtitles = 'Failed to fetch subtitles';
    }
    return subtitles;
  }
}
