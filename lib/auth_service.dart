import 'dart:convert';

import 'package:borca2/login.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';

class AuthService {
  FirebaseAuth auth = FirebaseAuth.instance;
  FirebaseFirestore dataDetail = FirebaseFirestore.instance;

  User? user;
  Users? getUser;

  changedata(data) {
    getUser = data;
  }

  changedata2(data) {
    getUser = data;
  }

  getDetail(id_user) async {
    var userdata = await dataDetail
        .collection('users_detail')
        .where("id_user", isEqualTo: id_user)
        .snapshots()
        .map((event) => changedata(Users.fromJson(event.docs.first.data())));

    var data = userdata.first;
    print("thedata :$data");
    var arr = [];

    return null;
  }

  getDetail2(id_user) async {
    var userdata = await dataDetail
        .collection('users_detail')
        .where("id_user", isEqualTo: id_user)
        .snapshots()
        .map((event) => changedata(Users.fromJson(event.docs.first.data())));
  }

  registerUser(
      {required String name,
      required String email,
      required String password,
      required String namalengkap}) async {
    try {
      final UserCredential userCredential = await auth
          .createUserWithEmailAndPassword(email: email, password: password);

      user = userCredential.user;
      user = auth.currentUser;
      if (userCredential != null) {
        final docUser = FirebaseFirestore.instance
            .collection('users_detail')
            .doc(user!.uid);

        getDetail(user!.uid);
        final dU = Users(
            id_user: user!.uid,
            id: '',
            level: "sesepuh",
            username: name,
            namaL: namalengkap);

        final json = dU.toJson();

        await docUser.set(json);
      }
    } catch (e) {
      print(e.toString());
    }

    return [user, getUser];
  }

  loginUser({required String email, required String password}) async {
    try {
      final UserCredential userCredential = await auth
          .signInWithEmailAndPassword(email: email, password: password);

      user = userCredential.user;

      getDetail(user!.uid);
    } catch (e) {
      print(e.toString());
    }
    return [user, getUser];
  }

  getuserdetail(String uid) async {
    Users? realdu;

    await FirebaseFirestore.instance
        .collection('users_detail')
        .where("id_user", isEqualTo: uid)
        .get()
        .then((value) => realdu = Users.fromJson(value.docs.first.data()));

    if (realdu != null) {
      print("DATA ADA BOS");
      return realdu;
    } else {
      print("DATA KOSONG BOS");
    }
  }

  logoutUser() async {
    await FirebaseAuth.instance.signOut();
  }
}

class Users {
  final String id;
  final String id_user;
  final String username;
  final String level;
  final String namaL;

  Users(
      {this.id = '',
      required this.username,
      required this.level,
      required this.id_user,
      required this.namaL});

  Map<String, dynamic> toJson() => {
        'id': id,
        'id_user': id_user,
        'username': username,
        'level': level,
        'nama_lengkap': namaL,
      };

  static Users fromJson(Map<String, dynamic> json) => Users(
      id: "none",
      username: json['username'],
      level: json['level'],
      id_user: json['id_user'],
      namaL: json['nama_lengkap']);
}
