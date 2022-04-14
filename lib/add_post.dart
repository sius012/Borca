import 'dart:io';

import "package:flutter/material.dart";
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:image_picker/image_picker.dart';

class AddPostPage extends StatefulWidget {
  const AddPostPage({Key? key}) : super(key: key);
  @override
  _AddPostPageState createState() => _AddPostPageState();
}

class _AddPostPageState extends State<AddPostPage> {
  File? photo;

  Future pickImage() async {
    try {
      final photo = await ImagePicker().pickImage(source: ImageSource.gallery);
      if (photo == null) return;
      final imageTemp = File(photo.path);

      setState(() {
        this.photo = imageTemp;
      });
    } on PlatformException catch (e) {
      print("error slur");
    }
  }

  List<String> item = ["Main Post", "Auction"];
  String? dvalue = "Main Post";
  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
      body: new Container(
        child: new Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            new Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [new Text("Tambahkan Sesuatu")],
            ),
            DropdownButton<String>(
              value: dvalue,
              onChanged: (String? val) {
                setState(() {
                  dvalue = val!;
                });
              },
              items: <String>['Main Post', 'Auction']
                  .map((e) => DropdownMenuItem<String>(
                        child: Text(e),
                        value: e,
                      ))
                  .toList(),
            ),
            MaterialButton(
              onPressed: () {
                pickImage();
              },
              child: new Text("Tambah Foto"),
              color: Colors.amber,
            )
          ],
        ),
      ),
    );
  }
}
