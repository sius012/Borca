import 'dart:convert';
import 'dart:io';
import 'package:borca2/login.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_storage/firebase_storage.dart';
import '../object/postingan.dart';
import '../object/like.dart';
import '../auth_service.dart';

class PostHandler {
  FirebaseAuth auth = FirebaseAuth.instance;
  FirebaseFirestore postLib = FirebaseFirestore.instance;
  FirebaseStorage postStorage = FirebaseStorage.instance;

  List ud = [];

  udAdd(Users u) {
    ud.add(ud);
  }

  likepost(Like liked, String uid) async {
    //check before like
    var jml = 0;
    var get = await FirebaseFirestore.instance
        .collection("like")
        .where("id_liker", isEqualTo: uid)
        .where("id_post", isEqualTo: liked.id_post)
        .get()
        .then((value) => jml = value.size);
    print("jumlahnya = " + jml.toString());
    if (jml < 1) {
      var like = FirebaseFirestore.instance.collection("like").doc();
      var likedata = await liked.toJson();
      await like.set(likedata);
      return true;
    } else {
      print("dgs");
      var liko = await FirebaseFirestore.instance
          .collection("like")
          .where("id_liker", isEqualTo: uid)
          .where("id_post", isEqualTo: liked.id_post)
          .get()
          .then((value) {
        value.docs.first.reference.delete();
        print("dsgs");
      });
      return false;
    }
  }

  postingbos(PostModel post, File image) async {
    var modelPost = post;
    var docUser = postLib.collection('post_collection').doc();

    PostModel pm = PostModel(
        date: DateTime.now(),
        id_user: post.id_user,
        picname: "postingannya-" + docUser.id,
        title: post.title,
        description: post.description,
        alamat: post.alamat,
        typepost: post.typepost,
        owner_id: post.owner_id,
        desc_type: post.desc_type,
        id: docUser.id);

    final dU = pm.toJson();
    final id_post = docUser.id;

    await docUser.set(dU);

    final String photoname = "postingannya-$id_post";
    await postStorage.ref('thepost/$id_post/$photoname').putFile(image);
    print("mencoba eksekusi");
  }

  getImageDownload(String url, String postid) async {
    print("postingan : " + url);
    try {
      var downloadUrl = postStorage;
      String downloadLink =
          await downloadUrl.ref("thepost/$postid/$url").getDownloadURL();
      print("ada gan");
      return downloadLink;
    } catch (error) {
      print('file not found');
      return "[kosong]";
    }
  }
}
