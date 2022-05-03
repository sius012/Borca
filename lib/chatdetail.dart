import 'package:borca2/login.dart';
import 'package:borca2/object/postingan.dart';
import 'package:flutter/material.dart';
import 'auth_service.dart';
import 'package:intl/intl.dart';

class Chatdetail extends StatefulWidget {
  @override
  _ChatdetailState createState() => new _ChatdetailState();
}

class _ChatdetailState extends State<Chatdetail> {
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
          "Surya Mahadita",
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
              new ListView(
                children: [
                  ChatBubble(
                    text: "Halfffffffffffffffffffffffffffffffffffff",
                    tgl: DateTime.now(),
                    idc: "fdfdfsdg",
                    idku: "fsfasfasfas",
                    hasRead: false,
                  ),
                  ChatBubble(
                    text:
                        "Halfffffffffffffffffffffffffffffffffffffffddddffffffffffffffffffofdsfsdfsdffffffffffffffffffffffffffffffffffffffffffffffffff",
                    tgl: DateTime.now(),
                    idc: "fsfasfasfas",
                    idku: "fsfasfasfas",
                    hasRead: true,
                  ),
                ],
              ),
              Align(
                alignment: Alignment.bottomCenter,
                child: new Container(
                    decoration: BoxDecoration(boxShadow: [
                      BoxShadow(blurRadius: 10, spreadRadius: -5)
                    ], color: Colors.white),
                    padding: EdgeInsets.all(10),
                    child: new Row(
                      children: [
                        new Container(
                          width: MediaQuery.of(context).size.width - 80,
                          child: TextFormField(
                            decoration:
                                InputDecoration(hintText: "Masukan Pesan"),
                          ),
                        ),
                        new IconButton(
                            onPressed: () {},
                            icon: Icon(
                              Icons.send,
                              color: Colors.black,
                            ))
                      ],
                    )),
              )
            ],
          )),
    );
  }
}

class ChatBubble extends StatefulWidget {
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
      required this.hasRead})
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
      mainAxisAlignment: widget.idku == widget.idc
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
                            color: widget.idc == widget.idku
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
                                  color: widget.idc == widget.idku
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
                                      color: widget.idc == widget.idku
                                          ? Color.fromARGB(255, 255, 255, 255)
                                          : Color.fromARGB(255, 105, 105, 105)),
                                ),
                                new Spacer(),
                                widget.idc == widget.idku
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
              widget.idc != widget.idku
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
