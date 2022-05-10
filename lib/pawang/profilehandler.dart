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

class ProfileHandler {
  FirebaseAuth auth = FirebaseAuth.instance;
  FirebaseFirestore postLib = FirebaseFirestore.instance;
  FirebaseStorage postStorage = FirebaseStorage.instance;

  List ud = [];

  follow(String uid, String id_target) async {
    try {
      if (uid != id_target) {
        int sudahkah = await postLib
            .collection("following")
            .where("id_follower", isEqualTo: uid)
            .where("has_followed", isEqualTo: id_target)
            .get()
            .then((value) => value.size);

        if (sudahkah <= 0) {
          await FirebaseFirestore.instance.collection("following").doc().set({
            "id_follower": uid,
            "has_followed": id_target,
            "follow_date": Timestamp.now()
          });
          return true;
        } else {
          print("sudah follow");
          await postLib
              .collection("following")
              .where("id_follower", isEqualTo: uid)
              .where("has_followed", isEqualTo: id_target)
              .get()
              .then((value) => value.docs.forEach((element) {
                    element.reference.delete();
                  }));
          return false;
        }
      } else {
        return false;
      }
    } catch (e) {
      return false;
    }
  }

  Stream checkfollow(String uid, String id_target) async* {
    int follcount = await postLib
        .collection("following")
        .where("has_followed", isEqualTo: id_target)
        .get()
        .then((value) => value.size);

    print("follower count = $follcount");

    int sudahkah = await postLib
        .collection("following")
        .where("id_follower", isEqualTo: uid)
        .where("has_followed", isEqualTo: id_target)
        .get()
        .then((value) => value.size);

    if (sudahkah > 0) {
      print("lil");
      yield {"hasfollow": true, "followercount": follcount};
    } else {
      yield {"hasfollow": false, "followercount": follcount};
    }
  }

  checkfollow2(String uid, String id_target) async {
    int follcount = await postLib
        .collection("following")
        .where("has_followed", isEqualTo: id_target)
        .get()
        .then((value) => value.size);

    print("follower count = $follcount");

    int sudahkah = await postLib
        .collection("following")
        .where("id_follower", isEqualTo: uid)
        .where("has_followed", isEqualTo: id_target)
        .get()
        .then((value) => value.size);

    if (sudahkah > 0) {
      print("lil");
      return {"hasfollow": true, "followercount": follcount};
    } else {
      return {"hasfollow": false, "followercount": follcount};
    }
  }

  followingcount(String id_target) async {
    int following = await postLib
        .collection("following")
        .where("id_follower", isEqualTo: id_target)
        .get()
        .then((value) => value.size);

    return following;
  }
}
