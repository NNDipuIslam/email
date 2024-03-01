import 'dart:async';
import 'dart:convert';
import 'package:email/features/models/domain_post_ui_data_model.dart';
import 'package:email/features/models/messages_ui_data_model.dart';
import 'package:http/http.dart ' as http;

class MessageRepo {
  static Future<List<MessageuiDataModel>> inbox(String token) async {
    var client = http.Client();
    List<MessageuiDataModel> posts = [];
    try {
      var response = await client.get(
        Uri.parse('https://api.mail.tm/messages?page=1'),
        headers: {
          'accept': 'application/json',
          'Authorization': 'Bearer $token'
        },
      );

      List<dynamic> data = jsonDecode(response.body);
      for (int i = 0; i < data.length; i++) {
        MessageuiDataModel post = MessageuiDataModel.fromJson(data[i]);
        posts.add(post);
      }
      return posts;
    } catch (e) {
      throw e;
    } finally {
      client.close();
    }
  }
}
