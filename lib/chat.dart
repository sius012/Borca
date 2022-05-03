import 'package:borca2/chatdetail.dart';
import 'package:borca2/login.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'auth_service.dart';

class Chat extends StatefulWidget {
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
        child: StreamBuilder(stream: FirebaseFirestore.instance.collection("users_detail").snapshots(),builder: (context, AsyncSnapshot<Qu),)
      ),
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
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => new Chatdetail()));
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
                    FutureBuilder(
                        future: _getUserdetail(),
                        builder: (context, snapshot) {
                          if (snapshot.connectionState ==
                              ConnectionState.done) {
                            if (snapshot.data != null) {
                              new Text(
                                (snapshot.data as Map)["username"],
                                style: TextStyle(fontWeight: FontWeight.bold),
                              );
                            } else {
                              return Text("data kosong");
                            }
                          }

                          return CircularProgressIndicator();
                        }),
                    new Text("halo samadng...")
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
