import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class Postingan extends StatelessWidget {
  const Postingan({
    Key? key,
    required this.namaPemosting,
    required this.status,
    required this.lokasi,
    required this.text,
    required this.tipeText,
  }) : super(key: key);

  final String namaPemosting;
  final String status;
  final String lokasi;
  final String text;
  final String tipeText;

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
                          new Row(
                            children: [
                              new SvgPicture.asset(
                                "assets/icons/bid.svg",
                                width: 20,
                              ),
                              new Padding(padding: new EdgeInsets.all(3)),
                              new Text(
                                "12k",
                                style: TextStyle(
                                    fontWeight: FontWeight.bold, fontSize: 20),
                              )
                            ],
                          ),
                        ],
                      ),
                      new Padding(padding: EdgeInsets.all(10)),
                      new Row(
                        children: [
                          new Text(
                            namaPemosting,
                            style: TextStyle(
                                fontSize: 12, fontWeight: FontWeight.bold),
                          ),
                          new Text(
                            " menambahkan sebuah caption",
                            style: TextStyle(
                              fontSize: 12,
                            ),
                          )
                        ],
                      ),
                      new Text(text),
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
                        image: AssetImage("assets/post/1.jpg"),
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
                        child: Image.asset("assets/pp/pp.jpeg"),
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
                                namaPemosting,
                                style: new TextStyle(
                                    fontSize: 15,
                                    color: Colors.black,
                                    fontWeight: FontWeight.bold),
                              ),
                              status == "artisan"
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
