import 'dart:io';

import 'package:borca2/app_screen.dart';
import 'package:borca2/login.dart';
import "package:flutter/material.dart";
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:image_picker/image_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/scheduler.dart';
import 'package:path/path.dart';
import 'package:provider/provider.dart';
import 'widget/widgets.dart';
import '../object/postingan.dart';
import '../pawang/post_handler.dart';
import 'auth_service.dart';

class AddPostPage extends StatefulWidget {
  const AddPostPage({Key? key}) : super(key: key);
  @override
  _AddPostPageState createState() => _AddPostPageState();
}

class _AddPostPageState extends State<AddPostPage> {
  File? photo;
  bool isLogin = false;
  User? userD;
  PostHandler post1 = new PostHandler();

  late TextEditingController title;
  late TextEditingController desc;
  late TextEditingController alamat;
  late TextEditingController typepost;

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

  Future postingBos(PostModel post, File image) async {
    await post1.postingbos(post, image);
  }

  @override
  void initState() {
    super.initState();
    FirebaseAuth.instance.authStateChanges().listen((User? user) {
      if (user == null) {
        print('User is currently signed out!');

        Navigator.push(this.context,
            MaterialPageRoute(builder: (context) => new LoginPage()));
      } else {
        print('User is signed in!');
        setState(() {
          isLogin = true;
          userD = user;
        });
      }

      post1.showHome();
    });

    title = new TextEditingController();
    desc = new TextEditingController();
    alamat = new TextEditingController();
    typepost = new TextEditingController();
  }

  List<String> item = ["Main Post", "Auction"];
  List<String> itemval = ["mainpost", "auctionable"];
  List<String> corq = ["Caption", "Quotes"];
  List<String> corqval = ["caption", "quotes"];

  final _formkey = GlobalKey<FormState>();
  String? dvalue = "Main post";
  String? cqval = "Caption";

  Future<void> _showMyDialog() async {
    return showDialog<void>(
      context: this.context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('AlertDialog Title'),
          content: SingleChildScrollView(
            child: ListBody(
              children: const <Widget>[
                Text('Gagal Mengupload'),
                Text('pastikan isi kolom yang wajib diisi'),
              ],
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: const Text('Ok'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  Future<void> _showMyDialogSuccess() async {
    return showDialog<void>(
      context: this.context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('AlertDialog Title'),
          content: SingleChildScrollView(
            child: ListBody(
              children: const <Widget>[
                Text('berhasil mengupload'),
                Text('orang lain akan menikmati karya anda'),
              ],
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: const Text('Ok'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

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
      body: ListView(
        children: [
          new ListTile2(
            head: Icon(Icons.abc_sharp),
            title: [
              new Text("sss"),
              new Text("ss"),
            ],
            tail: Icon(Icons.abc_rounded),
            description: [new Text("ssss")],
          ),
          new Form(
            key: _formkey,
            child: new Container(
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
                  Padding(padding: new EdgeInsets.all(10)),
                  DropdownButton<String>(
                    value: dvalue,
                    onChanged: (String? val) {
                      setState(() {
                        dvalue = val!;
                      });
                    },
                    items: <String>['Main post', 'Auction']
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
                  TextFormField(
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Judul Harap diisi!';
                        }
                        return null;
                      },
                      controller: title,
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
                  TextFormField(
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Deskripsi Harap diisi!';
                        }
                        return null;
                      },
                      controller: desc,
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
                  TextFormField(
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Alamat Harap diisi!';
                        }
                        return null;
                      },
                      controller: alamat,
                      decoration: InputDecoration(
                          hintText: "Alamat",
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10)))),
                  RaisedButton(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10)),
                    textColor: Colors.white,
                    elevation: 0,
                    onPressed: () async {
                      if (_formkey.currentState!.validate() && photo != null) {
                        PostModel model = PostModel(
                            alamat: alamat!.text,
                            description: desc!.text,
                            title: title!.text,
                            id_user: userD!.uid,
                            desc_type: cqval,
                            owner_id: "fasgrwhwehfdh",
                            typepost: dvalue,
                            picname: "sasdgagtdsdgsdg",
                            id: null);
                        await postingBos(model, photo!);
                        _showMyDialogSuccess();
                        var userdetail = new AuthService();
                        Users? du = await userdetail.getuserdetail(userD!.uid);
                        await Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => new AppScreen(
                                    user: userD!, detailuser: du!)));
                      } else {
                        print('error');
                      }
                    },
                    child: new Text("Unggah"),
                  )
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
