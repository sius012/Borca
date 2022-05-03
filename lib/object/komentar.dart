import 'package:cloud_firestore/cloud_firestore.dart';

class Komentar {
  String? id;
  final String isi;
  final Timestamp tanggal;
  final String id_user;
  final String id_post;
  Komentar(
      {required this.isi,
      required this.tanggal,
      required this.id_user,
      required this.id_post,
      this.id});

  Map<String, dynamic> toJson() => {
        "id": id,
        "isi": isi,
        "tanggal": Timestamp.now(),
        "id_user": id_user,
        "id_post": id_post,
      };

  static Komentar fromJson(Map<String, dynamic> json) => Komentar(
      isi: json["isi"],
      tanggal: Timestamp.now(),
      id_user: json["id_user"],
      id_post: json["id_user"],
      id: json["id"]);
}
