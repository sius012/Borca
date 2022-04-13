import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'post.dart';
import 'profile.dart';
import 'auth_service.dart';

class AppScreen extends StatefulWidget {
  final User user;
  final Users detailuser;
  const AppScreen({Key? key, required this.user, required this.detailuser})
      : super(key: key);

  @override
  _AppScreenState createState() => _AppScreenState();
}

class _AppScreenState extends State<AppScreen> {
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
        ));
  }
}
