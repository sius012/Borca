import 'package:borca2/add_post.dart';
import 'package:borca2/layout/layout.dart';
import 'package:borca2/object/postingan.dart';
import 'package:borca2/pawang/post_handler.dart';
import 'package:borca2/register.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'app_screen.dart';
import 'dart:ui';
import 'package:firebase_auth/firebase_auth.dart';
import 'auth_service.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class Profile extends StatefulWidget {
  User? user;
  Profile({Key? key, this.user}) : super(key: key);

  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  User? user1;
  Users? duser;

  List<String>? photo;
  PostHandler ph = new PostHandler();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    if (widget.user == null) {
      FirebaseAuth.instance.authStateChanges().listen((event) async {
        if (event != null) {
          print("ffish");
          user1 = event;
        } else {
          Navigator.push(context,
              MaterialPageRoute(builder: ((context) => new RegisterPage())));
        }
      });
    } else {
      print("fdf");
      user1 = widget.user;
    }
  }

  Future<String> getImg(String idg, String pid) async {
    String d = await ph.getImageDownload(idg, pid);
    return d;
  }

  Future _fetch() async {
    if (user1 != null) {
      print("fsdgfe");
      await FirebaseFirestore.instance
          .collection("users_detail")
          .doc(user1!.uid)
          .get()
          .then((value) {
        duser = Users.fromJson(value.data() as dynamic);
      }).catchError((e) {
        print("the error is : " + e.toString());
      });
    } else {
      final fireuser = await FirebaseAuth.instance.currentUser;
      if (fireuser != null) {
        await FirebaseFirestore.instance
            .collection("users_detail")
            .doc(fireuser.uid)
            .get()
            .then((value) {
          duser = Users.fromJson(value.data() as dynamic);
          user1 = fireuser;
        }).catchError((e) {
          print("the error is : " + e.toString());
        });
      }
    }

    return "f";
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        bottomNavigationBar: MyNavbar(),
        body: FutureBuilder(
          future: _fetch(),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              return new Stack(
                children: [
                  ListView(children: [
                    new Container(
                      child: new Stack(
                        clipBehavior: Clip.none,
                        children: [
                          new Container(
                            decoration: BoxDecoration(
                              color: Color.fromARGB(150, 0, 0, 0),
                            ),
                          ),
                          new Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisSize: MainAxisSize.max,
                            children: [
                              new Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  new Padding(padding: new EdgeInsets.all(25)),
                                  new Container(
                                    width: 100,
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(50),
                                        image: DecorationImage(
                                          image:
                                              AssetImage("assets/pp/pp.jpeg"),
                                        )),
                                    height: 100,
                                  ),
                                  new Padding(padding: EdgeInsets.all(5)),
                                  new Row(
                                    children: [
                                      new Text(
                                        duser!.namaL,
                                        style: TextStyle(color: Colors.white),
                                      ),
                                      new Padding(
                                          padding: new EdgeInsets.all(1)),
                                      new Icon(Icons.verified,
                                          color:
                                              Color.fromARGB(255, 82, 192, 232))
                                    ],
                                  ),
                                  new Text(duser!.username,
                                      style: TextStyle(color: Colors.white)),
                                  new Padding(padding: new EdgeInsets.all(5)),
                                  new Padding(padding: new EdgeInsets.all(10)),
                                  new Container(
                                    width: 200,
                                    child: new Text(
                                      '"Hai Saya Dion, saya adalah seniman berbakat 💖"',
                                      style: TextStyle(color: Colors.white),
                                      textAlign: TextAlign.center,
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                          new Padding(
                            padding: new EdgeInsets.all(20),
                            child: new Row(
                              children: [
                                new Icon(
                                  Icons.arrow_back,
                                  color: Colors.white,
                                ),
                                new Spacer(),
                                new Icon(
                                  Icons.settings,
                                  color: Colors.white,
                                )
                              ],
                            ),
                          ),
                        ],
                      ),
                      width: 100,
                      height: 300,
                      decoration: BoxDecoration(
                          color: Color.fromARGB(0, 0, 0, 0),
                          boxShadow: [
                            BoxShadow(
                                color: Color.fromARGB(50, 0, 0, 0),
                                spreadRadius: 5,
                                blurRadius: 7)
                          ],
                          image: DecorationImage(
                              image: AssetImage("assets/banner/1.png"),
                              fit: BoxFit.cover)),
                    ),
                    new Container(
                        height: 30,
                        decoration: BoxDecoration(
                            color: Color.fromARGB(255, 70, 194, 243),
                            borderRadius: BorderRadius.only(
                                bottomLeft: Radius.circular(50),
                                bottomRight: Radius.circular(50))),
                        child: new Padding(
                          padding: EdgeInsets.all(1),
                          child: new Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              new Row(
                                children: [
                                  new Icon(Icons.person),
                                  new Text(
                                    "Artisan",
                                    style:
                                        TextStyle(fontWeight: FontWeight.bold),
                                  )
                                ],
                              )
                            ],
                          ),
                        )),
                    new Padding(padding: EdgeInsets.all(10)),
                    new Row(
                      children: [
                        new Expanded(
                          child: new Padding(
                              padding: new EdgeInsets.all(10),
                              child: new Container(
                                  decoration: BoxDecoration(
                                      color: Colors.white,
                                      borderRadius: BorderRadius.circular(10),
                                      boxShadow: [
                                        new BoxShadow(
                                            color: Color.fromARGB(71, 0, 0, 0),
                                            blurRadius: 4,
                                            spreadRadius: -1)
                                      ]),
                                  child: new Padding(
                                    padding: new EdgeInsets.all(10),
                                    child: new Column(
                                      children: [
                                        new Text(
                                          "20",
                                          style: TextStyle(
                                              fontSize: 20,
                                              fontWeight: FontWeight.bold),
                                        ),
                                        new Text(
                                          "Penghargaan",
                                          style: TextStyle(fontSize: 12),
                                        ),
                                      ],
                                    ),
                                  ))),
                        ),
                        new Expanded(
                          child: new Padding(
                              padding: new EdgeInsets.all(10),
                              child: new Container(
                                  decoration: BoxDecoration(
                                      color: Colors.white,
                                      borderRadius: BorderRadius.circular(10),
                                      boxShadow: [
                                        new BoxShadow(
                                            color: Color.fromARGB(71, 0, 0, 0),
                                            blurRadius: 4,
                                            spreadRadius: -1)
                                      ]),
                                  child: new Padding(
                                    padding: new EdgeInsets.all(10),
                                    child: new Column(
                                      children: [
                                        new Text(
                                          "20",
                                          style: TextStyle(
                                              fontSize: 20,
                                              fontWeight: FontWeight.bold),
                                        ),
                                        new Text(
                                          "Pengikut",
                                          style: TextStyle(fontSize: 12),
                                        ),
                                      ],
                                    ),
                                  ))),
                        ),
                        new Expanded(
                          child: new Padding(
                              padding: new EdgeInsets.all(10),
                              child: new Container(
                                  decoration: BoxDecoration(
                                      color: Colors.white,
                                      borderRadius: BorderRadius.circular(10),
                                      boxShadow: [
                                        new BoxShadow(
                                            color: Color.fromARGB(71, 0, 0, 0),
                                            blurRadius: 4,
                                            spreadRadius: -1)
                                      ]),
                                  child: new Padding(
                                    padding: new EdgeInsets.all(10),
                                    child: new Column(
                                      children: [
                                        new Text(
                                          "20",
                                          style: TextStyle(
                                              fontSize: 20,
                                              fontWeight: FontWeight.bold),
                                        ),
                                        new Text(
                                          "Mengikuti",
                                          style: TextStyle(fontSize: 12),
                                        ),
                                      ],
                                    ),
                                  ))),
                        ),
                      ],
                    ),
                    Padding(padding: new EdgeInsets.all(10)),
                    SizedBox(
                      child: Row(children: [
                        new Expanded(
                          child: Column(
                            children: [
                              new Icon(Icons.collections),
                              new Padding(padding: EdgeInsets.all(5)),
                              const Divider(
                                height: 4,
                                thickness: 2,
                                color: Color.fromARGB(255, 132, 132, 132),
                              )
                            ],
                          ),
                        ),
                        new Expanded(
                          child: Column(
                            children: [
                              new Icon(Icons.badge),
                              new Padding(padding: EdgeInsets.all(5)),
                              const Divider(
                                height: 4,
                                thickness: 1,
                                color: Color.fromARGB(255, 255, 255, 255),
                              )
                            ],
                          ),
                        ),
                        new Expanded(
                          child: Column(
                            children: [
                              new Icon(Icons.post_add),
                              new Padding(padding: EdgeInsets.all(5)),
                              const Divider(
                                height: 4,
                                thickness: 1,
                                color: Color.fromARGB(255, 255, 255, 255),
                              )
                            ],
                          ),
                        ),
                        new Expanded(
                          child: Column(
                            children: [
                              new Icon(Icons.collections),
                              new Padding(padding: EdgeInsets.all(5)),
                              const Divider(
                                height: 4,
                                thickness: 1,
                                color: Color.fromARGB(255, 255, 255, 255),
                              )
                            ],
                          ),
                        )
                      ]),
                    ),
                    StreamBuilder(
                      stream: FirebaseFirestore.instance
                          .collection("post_collection")
                          .snapshots(),
                      builder: (BuildContext context,
                          AsyncSnapshot<QuerySnapshot> snapshot) {
                        if (snapshot.hasData) {
                          List<PostModel> pm =
                              snapshot.data!.docs.map((document) {
                            return PostModel.fromJson(
                                document.data() as dynamic);
                          }).toList();
                          return GridView.builder(
                            shrinkWrap: true,
                            physics: const NeverScrollableScrollPhysics(),
                            gridDelegate:
                                const SliverGridDelegateWithFixedCrossAxisCount(
                                    crossAxisCount: 3,
                                    childAspectRatio: 1 / 1,
                                    crossAxisSpacing: 1,
                                    mainAxisSpacing: 1),
                            itemBuilder: (context, int index) {
                              return FutureBuilder<String>(
                                  future:
                                      getImg(pm[index].picname, pm[index].id!),
                                  builder: (context, snapshot) {
                                    if (snapshot.hasData) {
                                      return Container(
                                        decoration: BoxDecoration(
                                          image: DecorationImage(
                                              image: NetworkImage(
                                                  snapshot.data as dynamic),
                                              fit: BoxFit.cover),
                                          color: Color.lerp(
                                              Color.fromARGB(0, 24, 55, 60),
                                              Color.fromARGB(255, 24, 55, 60),
                                              0.1),
                                        ),
                                      );
                                    }
                                    return Container(
                                      color: Color.lerp(
                                          Color.fromARGB(0, 24, 55, 60),
                                          Color.fromARGB(255, 24, 55, 60),
                                          0.1),
                                    );
                                  });
                            },
                            itemCount: pm.length,
                          );
                        } else {
                          return CircularProgressIndicator();
                        }
                      },
                    )
                  ]),
                ],
              );
            } else {
              return CircularProgressIndicator();
            }
          },
        ));
  }
}
