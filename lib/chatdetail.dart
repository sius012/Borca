import 'package:borca2/login.dart';
import 'package:borca2/object/chatModel.dart';
import 'package:borca2/object/postingan.dart';
import 'package:borca2/pawang/chathandler.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'auth_service.dart';
import 'package:intl/intl.dart';

class Chatdetail extends StatefulWidget {
  final Users ud;
  final String uid;
  const Chatdetail({Key? key, required this.ud, required this.uid})
      : super(key: key);
  @override
  _ChatdetailState createState() => new _ChatdetailState();
}

class _ChatdetailState extends State<Chatdetail> {
  late TextEditingController komen;
  ChatHandler chand = ChatHandler();

  @override
  void initState() {
    super.initState();

    komen = new TextEditingController();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: new AppBar(
        leading: new Container(
          margin: EdgeInsets.all(10),
          child: new CircleAvatar(
            backgroundImage: AssetImage("assets/pp/pp.jpeg"),
          ),
        ),
        backgroundColor: Colors.white,
        title: new Text(
          widget.ud.namaL,
          style:
              TextStyle(color: Color.fromARGB(255, 80, 80, 80), fontSize: 13),
        ),
        actions: [],
      ),
      body: new Container(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
          child: new Stack(
            children: [
              new StreamBuilder(
                  stream: FirebaseFirestore.instance.collection("chat").where(
                      "id_user",
                      whereIn: [widget.uid, widget.ud.id_user]).snapshots(),
                  builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
                    if (snapshot.hasData) {
                      return ListView(
                        children: snapshot.data!.docs.map((e) {
                          ChatModel docs = ChatModel.fromJson(
                              e.data() as Map<String, dynamic>);
                          return (e.data() as Map)["to"] == widget.uid ||
                                  (e.data() as Map)["to"] == widget.ud.id_user
                              ? ChatBubble(
                                  uid: widget.uid,
                                  text: docs.message,
                                  tgl: docs.timestamp!.toDate(),
                                  idku: docs.id_user,
                                  idc: docs.to,
                                  hasRead: docs.hasRead)
                              : Container();
                        }).toList(),
                      );
                    }
                    return CircularProgressIndicator();
                  }),
              new Align(
                alignment: Alignment.bottomCenter,
                child: new Container(
                  decoration: BoxDecoration(boxShadow: [
                    BoxShadow(
                        blurRadius: 20, color: Color.fromARGB(100, 0, 0, 0))
                  ], color: Colors.white),
                  padding: EdgeInsets.all(10),
                  child: new Row(
                    children: [
                      new Container(
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            border: Border.all(
                                width: 2,
                                color: Color.fromARGB(255, 105, 115, 229))),
                        width: MediaQuery.of(context).size.width - 80,
                        child: new TextField(
                          controller: komen,
                        ),
                      ),
                      new IconButton(
                          onPressed: () async {
                            if (komen.text != null && !komen.text.isEmpty) {
                              ChatModel cm = ChatModel(
                                  hasRead: false,
                                  message: komen.text,
                                  id_user: widget.uid,
                                  to: widget.ud.id_user,
                                  timestamp: Timestamp.now());

                              await chand.sendChat(cm);
                              setState(() {
                                komen.text = "";
                              });
                            }
                          },
                          icon: Icon(Icons.send))
                    ],
                  ),
                ),
              )
            ],
          )),
    );
  }
}

class ChatBubble extends StatefulWidget {
  final String uid;
  final String text;
  final DateTime tgl;
  final String idku;
  final String idc;
  final bool hasRead;
  const ChatBubble(
      {Key? key,
      required this.text,
      required this.tgl,
      required this.idku,
      required this.idc,
      required this.hasRead,
      required this.uid})
      : super(key: key);

  @override
  State<ChatBubble> createState() => _ChatBubbleState();
}

class _ChatBubbleState extends State<ChatBubble> {
  double heightcont = 0;
  double widthcount = 0;
  double padLeft = 0;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    if (widget.idc == widget.idku) {
      padLeft = -20.toDouble();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: widget.uid == widget.idku
          ? MainAxisAlignment.end
          : MainAxisAlignment.start,
      children: [
        Container(
          height: heightcont,
          width: widthcount + 10,
          constraints: BoxConstraints(),
          margin: EdgeInsets.symmetric(horizontal: 10, vertical: 25),
          child: new Stack(
            clipBehavior: Clip.none,
            children: [
              new Positioned(
                  left: 10,
                  top: 30,
                  child: MeasureSize(
                    onChange: (size) {
                      setState(() {
                        heightcont = size.height;
                        widthcount = size.width;
                      });
                    },
                    child: new Container(
                        constraints:
                            BoxConstraints(minWidth: 100, maxWidth: 200),
                        padding: EdgeInsets.all(10),
                        decoration: BoxDecoration(
                            color: widget.uid == widget.idku
                                ? Colors.blue
                                : Colors.white,
                            borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(0),
                                topRight: Radius.circular(10),
                                bottomLeft: Radius.circular(10),
                                bottomRight: Radius.circular(10)),
                            border: Border.all(
                                width: 1,
                                color: Color.fromARGB(26, 33, 33, 33))),
                        child: new Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            new Text(
                              widget.text,
                              style: TextStyle(
                                  color: widget.uid == widget.idku
                                      ? Color.fromARGB(255, 255, 255, 255)
                                      : Color.fromARGB(255, 0, 0, 0)),
                            ),
                            new Padding(padding: EdgeInsets.all(5)),
                            new Row(
                              children: [
                                new Text(
                                  DateFormat("hh:mm a").format(widget.tgl),
                                  style: TextStyle(
                                      fontSize: 12,
                                      color: widget.uid == widget.idku
                                          ? Color.fromARGB(255, 255, 255, 255)
                                          : Color.fromARGB(255, 105, 105, 105)),
                                ),
                                new Spacer(),
                                widget.uid == widget.idku
                                    ? widget.hasRead
                                        ? Icon(Icons.check_rounded,
                                            color: Colors.white)
                                        : Icon(
                                            Icons.mark_chat_read,
                                            color: Colors.white,
                                          )
                                    : new Container(),
                              ],
                            )
                          ],
                        )),
                  )),
              widget.uid != widget.idku
                  ? new Positioned(
                      child: new Container(
                          child: new CircleAvatar(
                        radius: 20,
                        child: new CircleAvatar(
                          radius: 15,
                          backgroundColor: Colors.blue,
                        ),
                      )),
                    )
                  : new Container(),
            ],
          ),
        )
      ],
    );
  }
}
