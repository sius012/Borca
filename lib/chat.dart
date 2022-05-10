import 'package:borca2/chatdetail.dart';
import 'package:borca2/login.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'auth_service.dart';
import 'package:firebase_auth/firebase_auth.dart';

class Chat extends StatefulWidget {
  final User userdata;
  const Chat({Key? key, required this.userdata}) : super(key: key);
  @override
  _ChatState createState() => new _ChatState();
}

class _ChatState extends State<Chat> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: new AppBar(
        leading: new Icon(
          Icons.message,
          color: Colors.black,
        ),
        backgroundColor: Colors.white,
        title: new Text(
          "Message",
          style: TextStyle(color: Colors.black),
        ),
        actions: [
          new Padding(
            padding: EdgeInsets.all(10),
            child: new CircleAvatar(),
          )
        ],
      ),
      body: new Container(
          padding: EdgeInsets.all(2),
          child: StreamBuilder(
            stream: FirebaseFirestore.instance
                .collection("users_detail")
                .snapshots(),
            builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
              if (snapshot.hasData) {
                return ListView(
                  children: snapshot.data!.docs.map((e) {
                    return ChatUserTile(
                        id_user: widget.userdata.uid, id_target: e.id);
                  }).toList(),
                );
              }
              return CircularProgressIndicator();
            },
          )),
    );
  }
}

class ChatUserTile extends StatefulWidget {
  final String id_user;
  final String id_target;

  const ChatUserTile({Key? key, required this.id_user, required this.id_target})
      : super(key: key);

  @override
  _ChatUserState createState() => _ChatUserState();
}

class _ChatUserState extends State<ChatUserTile> {
  FirebaseFirestore instance = FirebaseFirestore.instance;

  Users? ud;
  Users? udetail;
  String? lastchat;
  bool? lastme;

  _getlastchat() async {
    var dato = await instance
        .collection("chat")
        .where("id_user", whereIn: [widget.id_target, widget.id_user])
        .snapshots()
        .map((event) => event.docs.map((e) {
              if (e.data()["to"] == widget.id_target ||
                  e.data()["to"] == widget.id_user) {
                return e.data()["message"];
              }
            }))
        .toList();

    print("fdsfwf${dato}");

    lastchat = dato != null ? dato.last.toString() : "";
  }

  Future _getUserdetail() async {
    Map? ud;

    await FirebaseFirestore.instance
        .collection("users_detail")
        .doc(widget.id_target)
        .get()
        .then((value) => ud = value.data() as Map);

    if (ud != null) {
      return ud!;
    }
    return null;
  }

  @override
  void initState() {
    super.initState();

    //getusername, etc
    FirebaseFirestore.instance
        .collection("users_detail")
        .doc(widget.id_target)
        .get()
        .then((value) {
      print("datanya ada");
      setState(() {
        udetail = udetail = Users.fromJson(value.data()!);
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => new Chatdetail(
                      ud: udetail!,
                      uid: widget.id_user,
                    )));
      },
      child: new Card(
        elevation: 1,
        child: Container(
            padding: new EdgeInsets.all(10),
            child: new Row(
              children: [
                new CircleAvatar(
                  radius: 24,
                  backgroundColor: Colors.green,
                  child: CircleAvatar(
                    backgroundImage: AssetImage("assets/pp/pp.jpeg"),
                    backgroundColor: Colors.red,
                  ),
                ),
                new Padding(padding: EdgeInsets.all(4)),
                new Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    new Text(
                      udetail != null ? udetail!.username : "tiddak ada",
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    FutureBuilder(
                        future: _getlastchat(),
                        builder: (context, snapshot) {
                          if (snapshot.connectionState ==
                              ConnectionState.done) {
                            return new Text(lastchat!);
                          }

                          return new Text("");
                        })
                  ],
                ),
                new Spacer(),
                new Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [new Text("15.00 pm")],
                )
              ],
            )),
      ),
    );
  }
}
