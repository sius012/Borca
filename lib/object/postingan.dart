import 'package:borca2/object/bidtile.dart';
import 'package:borca2/profile.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../auth_service.dart';

import '../pawang/post_handler.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../pawang/post_handler.dart';
import 'like.dart';
import 'package:borca2/object/komentar.dart';
import 'package:flutter/rendering.dart';

typedef void OnWidgetSizeChange(Size size);

class PostModel {
  String? id_user;
  final String picname;
  Timestamp? date = Timestamp.now();
  final String title;
  String? description;
  String? alamat = null;
  String? typepost = "";
  String? desc_type = 'quotes';
  String? owner_id;
  String? id = "fdfdf";
  String? username = "username";
  String? nameL = "namal";

  PostModel(
      {required this.id_user,
      required this.picname,
      required this.title,
      this.description,
      required this.alamat,
      required this.typepost,
      required this.owner_id,
      required this.desc_type,
      this.id,
      this.date});

  Map<String, dynamic> toJson() => {
        'id_user': id_user,
        'picname': picname,
        'date': date,
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
      date: json['date'] == "null" ? Timestamp.now() : Timestamp.now(),
      id: json['id']);
}

class PostWid extends StatefulWidget {
  final PostModel post;
  String? id_user;

  PostWid({Key? key, required this.post, this.id_user}) : super(key: key);

  @override
  State<PostWid> createState() => _PostWidState();
}

class _PostWidState extends State<PostWid> {
  late TextEditingController komentar;

  late TextEditingController bidamount;
  late TextEditingController descbid;

  int? likepost;
  var imgdownload;
  bool haslike = false;
  PostHandler ph = new PostHandler();
  Color likec = Colors.black;

  AuthService au = new AuthService();

  int bidCount = 0;

  double jumlahKomen = 0;

  Users? ser;

  int? hc = 0;

  Future<void> _downloadurl() async {
    imgdownload =
        await ph.getImageDownload(widget.post.picname, widget.post.id!);
  }

  Future _getUserDetail() async {
    var ikan = await FirebaseFirestore.instance
        .collection("users_detail")
        .doc(widget.post.id_user)
        .get()
        .then((value) async {
      ser = Users.fromJson(value.data() as dynamic);

      print("data is${value.data() as dynamic}");
    });

    return "hai";
  }

  Future _getLikeInfo() async {
    await FirebaseFirestore.instance
        .collection("like")
        .where('id_post', isEqualTo: widget.post.id)
        .get()
        .then((value) {
      likepost = value.size;
    });

    await FirebaseFirestore.instance
        .collection("like")
        .where('id_post', isEqualTo: widget.post.id!)
        .where("id_liker", isEqualTo: widget.post.id_user)
        .get()
        .then((value) {
      if (value.size > 0) {
        likec = Colors.red;
      }
    });
  }

