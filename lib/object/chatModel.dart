import 'package:cloud_firestore/cloud_firestore.dart';

class ChatModel {
  final String message;
  final String id_user;
  final String to;
  final bool hasRead;
  Timestamp? timestamp = Timestamp.now();
  ChatModel(
      {required this.message,
      required this.id_user,
      required this.to,
      required this.hasRead,
      this.timestamp});

  static fromJson(Map<String, dynamic> json) => ChatModel(
      message: json["message"],
      id_user: json["id_user"],
      to: json["to"],
      hasRead: json["hasRead"],
      timestamp: json["timestamp"]);

  Map<String, dynamic> toJson() => {
        "message": message,
        "id_user": message,
        "to": message,
        "hasRead": hasRead,
        "timestamp": timestamp
      };
}
