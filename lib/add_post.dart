import 'dart:io';

import "package:flutter/material.dart";
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:image_picker/image_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:path/path.dart';

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

  Future uploadImageToFirebase() async {
    String fileName = "firspost2";
    if (photo == null) return;
    final destination = 'thepost/$fileName';

    try {
      final ref = FirebaseStorage.instance.ref(destination).child('thepost/');

      await ref.putFile(photo!);
    } catch (e) {
      print("error bos");
      print(e.toString());
    }
  }

  List<String> item = ["Main Post", "Auction"];
  List<String> corq = ["Caption", "Quotes"];
  String? dvalue = "Main Post";
  String? cqval = "Caption";
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
        body: ListView(
          children: [
            new Container(
              padding: EdgeInsets.all(10),
              child: new Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  new Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      new Text(
                        "Tambahkan Sesuatu",
                        style: TextStyle(
                            fontSize: 20, fontWeight: FontWeight.bold),
                      )
                    ],
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
                  new Row(
                    children: [
                      photo != null
                          ? new Container(
                              decoration: BoxDecoration(
                                  image: DecorationImage(
                                    image: FileImage(photo!),
                                    fit: BoxFit.cover,
                                  ),
                                  color: Colors.red,
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(10))),
                              height: 100,
                              width: 100,
                            )
                          : new Text("tidak ada foto")
                    ],
                  ),
                  MaterialButton(
                    onPressed: () {
                      pickImage();
                    },
                    child: ClipRect(child: new Text("Tambah Foto")),
                  ),
                  Text(
                    "Judul Karya",
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
                  ),
                  Padding(padding: EdgeInsets.symmetric(vertical: 5)),
                  TextField(
                      decoration: InputDecoration(
                          hintText: "Masukan Judul",
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10)))),
                  Padding(padding: EdgeInsets.symmetric(vertical: 10)),
                  DropdownButton<String>(
                    value: cqval,
                    onChanged: (String? val) {
                      setState(() {
                        cqval = val!;
                      });
                    },
                    items: corq
                        .map((e) => DropdownMenuItem(
                              child: new Row(
                                children: [
                                  Text(e),
                                  Padding(padding: new EdgeInsets.all(5)),
                                  e == "Caption"
                                      ? Icon(Icons.book)
                                      : Icon(Icons.radar)
                                ],
                              ),
                              value: e,
                            ))
                        .toList(),
                  ),
                  TextField(
                      maxLines: 4,
                      decoration: InputDecoration(
                          hintText: "Masukan $cqval",
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10)))),
                  Padding(padding: EdgeInsets.symmetric(vertical: 10)),
                  Text(
                    "Alamat",
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
                  ),
                  Padding(padding: EdgeInsets.symmetric(vertical: 5)),
                  TextField(
                      decoration: InputDecoration(
                          hintText: "Alamat",
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10)))),
                  RaisedButton(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10)),
                    textColor: Colors.white,
                    elevation: 0,
                    onPressed: () {
                      uploadImageToFirebase();
                    },
                    child: new Text("Unggah"),
                  )
                ],
              ),
            ),
          ],
        ));
  }
}
