import 'dart:convert';
import 'package:http/http.dart' as http;

class FirebaseFunctions {
  static final String baseUrl =
      "https://us-central1-approval-ai.cloudfunctions.net";

  static Future<void> addUserDetails(dynamic userInfoAndPreferences) async {
    try {
      // URL encode the text parameter to handle special characters
      final url = Uri.parse('$baseUrl/addUserDetails');
      var body = jsonEncode(userInfoAndPreferences);
      final response = await http.post(
        url,
        headers: {"Content-Type": "application/json"},
        body: body,
      );
      if (response.statusCode == 200) {
        print('Success: ${response.body}');
      } else {
        print('Error: ${response.statusCode} - ${response.body}');
      }
    } catch (e) {
      print('Error calling function: $e');
    }
  }
}
