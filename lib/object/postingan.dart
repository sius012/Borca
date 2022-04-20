import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../auth_service.dart';

import '../pawang/post_handler.dart';

class PostModel {
  String? id_user;
  final String picname;
  final DateTime date = DateTime.now();
  final String title;
  final String description;
  String? alamat = null;
  String? typepost = "";
  String? desc_type = 'quotes';
  String? owner_id;
  String? id;
  String username = "username";
  String nameL = "namal";

  PostModel(
      {required this.id_user,
      required this.picname,
      required this.title,
      required this.description,
      required this.alamat,
      required this.typepost,
      required this.owner_id,
      required this.desc_type,
      required this.id});

  Map<String, dynamic> toJson() => {
        'id_user': id_user,
        'picname': picname,
        'date': date.toString(),
        'title': title,
        'typepost': typepost,
        'alamat': alamat,
        'owner_id': owner_id,
        'desc_type': desc_type,
        'id': id,
        'description': description,
      };

  static PostModel fromJson(Map<String, dynamic> json) => PostModel(
      id_user: json['id_user'],
      picname: json['picname'],
      title: json['title'],
      description: json['description'],
      alamat: json['alamat'],
      typepost: json['typepost'],
      owner_id: json['owner_id'],
      desc_type: json['desc_type'],
      id: json['id']);
}