  Future<void> _showauction() async {
    return showDialog<void>(
      context: this.context,
      barrierDismissible: false, // user must tap button
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Lelang'),
          content: SizedBox(
            width: 150,
            height: 200,
            child: Form(
              child: ListView(
                children: <Widget>[
                  Text('Nominal Pelelangan'),
                  TextFormField(
                    controller: bidamount,
                    decoration: InputDecoration(),
                  ),
                  Padding(padding: new EdgeInsets.all(10)),
                  Text('Deskripsi'),
                  TextFormField(
                    controller: descbid,
                    decoration: InputDecoration(),
                  )
                ],
              ),
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: const Text('Ok'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            FutureBuilder(
                future: _getUserDetail(),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.done) {
                    return ElevatedButton(
                        onPressed: () async {
                          Users? datanya = ser;
                          Users? dataku;
                          var response = await FirebaseFirestore.instance
                              .collection("users_detail")
                              .doc(widget.id_user)
                              .get()
                              .then((value) => dataku =
                                  Users.fromJson(value.data() as dynamic));

                          if (datanya != null && dataku != null) {
                            BidModel bidkuy = BidModel(
                                postModel: widget.post,
                                amount: int.parse(bidamount.text),
                                bider: dataku!,
                                owner: datanya,
                                desc: descbid.text,
                                bidDate: Timestamp.now());
                            await ph.addBid(bidkuy);
                          } else {
                            print("ada data yg kosong");
                          }
                        },
                        child: new Text("Lelang"));
                  }
                  return CircularProgressIndicator();
                }),
          ],
        );
      },
    );
  }

  Future<Map> bidCountF() async {
    var wh;
    var whoHigher = await FirebaseFirestore.instance
        .collection("auction")
        .where("postModel.id", isEqualTo: widget.post.id)
        .orderBy("amount", descending: true)
        .limit(1)
        .get()
        .then((value) {
      wh = value.docs.first.data();
    });

    var size;
    var w1 = await FirebaseFirestore.instance
        .collection("auction")
        .where("postModel.id", isEqualTo: widget.post.id)
        .get()
        .then((value) {
      size = value.docs.length;
    });

    return {"jumlah": size, "siapa": wh};
  }

  @override
  void initState() {
    // TODO: implement initStatex

    super.initState();
    print("fdfsdfl");

    komentar = new TextEditingController();

    bidamount = new TextEditingController();
    descbid = new TextEditingController();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        child: new SizedBox(
      height: hc!.toDouble() + 400,
      width: MediaQuery.of(context).size.width,
      child: new Stack(
        clipBehavior: Clip.none,
        children: <Widget>[
          TextField(),
          new Positioned(
              top: 355,
              child: MeasureSize(
                onChange: (size) {
                  print("sizenya ${size.height}");
                  setState(() {
                    hc = size.height.toInt();
                  });
                },
                child: new SizedBox(
                  width: MediaQuery.of(context).size.width,
                  child: new Container(
                    margin: new EdgeInsets.all(10),
                    child: new Container(
                      child: new Column(
                        children: [
                          new Padding(padding: new EdgeInsets.only(bottom: 80)),
                          new TextField(
                            controller: komentar,
                            decoration: InputDecoration(
                                hintText: "Masukan Komentar",
                                prefixIcon: Padding(
                                  padding: new EdgeInsets.all(10),
                                  child: new CircleAvatar(
                                    child: ClipRRect(
                                      borderRadius: BorderRadius.circular(50.0),
                                      child: Image.asset("assets/pp/pp.jpeg"),
                                    ),
                                  ),
                                ),
                                suffixIcon: IconButton(
                                  icon: Icon(Icons.send),
                                  onPressed: () {
                                    if (komentar.text != null &&
                                        !komentar.text.isEmpty) {
                                      var komendata = Komentar(
                                          isi: komentar.text,
                                          tanggal: Timestamp.now(),
                                          id_user: widget.id_user!,
                                          id_post: widget.post.id!);

                                      ph.komen(komendata);
                                      komentar.text = "";
                                    }
                                  },
                                )),
                          ),
                          new Padding(
                            padding: EdgeInsets.all(10),
                            child: StreamBuilder(
                                stream: FirebaseFirestore.instance
                                    .collection("post_comment")
                                    .where("id_post", isEqualTo: widget.post.id)
                                    .orderBy("tanggal",
                                        descending: true || false)
                                    .snapshots(),
                                builder: (BuildContext context,
                                    AsyncSnapshot<QuerySnapshot> snapshot) {
                                  print("hai");
                                  if (snapshot.hasData) {
                                    return Column(
                                      children: snapshot.data!.docs.map((e) {
                                        Komentar komenlist = Komentar.fromJson(
                                            e.data() as dynamic);
                                        return Padding(
                                            padding: EdgeInsets.symmetric(
                                                horizontal: 10, vertical: 10),
                                            child: Row(
                                              mainAxisAlignment:
                                                  (e.data() as dynamic)[
                                                              "id_user"] ==
                                                          widget.id_user
                                                      ? MainAxisAlignment.end
                                                      : MainAxisAlignment.start,
                                              children: [
                                                FutureBuilder(
                                                    future: FirebaseFirestore
                                                        .instance
                                                        .collection(
                                                            "users_detail")
                                                        .doc((e.data()
                                                            as Map)["id_user"])
                                                        .get(),
                                                    builder: (context,
                                                        AsyncSnapshot<
                                                                DocumentSnapshot>
                                                            snap) {
                                                      if (snap.hasData) {
                                                        return Text(
                                                          (snap.data!.data()
                                                                  as Map)[
                                                              "username"],
                                                          style: TextStyle(
                                                            color: (snap.data!.data()
                                                                            as Map)[
                                                                        "level"] ==
                                                                    "Sesepuh"
                                                                ? (snap.data!.data()
                                                                                as Map)[
                                                                            "level"] ==
                                                                        "Artisan"
                                                                    ? Colors
                                                                        .blue
                                                                    : Colors
                                                                        .green
                                                                : Color
                                                                    .fromARGB(
                                                                        255,
                                                                        100,
                                                                        103,
                                                                        38),
                                                            fontWeight:
                                                                FontWeight.bold,
                                                          ),
                                                        );
                                                      }
                                                      return CircularProgressIndicator();
                                                    }),
                                                new Padding(
                                                    padding:
                                                        EdgeInsets.all(11)),
                                                new Text(komenlist.isi)
                                              ],
                                            ));
                                      }).toList(),
                                    );
                                  } else if (snapshot.hasError) {
                                    print(snapshot.error.toString());
                                    return Text(snapshot.error.toString());
                                  }
                                  return CircularProgressIndicator();
                                }),
                          )
                        ],
                      ),
                    ),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(30),
                        boxShadow: [
                          BoxShadow(
                              color: Color.fromARGB(53, 0, 0, 0),
                              spreadRadius: 5,
                              blurRadius: 7)
                        ],
                        color: Color.fromARGB(255, 255, 255, 255)),
                  ),
                ),
              )),
          new Positioned(
            top: 180,
            child: new SizedBox(
              width: MediaQuery.of(context).size.width,
              height: 250,
              child: new Container(
                margin: new EdgeInsets.all(10),
                child: new Padding(
                  padding: EdgeInsets.all(10),
                  child: new Flexible(
                    child: new Column(
                      children: [
                        new Padding(padding: new EdgeInsets.only(bottom: 50)),
                        new Row(
                          children: [
                            FutureBuilder(
                                future: _getLikeInfo(),
                                builder: (context, snapshot) {
                                  if (snapshot.connectionState ==
                                      ConnectionState.done) {
                                    return new Row(
                                      children: [
                                        GestureDetector(
                                          onTap: () async {
                                            Like like = Like(
                                                id_liker: widget.post.id_user!,
                                                id_post: widget.post.id!,
                                                like_date:
                                                    DateTime.now().toString());
                                            bool des = await ph.likepost(
                                                like, widget.post.id_user!);

                                            print(des);
                                            if (des == true) {
                                              setState(() {
                                                likec = Colors.red;
                                              });
                                            } else {
                                              print("fsf");
                                              setState(() {
                                                likec = Color.fromARGB(
                                                    255, 0, 0, 0);
                                              });
                                            }
                                          },
                                          child: new SvgPicture.asset(
                                            "assets/icons/heart.svg",
                                            width: 20,
                                            color: likec,
                                          ),
                                        ),
                                        new Padding(
                                            padding: new EdgeInsets.all(3)),
                                        new Text(
                                          likepost.toString(),
                                          style: TextStyle(
                                              fontWeight: FontWeight.bold,
                                              fontSize: 14),
                                        )
                                      ],
                                    );
                                  }
                                  return CircularProgressIndicator();
                                }),
                            new Padding(padding: new EdgeInsets.all(10)),
                            widget.post.typepost != "Main post"
                                ? FutureBuilder(
                                    future: bidCountF(),
                                    builder: (context, ss) {
                                      if (ss.hasData) {
                                        return Row(
                                          children: [
                                            new GestureDetector(
                                              onTap: () {
                                                _showauction();
                                              },
                                              child: new SvgPicture.asset(
                                                "assets/icons/bid.svg",
                                                width: 20,
                                              ),
                                            ),
                                            new Padding(
                                                padding: new EdgeInsets.all(3)),
                                            new Text(
                                              ((ss.data as Map)["jumlah"]
                                                      as int)
                                                  .toString(),
                                              style: TextStyle(
                                                  fontWeight: FontWeight.bold,
                                                  fontSize: 20),
                                            ),
                                            new Padding(
                                                padding: EdgeInsets.all(10)),
                                            Text(
                                                "Penawaran Tertinggi ${(ss.data as Map)["siapa"]["bidder"]["username"]}")
                                          ],
                                        );
                                      }

                                      print("${ss.connectionState} jose");
                                      return CircularProgressIndicator();
                                    })
                                : Container(),
                          ],
                        ),
                        new Padding(padding: EdgeInsets.all(10)),
                        new Row(
                          children: [
                            FutureBuilder(
                                future: _getUserDetail(),
                                builder: (context, snapshot) {
                                  if (snapshot.hasData) {
                                    return new Text(
                                      ser!.namaL,
                                      style: TextStyle(
                                          fontSize: 12,
                                          fontWeight: FontWeight.bold,
                                          color: Colors.black),
                                    );
                                  }

                                  return SizedBox();
                                }),
                            new Padding(padding: EdgeInsets.all(2)),
                            new Text(
                              widget.post.desc_type == "Caption"
                                  ? "Menambahkan Sebuah Caption"
                                  : "Menambahkan Sebuah Quotes",
                              style: TextStyle(
                                fontSize: 12,
                              ),
                            )
                          ],
                        ),
                        Row(
                          children: [
                            new Text(widget.post.description != null
                                ? widget.post.description!
                                : ".."),
                          ],
                        ),
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
                ),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(30),
                    boxShadow: [
                      BoxShadow(
                          color: Color.fromARGB(52, 0, 0, 0),
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
              width: MediaQuery.of(context).size.width,
              height: 200,
              child: FutureBuilder(
                  future: _downloadurl(),
                  builder: (context, snapshot) {
                    if (imgdownload != "null" && imgdownload != null) {
                      return new Container(
                        margin: new EdgeInsets.all(10),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(30),
                          image: DecorationImage(
                              image: NetworkImage(imgdownload),
                              fit: BoxFit.cover),
                          boxShadow: [
                            BoxShadow(
                                color: Color.fromARGB(50, 0, 0, 0),
                                spreadRadius: 5,
                                blurRadius: 7)
                          ],
                        ),
                        child: new Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            Container(
                                margin: new EdgeInsets.all(10),
                                decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    boxShadow: [
                                      BoxShadow(
                                        color: Color.fromARGB(100, 0, 0, 0),
                                        blurRadius: 5.0,
                                      ),
                                    ]),
                                child: Icon(
                                  Icons.info_outline_rounded,
                                  color: Color.fromARGB(255, 255, 255, 255),
                                  size: 25,
                                ))
                          ],
                        ),
                      );
                    } else {
                      return new Container(
                        margin: new EdgeInsets.all(10),
                        decoration: BoxDecoration(
                          color: Colors.yellow,
                          borderRadius: BorderRadius.circular(30),
                          boxShadow: [
                            BoxShadow(
                                color: Color.fromARGB(50, 0, 0, 0),
                                spreadRadius: 5,
                                blurRadius: 7)
                          ],
                        ),
                        child: new Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            Container(
                                margin: new EdgeInsets.all(10),
                                decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    boxShadow: [
                                      BoxShadow(
                                        color: Color.fromARGB(100, 0, 0, 0),
                                        blurRadius: 5.0,
                                      ),
                                    ]),
                                child: Icon(
                                  Icons.info_outline_rounded,
                                  color: Color.fromARGB(255, 255, 255, 255),
                                  size: 25,
                                ))
                          ],
                        ),
                      );
                    }
                  }),
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
                    InkWell(
                      child: new CircleAvatar(
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(50.0),
                        ),
                      ),
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => Profile(
                                      user: widget.post.id_user,
                                    )));
                      },
                    ),
                    new Padding(padding: EdgeInsets.symmetric(horizontal: 4)),
                    new Container(
                      child: new Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          FutureBuilder(
                              future: _getUserDetail(),
                              builder: (context, snapshot) {
                                if (snapshot.connectionState ==
                                    ConnectionState.done) {
                                  return Row(
                                    children: [
                                      Text(
                                        ser!.username,
                                        style: TextStyle(color: Colors.black),
                                      ),
                                      ser!.level == "artisan"
                                          ? new Icon(
                                              Icons.verified,
                                              color: Color.fromARGB(
                                                  255, 82, 192, 232),
                                            )
                                          : new Icon(
                                              Icons.verified,
                                              color: Color.fromARGB(
                                                  255, 119, 116, 67),
                                            ),
                                    ],
                                  );
                                }
                                if (snapshot.hasError) {
                                  return Text("error");
                                }

                                return SizedBox(
                                    width: 10,
                                    height: 10,
                                    child: CircularProgressIndicator());
                              }),
                          new Row(
                            children: [
                              new Text("Berada di" + widget.post.alamat!)
                            ],
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
    ));
  }
}

class MeasureSize extends SingleChildRenderObjectWidget {
  final OnWidgetSizeChange onChange;

  const MeasureSize({
    Key? key,
    required this.onChange,
    required Widget child,
  }) : super(key: key, child: child);

  @override
  RenderObject createRenderObject(BuildContext context) {
    return MeasureSizeRenderObject(onChange);
  }
}

class MeasureSizeRenderObject extends RenderProxyBox {
  Size? oldSize;
  final OnWidgetSizeChange onChange;

  MeasureSizeRenderObject(this.onChange);

  @override
  void performLayout() {
    super.performLayout();

    Size newSize = child!.size;
    if (oldSize == newSize) return;

    oldSize = newSize;
    WidgetsBinding.instance!.addPostFrameCallback((_) {
      onChange(newSize);
    });
  }
}
