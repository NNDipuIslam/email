import 'dart:convert';

PostsUiDataModel postsUiDataModelFromJson(String str) =>
    PostsUiDataModel.fromJson(json.decode(str));

String postsUiDataModelToJson(PostsUiDataModel data) =>
    json.encode(data.toJson());

class PostsUiDataModel {
  String id;
  String domain;
  bool isActive;
  bool isPrivate;
  DateTime createdAt;
  DateTime updatedAt;

  PostsUiDataModel({
    required this.id,
    required this.domain,
    required this.isActive,
    required this.isPrivate,
    required this.createdAt,
    required this.updatedAt,
  });

  factory PostsUiDataModel.fromJson(Map<String, dynamic> json) =>
      PostsUiDataModel(
        id: json["id"],
        domain: json["domain"],
        isActive: json["isActive"],
        isPrivate: json["isPrivate"],
        createdAt: DateTime.parse(json["createdAt"]),
        updatedAt: DateTime.parse(json["updatedAt"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "domain": domain,
        "isActive": isActive,
        "isPrivate": isPrivate,
        "createdAt": createdAt.toIso8601String(),
        "updatedAt": updatedAt.toIso8601String(),
      };
}
