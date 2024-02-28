import 'dart:async';
import 'dart:convert';
import 'package:email/features/models/domain_post_ui_data_model.dart';
import 'package:http/http.dart ' as http;

class DomainRepo {
  static Future<List<PostsUiDataModel>> fetchPosts() async {
    var client = http.Client();
    List<PostsUiDataModel> posts = [];
    try {
      var response =
          await client.get(Uri.parse('https://api.mail.tm/domains?page=1'));
      Map<String, dynamic> data = jsonDecode(response.body);

      int totalItems = data['hydra:totalItems'];
      List<dynamic> result = data['hydra:member'];
      for (int i = 0; i < totalItems; i++) {
        PostsUiDataModel post = PostsUiDataModel.fromJson(result[i]);
        posts.add(post);
      }
      return posts;
    } catch (e) {
      throw e;
    }
  }
}
