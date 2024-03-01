import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;

class checkAccountRepo {
  static FutureOr<String?> check(String email, String password) async {
    var client = http.Client();
    var data = {
      'address': email,
      'password': password,
    };

    try {
      var response = await client.post(
        Uri.parse('https://api.mail.tm/token'),
        headers: {
          'accept': 'application/json', // Specify accept header
          'Content-Type': 'application/json', // Specify JSON content type
        },
        body: json.encode(data),
      );

      print(response.statusCode);

      if (response.statusCode == 200) {
        final Map<String, dynamic> responseData = json.decode(response.body);

        // Extract the token value
        final String? token = responseData['token'];
        return token;
      } else {}
    } catch (e) {
      return null;
    } finally {
      client.close(); // Close the client to free up resources
    }
  }
}
