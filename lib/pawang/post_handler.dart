import 'dart:convert';
import 'dart:io';
import 'package:borca2/login.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_storage/firebase_storage.dart';
import '../object/postingan.dart';
import '../auth_service.dart';

class PostHandler {
  FirebaseAuth auth = FirebaseAuth.instance;
  FirebaseFirestore postLib = FirebaseFirestore.instance;
  FirebaseStorage postStorage = FirebaseStorage.instance;

  List ud = [];

  udAdd(Users u) {
    ud.add(ud);
  }

  postingbos(PostModel post, File image) async {
    var modelPost = post;
    var docUser = postLib.collection('post_collection').doc();

    PostModel pm = PostModel(
        id_user: post.id_user,
        picname: post.picname,
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

    final String photoname = "Fotonya-$id_post";
    await postStorage.ref('thepost/$id_post/$photoname').putFile(image);
    print("mencoba eksekusi");
  }

  getImageDownload(String url, String postid) async {
    String downloadUrl =
        await postStorage.ref('thepost/$postid/$url').getDownloadURL();
    return downloadUrl;
  }

  showHome() async {
    print("ssss");
    List<PostModel>? postmodel;
    QuerySnapshot querySnapshot =
        await postLib.collection("post_collection").get();

    // Get data from docs and convert map to List
    final allData = querySnapshot.docs.map((doc) {
      return doc.data();
    }).toList();

    var lol = allData.map((e) {
      print("fsd");
      var ud2 = postLib
          .collection("users_detail")
          .where("id_user", isEqualTo: (e as dynamic)['id_user'])
          .get()
          .then((value) => print("lf"));
    });
    print(ud);
  }
}
