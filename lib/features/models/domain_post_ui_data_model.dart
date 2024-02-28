import 'dart:convert';

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

  factory PostsUiDataModel.fromJson(Map<String, dynamic> json) {
    return PostsUiDataModel(
      id: json['id'],
      domain: json['domain'],
      isActive: json['isActive'],
      isPrivate: json['isPrivate'],
      createdAt: DateTime.parse(json['createdAt']),
      updatedAt: DateTime.parse(json['updatedAt']),
    );
  }
}
