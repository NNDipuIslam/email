import 'dart:async';
import 'dart:convert';
import 'package:email/features/models/domain_post_ui_data_model.dart';
import 'package:http/http.dart ' as http;

class CreateAccountRepo {
  static Future<bool> create(String email, String password) async {
    var client = http.Client();
    var data = {
      'email': email,
      'password': password,
    };

    try {
      var response = await client.post(
        Uri.parse(
          'https://api.mail.tm/accounts',
        ),
        headers: {
          'accept': 'application/json', // Specify accept header
          'Content-Type': 'application/json', // Specify JSON content type
        },
        body: json.encode(data),
      );
      print(response.statusCode);
      if (response.statusCode >= 200 && response.statusCode < 300)
        return true;
      else
        return false;
    } catch (e) {
      return false;
    }
  }
}