class PostWid extends StatelessWidget {
  final PostModel post;
  final Users ud;
  final String uid;
  const PostWid(
      {Key? key, required this.post, required this.ud, required this.uid})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return new SizedBox(
      height: 560,
      child: new Stack(
        clipBehavior: Clip.none,
        children: <Widget>[
          new Positioned(
            top: 355,
            child: new SizedBox(
              width: 400,
              height: 200,
              child: new Container(
                margin: new EdgeInsets.all(10),
                child: new Container(
                  child: new Column(
                    children: [
                      new Padding(padding: new EdgeInsets.only(bottom: 50)),
                      new Container(
                        decoration: BoxDecoration(
                            border: Border.all(
                                width: 2.0,
                                color: Color.fromARGB(255, 230, 230, 230)),
                            borderRadius: BorderRadius.only(
                                bottomLeft: Radius.circular(10),
                                bottomRight: Radius.circular(10))),
                        child: new Padding(
                          padding: new EdgeInsets.all(10),
                          child: new Row(
                            children: [
                              new Row(
                                children: [
                                  new CircleAvatar(
                                    child: ClipRRect(
                                      borderRadius: BorderRadius.circular(50.0),
                                      child: Image.asset("assets/pp/pp.jpeg"),
                                    ),
                                  ),
                                ],
                              ),
                              new Padding(padding: EdgeInsets.only(right: 10)),
                              new Text("tambahkan Komentar"),
                              new Spacer(),
                              new Icon(Icons.send)
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(30),
                    boxShadow: [
                      BoxShadow(
                          color: Color.fromARGB(111, 0, 0, 0),
                          spreadRadius: 5,
                          blurRadius: 7)
                    ],
                    color: Color.fromARGB(255, 255, 255, 255)),
              ),
            ),
          ),
          new Positioned(
            top: 180,
            child: new SizedBox(
              width: 400,
              height: 250,
              child: new Container(
                margin: new EdgeInsets.all(10),
                child: new Container(
                  margin: EdgeInsets.all(20),
                  child: new Column(
                    children: [
                      new Padding(padding: new EdgeInsets.only(bottom: 50)),
                      new Row(
                        children: [
                          new Row(
                            children: [
                              new SvgPicture.asset(
                                "assets/icons/heart.svg",
                                width: 20,
                              ),
                              new Padding(padding: new EdgeInsets.all(3)),
                              new Text(
                                "12k",
                                style: TextStyle(
                                    fontWeight: FontWeight.bold, fontSize: 14),
                              )
                            ],
                          ),
                          new Padding(padding: new EdgeInsets.all(10)),
                          post.typepost != "Main Post"
                              ? new Row(
                                  children: [
                                    new SvgPicture.asset(
                                      "assets/icons/bid.svg",
                                      width: 20,
                                    ),
                                    new Padding(padding: new EdgeInsets.all(3)),
                                    new Text(
                                      "12k",
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 20),
                                    )
                                  ],
                                )
                              : Container(),
                        ],
                      ),
                      new Padding(padding: EdgeInsets.all(10)),
                      new Row(
                        children: [
                          new Text(
                            ud.namaL,
                            style: TextStyle(
                                fontSize: 12, fontWeight: FontWeight.bold),
                          ),
                          new Text(
                            post.desc_type == "Caption"
                                ? "Menambahkan Sebuah Caption"
                                : "Menambahkan Sebuah Quotes",
                            style: TextStyle(
                              fontSize: 12,
                            ),
                          )
                        ],
                      ),
                      new Text(post.description),
                      new Padding(padding: new EdgeInsets.all(10)),
                      new Row(
                        children: [
                          new Icon(Icons.message),
                          new Spacer(),
                          Icon(Icons.share)
                        ],
                      )
                    ],
                  ),
                ),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(30),
                    boxShadow: [
                      BoxShadow(
                          color: Color.fromARGB(111, 0, 0, 0),
                          spreadRadius: 5,
                          blurRadius: 7)
                    ],
                    color: Color.fromARGB(255, 255, 255, 255)),
              ),
            ),
          ),
          new Positioned(
            top: 50,
            child: new SizedBox(
              width: 410,
              height: 200,
              child: new Container(
                margin: new EdgeInsets.all(10),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(30),
                    boxShadow: [
                      BoxShadow(
                          color: Color.fromARGB(50, 0, 0, 0),
                          spreadRadius: 5,
                          blurRadius: 7)
                    ],
                    image: DecorationImage(
                        image: new NetworkImage(PostHandler()
                            .getImageDownload(post.picname, post.id!)),
                        fit: BoxFit.cover)),
                child: new Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Container(
                        margin: new EdgeInsets.all(10),
                        decoration:
                            BoxDecoration(shape: BoxShape.circle, boxShadow: [
                          BoxShadow(
                            color: Color.fromARGB(100, 0, 0, 0),
                            blurRadius: 5.0,
                          ),
                        ]),
                        child: Icon(
                          Icons.info_outline_rounded,
                          color: Color.fromARGB(255, 255, 255, 255),
                          size: 25,
                        )),
                  ],
                ),
              ),
            ),
          ),
          new SizedBox(
            width: 350,
            height: 90,
            child: new Container(
              margin: new EdgeInsets.only(left: 10),
              child: new Padding(
                padding: EdgeInsets.symmetric(horizontal: 10, vertical: 15),
                child: new Row(
                  children: [
                    new CircleAvatar(
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(50.0),
                        child: new Image.network(PostHandler()
                            .getImageDownload(post.picname, post.id!)),
                      ),
                    ),
                    new Padding(padding: EdgeInsets.symmetric(horizontal: 4)),
                    new Container(
                      child: new Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          new Row(
                            children: [
                              new Text(
                                ud.username,
                                style: new TextStyle(
                                    fontSize: 15,
                                    color: Colors.black,
                                    fontWeight: FontWeight.bold),
                              ),
                              ud.level == "artisan"
                                  ? new Icon(
                                      Icons.verified,
                                      color: Color.fromARGB(255, 82, 192, 232),
                                    )
                                  : new Icon(
                                      Icons.verified,
                                      color: Color.fromARGB(255, 190, 182, 65),
                                    ),
                            ],
                          ),
                          new Row(
                            children: [new Text("Berada dalam naungan")],
                          ),
                          new Row(
                            children: [
                              new Text(
                                "5 menit yg lalu",
                                style: TextStyle(fontSize: 12),
                              )
                            ],
                          ),
                        ],
                      ),
                    ),
                    new Spacer(),
                    new SvgPicture.asset(
                      "assets/icons/bar.svg",
                      width: 4,
                    )
                  ],
                ),
              ),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(20),
                boxShadow: [
                  BoxShadow(
                      color: Color.fromARGB(54, 0, 0, 0),
                      spreadRadius: 2,
                      blurRadius: 5)
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
