import 'dart:math';

import 'package:borca2/layout/layout.dart';
import 'package:borca2/login.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'post.dart';
import 'profile.dart';
import 'auth_service.dart';
import 'add_post.dart';
import 'pawang/post_handler.dart';
import 'object/postingan.dart';

class AppScreen extends StatefulWidget {
  const AppScreen({Key? key}) : super(key: key);

  @override
  _AppScreenState createState() => _AppScreenState();
}

enum menuItem {
  pengaturan,
  logout,
}

class _AppScreenState extends State<AppScreen> {
  AuthService as = new AuthService();
  Users? ud;
  User? u;

  List<PostModel>? thePost;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    var check2 = FirebaseAuth.instance.currentUser;
    var check = FirebaseAuth.instance.authStateChanges().listen((event) {
      if (check2 != null) {
        print("antum wes login");

        setState(() {
          u = check2;
        });
        print(u!.uid);
      } else {
        print("anda durudng login");
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => LoginPage()));
      }
    });
  }

  Future<List<dynamic>> _getUserDetail() async {
    final fireuser = await FirebaseAuth.instance.currentUser;
    User umas;
    if (fireuser != null) {
      var response = await FirebaseFirestore.instance
          .collection("users_detail")
          .doc(fireuser.uid)
          .get()
          .then((value) {
        ud = Users.fromJson(value.data() as dynamic);
        u = fireuser;

        print("ikan");
      }).catchError((e) {
        print("d");
        print("the error is : " + e.toString());
      });
      umas = fireuser;
    } else {}
    return [u, ud];
  }

  Future _fetch() async {
    final fireuser = await FirebaseAuth.instance.currentUser;

    if (fireuser != null) {
      var response = await FirebaseFirestore.instance
          .collection("users_detail")
          .doc(fireuser.uid)
          .get()
          .then((value) {
        ud = Users.fromJson(value.data() as dynamic);
        u = fireuser;
        print("ikan");
      }).catchError((e) {
        print("d");
        print("the error is : " + e.toString());
      });
    } else {}
    return "lol";
  }

  showHome() async {
    await FirebaseFirestore.instance
        .collection("post_collection")
        .get()
        .then((value) => value.docs.map((e) => print("dgdsg")));
  }

  // Stream<List<PostModel>> readPost() async* {
  //   var thepost = await FirebaseFirestore.instance
  //       .collection("post_collection")
  //       .snapshots()
  //       .map((event) {
  //         return event.docs.map((e){
  //              PostModel p = PostModel.fromJson(e.data());
  //             print(event.docs.first.data());

  //         }).toList();

  //       });

  //   yield thepost;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: new AppBar(
          backgroundColor: Color.fromARGB(255, 255, 255, 255),
          title: new GestureDetector(
              onTap: () => Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => new Profile()),
                  ),
              child: new SvgPicture.asset(
                "assets/icons/borca_logotext.svg",
                height: 20,
              )),
          actions: [
            new Padding(
              padding: EdgeInsets.all(10),
              child: new Row(
                children: [
                  new FutureBuilder(
                    future: _fetch(),
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.done) {
                        return Row(children: [
                          PopupMenuButton(
                            onSelected: (value) {
                              if (value == menuItem.pengaturan) {
                              } else if (value == menuItem.logout) {
                                as.logoutUser();
                              }
                            },
                            icon: new Icon(
                              Icons.keyboard_arrow_down_rounded,
                              color: Colors.black,
                            ),
                            itemBuilder: (context) => [
                              PopupMenuItem(
                                  value: menuItem.pengaturan,
                                  child: new Row(
                                    children: [
                                      new Icon(
                                        Icons.settings,
                                        color: Colors.black,
                                      ),
                                      new Padding(
                                        padding: EdgeInsets.all(3),
                                      ),
                                      new Text("Pengaturan")
                                    ],
                                  )),
                              PopupMenuItem(
                                  value: menuItem.logout,
                                  child: new Row(
                                    children: [
                                      new Icon(
                                        Icons.logout,
                                        color: Colors.black,
                                      ),
                                      new Padding(
                                        padding: EdgeInsets.all(3),
                                      ),
                                      new Text("Logout")
                                    ],
                                  ))
                            ],
                          )
                        ]);
                      }
                      return CircularProgressIndicator();
                    },
                  ),
                  new Icon(
                    Icons.notifications,
                    color: Colors.black,
                  ),
                ],
              ),
            )
          ],
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.vertical(
              bottom: Radius.circular(22),
            ),
          ),
        ),
        backgroundColor: Color.fromARGB(255, 255, 255, 255),
        body: FutureBuilder(
            future: _getUserDetail(),
            builder: (context, snapshotku) {
              if (snapshotku.connectionState == ConnectionState.done) {
                List<dynamic> listku = snapshotku.data as List;
                if (listku[0] != null) {
                  return StreamBuilder(
                      stream: FirebaseFirestore.instance
                          .collection('post_collection')
                          .orderBy("date", descending: true)
                          .snapshots(),
                      builder:
                          (context, AsyncSnapshot<QuerySnapshot> snapshot) {
                        if (snapshot.hasError) {
                          return Text(snapshot.error.toString());
                        } else if (snapshot.hasData) {
                          return ListView(
                              children: snapshot.data!.docs.map((e) {
                            PostModel postModel =
                                PostModel.fromJson(e.data() as dynamic);

                            return PostWid(
                                post: postModel,
                                id_user: (listku[0] as User).uid);
                          }).toList());
                        }
                        return Text("fd");
                      });
                }

                return CircularProgressIndicator();
              }

              return Center(
                child: new CircularProgressIndicator(),
              );
            }),
        bottomNavigationBar: u != null
            ? MyNavbar(
                userdata: u!,
              )
            : Container());
  }
}
