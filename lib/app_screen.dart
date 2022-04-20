import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'post.dart';
import 'profile.dart';
import 'auth_service.dart';
import 'add_post.dart';
import 'pawang/post_handler.dart';

class AppScreen extends StatefulWidget {
  final User user;
  final Users detailuser;

  const AppScreen({Key? key, required this.user, required this.detailuser})
      : super(key: key);

  @override
  _AppScreenState createState() => _AppScreenState();
}

class _AppScreenState extends State<AppScreen> {
  AuthService as = new AuthService();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    PostHandler().showHome();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: new AppBar(
        backgroundColor: Color.fromARGB(255, 255, 255, 255),
        title: new GestureDetector(
            onTap: () => Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const Profile()),
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
                new Text(
                  "Dion Hermawan",
                  style: new TextStyle(fontWeight: FontWeight.bold),
                ),
                new Icon(Icons.keyboard_arrow_down_rounded),
                new Icon(Icons.notifications),
              ],
            ),
          ),
        ],
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(
            bottom: Radius.circular(22),
          ),
        ),
      ),
      backgroundColor: Color.fromARGB(255, 255, 255, 255),
      body: SafeArea(
        child: new ListView(
          children: <Widget>[new Text(widget.detailuser.username)],
        ),
      ),
      bottomNavigationBar: Container(
          decoration: BoxDecoration(
            color: Color.fromARGB(0, 0, 0, 0),
            borderRadius: BorderRadius.only(
                topRight: Radius.circular(30), topLeft: Radius.circular(30)),
            boxShadow: [
              BoxShadow(color: Colors.black38, spreadRadius: 0, blurRadius: 10),
            ],
          ),
          child: ClipRRect(
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(30.0),
                topRight: Radius.circular(30.0),
              ),
              child: new Padding(
                padding: new EdgeInsets.all(0),
                child: BottomNavigationBar(items: [
                  BottomNavigationBarItem(
                      icon: Icon(
                        Icons.home,
                      ),
                      label: ""),
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
                      label: ""),
                  BottomNavigationBarItem(icon: Icon(Icons.home), label: "")
                ]),
              ))),
    );
  }
}
