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
      if (response.statusCode == 200) {
        String json =
            '{"@context":"/contexts/Domain","@id":"/domains","@type":"hydra:Collection","hydra:totalItems":1,"hydra:member":[{"@id":"/domains/65da256aad121469f753d84c","@type":"Domain","id":"65da256aad121469f753d84c","domain":"yogirt.com","isActive":true,"isPrivate":false,"createdAt":"2024-02-24T00:00:00+00:00","updatedAt":"2024-02-24T00:00:00+00:00"}]}';

        Map<String, dynamic> data = jsonDecode(response.body);

        int totalItems = data['hydra:totalItems'];
        List<dynamic> result = data['hydra:member'];
        for (int i = 0; i < totalItems; i++) {
          print(i);
          PostsUiDataModel post = PostsUiDataModel.fromJson(result[i]);
          posts.add(post);
        }
      }
    } catch (e) {
    } finally {
      client.close(); // Close the HttpClient
    }
    return [];
  }
}
