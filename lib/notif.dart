import 'package:borca2/auth_service.dart';
import 'package:borca2/object/postingan.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:borca2/object/bidtile.dart';

class Notif extends StatefulWidget {
  const Notif({Key? key}) : super(key: key);
  @override
  NotifState createState() => new NotifState();
}

class NotifState extends State<Notif> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: StreamBuilder(
      stream: FirebaseFirestore.instance.collection("auction").snapshots(),
      builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
        if (snapshot.hasData) {
          return ListView(
              children: snapshot.data!.docs.map((e) {
            BidModel bm = BidModel.fromJson(e.data() as dynamic);
            return BidTile(bid: bm);
          }).toList());
        }
        return CircularProgressIndicator();
      },
    ));
  }
}
