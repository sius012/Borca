import 'dart:math';

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

class _AppScreenState extends State<AppScreen> {
  AuthService as = new AuthService();
  Users? ud;
  User? u;

  List<PostModel>? thePost;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    var check = FirebaseAuth.instance.authStateChanges().listen((event) {
      if (event != null) {
        print("antum wes login");
      } else {
        print("anda durung login");
        Navigator.of(context).pushReplacement(
            MaterialPageRoute(builder: (context) => LoginPage()));
      }
    });
  }

  Future _fetch() async {
    final fireuser = await FirebaseAuth.instance.currentUser;
    if (fireuser != null) {
      await FirebaseFirestore.instance
          .collection("users_detail")
          .doc(fireuser.uid)
          .get()
          .then((value) {
        ud = Users.fromJson(value.data() as dynamic);
        u = fireuser;
      }).catchError((e) {
        print("the error is : " + e.toString());
      });
      return "wokrd";
    }
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
                      if (snapshot.connectionState != ConnectionState.done) {
                        return new Text(
                          "Sabar bang.....",
                          style: new TextStyle(
                              color: Colors.black, fontWeight: FontWeight.bold),
                        );
                      }
                      return new Text(
                        ud!.namaL,
                        style: new TextStyle(
                            color: Colors.black, fontWeight: FontWeight.bold),
                      );
                    },
                  ),
                  new Icon(
                    Icons.keyboard_arrow_down_rounded,
                    color: Colors.black,
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
            future: _fetch(),
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                return StreamBuilder(
                    stream: FirebaseFirestore.instance
                        .collection('post_collection')
                        .snapshots(),
                    builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
                      if (snapshot.hasError) {
                        return Text(snapshot.error.toString());
                      } else if (snapshot.hasData) {
                        return ListView(
                            children: snapshot.data!.docs.map((e) {
                          PostModel postModel =
                              PostModel.fromJson(e.data() as dynamic);
                          return FutureBuilder(
                              future: _fetch(),
                              builder: (context, snapshot) {
                                if (snapshot.hasData) {
                                  return PostWid(
                                      post: postModel, ud: ud!, uid: u!.uid);
                                }
                                return CircularProgressIndicator();
                              });
                        }).toList());
                      }
                      return Text("fd");
                    });
              }
              return CircularProgressIndicator();
            }),
        bottomNavigationBar: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.only(
                  topRight: Radius.circular(30), topLeft: Radius.circular(30)),
              boxShadow: [
                BoxShadow(
                    color: Colors.black38, spreadRadius: 0, blurRadius: 10),
              ],
            ),
            child: BottomNavigationBar(
              showSelectedLabels: false,
              showUnselectedLabels: false,
              type: BottomNavigationBarType.fixed,
              items: [
                //home

                //favorite
                BottomNavigationBarItem(
                  icon: Icon(
                    Icons.home,
                  ),
                  activeIcon: Icon(
                    Icons.home,
                  ),
                  label: '',
                ),
                //loockback
                BottomNavigationBarItem(
                  icon: Icon(Icons.list),
                  activeIcon: Icon(Icons.bar_chart),
                  label: '',
                ),
                BottomNavigationBarItem(
                  icon: new GestureDetector(
                    child: new SvgPicture.asset(
                      "assets/icons/add_post.svg",
                      height: 30,
                    ),
                    onTap: () => Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const AddPostPage()),
                    ),
                  ),
                  activeIcon: Icon(Icons.bar_chart),
                  label: '',
                ),
                BottomNavigationBarItem(
                  icon: Icon(Icons.bar_chart),
                  activeIcon: Icon(Icons.bar_chart),
                  label: '',
                ),

                //info & support
                BottomNavigationBarItem(
                  icon: GestureDetector(
                    child: Icon(Icons.account_circle),
                    onTap: () {
                      Navigator.push(context,
                          MaterialPageRoute(builder: (contex) {
                        return new Profile();
                      }));
                    },
                  ),
                  activeIcon: Icon(Icons.info),
                  label: '',
                ),
              ],
            )));
  }
}
