import 'dart:convert';

List<MessageuiDataModel> messageuiDataModelFromJson(String str) =>
    List<MessageuiDataModel>.from(
        json.decode(str).map((x) => MessageuiDataModel.fromJson(x)));

String messageuiDataModelToJson(List<MessageuiDataModel> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class MessageuiDataModel {
  String id;
  String msgid;
  From from;
  List<From> to;
  String subject;
  String intro;
  bool seen;
  bool isDeleted;
  bool hasAttachments;
  int size;
  String downloadUrl;
  String sourceUrl;
  DateTime createdAt;
  DateTime updatedAt;
  String accountId;

  MessageuiDataModel({
    required this.id,
    required this.msgid,
    required this.from,
    required this.to,
    required this.subject,
    required this.intro,
    required this.seen,
    required this.isDeleted,
    required this.hasAttachments,
    required this.size,
    required this.downloadUrl,
    required this.sourceUrl,
    required this.createdAt,
    required this.updatedAt,
    required this.accountId,
  });

  factory MessageuiDataModel.fromJson(Map<String, dynamic> json) =>
      MessageuiDataModel(
        id: json["id"],
        msgid: json["msgid"],
        from: From.fromJson(json["from"]),
        to: List<From>.from(json["to"].map((x) => From.fromJson(x))),
        subject: json["subject"],
        intro: json["intro"],
        seen: json["seen"],
        isDeleted: json["isDeleted"],
        hasAttachments: json["hasAttachments"],
        size: json["size"],
        downloadUrl: json["downloadUrl"],
        sourceUrl: json["sourceUrl"],
        createdAt: DateTime.parse(json["createdAt"]),
        updatedAt: DateTime.parse(json["updatedAt"]),
        accountId: json["accountId"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "msgid": msgid,
        "from": from.toJson(),
        "to": List<dynamic>.from(to.map((x) => x.toJson())),
        "subject": subject,
        "intro": intro,
        "seen": seen,
        "isDeleted": isDeleted,
        "hasAttachments": hasAttachments,
        "size": size,
        "downloadUrl": downloadUrl,
        "sourceUrl": sourceUrl,
        "createdAt": createdAt.toIso8601String(),
        "updatedAt": updatedAt.toIso8601String(),
        "accountId": accountId,
      };
}

class From {
  String address;
  String name;

  From({
    required this.address,
    required this.name,
  });

  factory From.fromJson(Map<String, dynamic> json) => From(
        address: json["address"],
        name: json["name"],
      );

  Map<String, dynamic> toJson() => {
        "address": address,
        "name": name,
      };
}
