import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;

class CreateAccountRepo {
  static Future<bool> create(String email, String password) async {
    var client = http.Client();
    var data = {
      'address': email,
      'password': password,
    };

    try {
      var response = await client.post(
        Uri.parse('https://api.mail.tm/accounts'),
        headers: {
          'accept': 'application/ld+json',
          'Content-Type': 'application/json',
        },
        body: json.encode(data),
      );
      if (response.statusCode >= 200 && response.statusCode < 300) {
        return true;
      } else {
        return false;
      }
    } catch (e) {
      return false;
    } finally {
      client.close();
    }
  }
}
