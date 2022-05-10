import 'dart:convert';
import 'dart:io';
import 'package:borca2/login.dart';
import 'package:borca2/object/bidtile.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_storage/firebase_storage.dart';
import '../object/postingan.dart';
import '../object/like.dart';
import '../auth_service.dart';
import 'package:borca2/object/komentar.dart';
import 'package:borca2/object/chatModel.dart';

class ChatHandler {
  Stream<QuerySnapshot> getUserChatList(String id_user) async* {
    var dato =
        FirebaseFirestore.instance.collection("users_detail").snapshots();
  }

  sendChat(ChatModel chat) async {
    FirebaseFirestore.instance.collection("chat").doc().set(chat.toJson());
  }

  Stream readChat(String id_target, String uid) async* {
    var dato = await FirebaseFirestore.instance
        .collection("chat")
        .where("id_user", whereIn: [uid, id_target])
        .orderBy("timestamp", descending: false)
        .snapshots();
    yield dato;
  }
}
