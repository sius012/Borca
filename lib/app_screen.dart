import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'post.dart';
import 'profile.dart';

class AppScreen extends StatefulWidget {
  const AppScreen({Key? key}) : super(key: key);

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
            children: <Widget>[
              new Padding(padding: new EdgeInsets.all(10)),
              new Container(
                height: MediaQuery.of(context).size.height,
                width: MediaQuery.of(context).size.width,
                child: new Column(
                  children: [
                    new ListView(
                      children: [new Text("s")],
                    )
                  ],
                ),
              ),
              new Postingan(
                namaPemosting: "bambang_wisanggeni",
                status: "sesepuh",
                lokasi: "Haluan kanan Seberang jalan",
                text: "Halo Saya baru saya memposting postingan saya",
                tipeText: "quotes",
              ),
            ],
          ),
        ));
  }
}
