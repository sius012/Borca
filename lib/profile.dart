import 'package:borca2/add_post.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'app_screen.dart';
import 'dart:ui';

class Profile extends StatelessWidget {
  const Profile({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        bottomNavigationBar: Container(
            decoration: BoxDecoration(
              color: Color.fromARGB(0, 0, 0, 0),
              borderRadius: BorderRadius.only(
                  topRight: Radius.circular(30), topLeft: Radius.circular(30)),
              boxShadow: [
                BoxShadow(
                    color: Colors.black38, spreadRadius: 0, blurRadius: 10),
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
        body: new Stack(
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
                                    image: AssetImage("assets/pp/pp.jpeg"),
                                  )),
                              height: 100,
                            ),
                            new Padding(padding: EdgeInsets.all(5)),
                            new Row(
                              children: [
                                new Text(
                                  "Dion Hermawan",
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold),
                                ),
                                new Padding(padding: new EdgeInsets.all(1)),
                                new Icon(Icons.verified,
                                    color: Color.fromARGB(255, 82, 192, 232))
                              ],
                            ),
                            new Padding(padding: new EdgeInsets.all(5)),
                            new Text(
                              "@dion_setya",
                              style: TextStyle(color: Colors.white),
                            ),
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
                              style: TextStyle(fontWeight: FontWeight.bold),
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
                                    "Ngendogers",
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
              GridView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 3,
                    childAspectRatio: 1 / 1,
                    crossAxisSpacing: 1,
                    mainAxisSpacing: 1),
                itemBuilder: (context, index) => Container(
                  color: Color.lerp(Color.fromARGB(0, 24, 55, 60),
                      Color.fromARGB(255, 24, 55, 60), 0.1),
                ),
                itemCount: 50,
              ),
            ]),
          ],
        ));
  }
}
