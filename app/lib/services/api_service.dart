import 'dart:convert';

import 'package:http/http.dart' as http;

class ApiService {
  final String baseUrl = 'http://localhost:3000';

  Future<String> summarizeYoutube({
    required String url,
    required String apiKey,
  }) async {
    String summary = '';

    final response = await http.post(
      Uri.parse('$baseUrl/fetch-subtitles'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, String>{
        'url': url,
        'apiKey': apiKey,
      }),
    );

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);

      summary = data['summary'].toString();
    } else {
      summary = 'Failed to fetch summary';
    }
    return summary;
  }

  Future<String> summarizeWebsite({
    required String url,
    required String apiKey,
  }) async {
    String summary = '';
    print('apiKey: $apiKey');
    final response = await http.post(
      Uri.parse('$baseUrl/summarize-website'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, String>{
        'url': url,
        'apiKey': apiKey,
      }),
    );

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);

      summary = data['summary'].toString();
    } else {
      summary = 'Failed to fetch summary';
    }
    return summary;
  }
}
