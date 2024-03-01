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
          'Authorization': 'Bearer $token' // Specify accept header
        },
      );
      print(response.statusCode);
      print(response.body);
      print(1);

      List<dynamic> data = jsonDecode(response.body);
      print(1);
      for (int i = 0; i < data.length; i++) {
        MessageuiDataModel post = MessageuiDataModel.fromJson(data[i]);
        posts.add(post);
      }
      print(1);
      return posts;
      /* print(response.statusCode);
      Map<String, dynamic> data = jsonDecode(response.body);
      //  int totalItems = data['hydra:totalItems'];
      List<dynamic> post = data['hydra:member'];
      List<MessageuiDataModel> result = post
          .map((messageJson) => MessageuiDataModel.fromJson(messageJson))
          .toList();
      print(result);
      return result;*/
    } catch (e) {
      print('joi nai');
      throw e;
    } finally {
      client.close();
    }
  }
}
/*
 final List<MessageuiDataModel> messages = messageuiDataModelFromJson(response.body);
    
    // Now you can use the messages list containing parsed data
    for (var message in messages) {
      print('Message ID: ${message.id}');
      print('From: ${message.from.name} <${message.from.address}>');
      print('Subject: ${message.subject}');
      print('-----------------------------------------');*/