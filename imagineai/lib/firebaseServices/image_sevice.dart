import 'dart:convert';
import 'dart:typed_data';
import 'package:http/http.dart' as http;

class ModelQueryService {
  final String apiUrl =
      'https://api-inference.huggingface.co/models/stabilityai/stable-diffusion-xl-base-1.0';
  final String apiToken = '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';

  Future<Uint8List?> queryModel(Map<String, dynamic> payload) async {
    try {
      final response = await http.post(
        Uri.parse(apiUrl),
        headers: {
          'Authorization': 'Bearer $apiToken',
          'Content-Type': 'application/json',
        },
        body: json.encode(payload),
      );

      if (response.statusCode == 200) {
        // Check if the content type indicates binary data (image)
        if (response.headers['content-type']?.contains('image/jpeg') == true ||
            response.headers['content-type']?.contains('image/png') == true) {
          return response.bodyBytes;
        } else {
          print(
              'Unexpected response format: ${response.headers["content-type"]}');
          print('Response Body: ${response.body}');
        }
      } else {
        print('HTTP Error: ${response.statusCode}');
        print('Response Body: ${response.body}');
      }
    } catch (e) {
      print('Error: $e');
    }
    throw Exception('Failed to query model');
    // for (int i = 10; i > 0; i--) {
    //   print('$i');
    //   await Future.delayed(Duration(seconds: 1));
    // }
    // print('Countdown complete!');
  }

}
