import 'package:borca2/login.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:provider/provider.dart';
import 'app_screen.dart';
import 'auth_service.dart';
import 'dart:convert';

class RegisterPage extends StatefulWidget {
  const RegisterPage({Key? key}) : super(key: key);

  @override
  _RegisterPageState createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  late TextEditingController nama;
  late TextEditingController email;
  late TextEditingController password;
  late TextEditingController namaL;

  double top = 100;

  @override
  void initState() {
    super.initState();
    nama = TextEditingController();
    email = TextEditingController();
    password = TextEditingController();
    namaL = TextEditingController();
  }

  final _authClient = AuthService();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        resizeToAvoidBottomInset: true,
        body: Container(
          height: MediaQuery.of(context).size.height,
          child: new Stack(
            children: [
              new Container(
                width: MediaQuery.of(context).size.width,
                decoration:
                    BoxDecoration(color: Color.fromARGB(255, 34, 34, 34)),
              ),
              new AnimatedPositioned(
                  duration: Duration(milliseconds: 100),
                  child: new Container(
                    width: MediaQuery.of(context).size.width,
                    height: MediaQuery.of(context).size.height,
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(40)),
                    child: new Column(
                      children: [
                        new Padding(padding: new EdgeInsets.all(30)),
                        new Text(
                          "Welcome to Borca",
                          style: TextStyle(
                              fontSize: 30, fontWeight: FontWeight.bold),
                        ),
                        new Padding(padding: new EdgeInsets.all(10)),
                        new SvgPicture.asset(
                          "assets/icons/borca_logo.svg",
                          height: 50,
                        ),
                        new Padding(padding: new EdgeInsets.all(3)),
                        new Text(
                          "Sign Up",
                          style: TextStyle(
                              fontSize: 30, fontWeight: FontWeight.bold),
                        ),
                        new Padding(padding: new EdgeInsets.all(12)),
                        new Padding(
                          padding: new EdgeInsets.symmetric(horizontal: 50),
                          child: new TextField(
                            controller: namaL,
                            decoration: new InputDecoration(
                                contentPadding: new EdgeInsets.all(10.0),
                                hintText: "Masukan Nama Lengkap",
                                border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(20))),
                          ),
                        ),
                        new Padding(padding: new EdgeInsets.all(5)),
                        new Padding(
                          padding: new EdgeInsets.symmetric(horizontal: 50),
                          child: new TextField(
                            onTap: () {
                              setState(() {
                                top = 0;
                              });
                            },
                            controller: nama,
                            decoration: new InputDecoration(
                                contentPadding: new EdgeInsets.all(10.0),
                                hintText: "Masukan Nama",
                                border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(20))),
                          ),
                        ),
                        new Padding(padding: new EdgeInsets.all(5)),
                        new Padding(
                          padding: new EdgeInsets.symmetric(horizontal: 50),
                          child: new TextField(
                            onTap: () {
                              setState(() {
                                top = 0;
                              });
                            },
                            controller: email,
                            decoration: new InputDecoration(
                                contentPadding: new EdgeInsets.all(10.0),
                                hintText: "Masukan Email",
                                border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(20))),
                          ),
                        ),
                        new Padding(padding: new EdgeInsets.all(5)),
                        new Padding(
                          padding: new EdgeInsets.symmetric(horizontal: 50),
                          child: new TextField(
                            onTap: () {
                              setState(() {
                                top = 0;
                              });
                            },
                            controller: password,
                            obscureText: true,
                            decoration: new InputDecoration(
                                contentPadding: new EdgeInsets.all(10.0),
                                hintText: "Masukan Password",
                                border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(20))),
                          ),
                        ),
                        new Padding(padding: new EdgeInsets.all(30)),
                        new Padding(
                            padding: new EdgeInsets.symmetric(horizontal: 50),
                            child: new Container(
                              child: new Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    new Expanded(
                                        child: new ButtonTheme(
                                      height: 45,
                                      child: new RaisedButton(
                                          shape: RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.circular(20)),
                                          color: Colors.blue,
                                          onPressed: () async {
                                            final user =
                                                await _authClient.registerUser(
                                                    name: nama.text,
                                                    email: email.text,
                                                    password: password.text,
                                                    namalengkap: namaL.text);

                                            if (user[0] != null) {
                                              Navigator.of(context)
                                                  .pushAndRemoveUntil(
                                                      MaterialPageRoute(
                                                        builder: (contex) =>
                                                            AppScreen(),
                                                      ),
                                                      (route) => false);
                                            }
                                          },
                                          child: new Text(
                                            "Sign Up",
                                            style:
                                                TextStyle(color: Colors.white),
                                          )),
                                    )),
                                  ]),
                            )),
                        new Padding(padding: new EdgeInsets.all(10)),
                        new Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            new Text("sudah bergabung?"),
                            new GestureDetector(
                              onTap: (() {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => new LoginPage()));
                              }),
                              child: new Text(
                                "Sign in",
                                style: TextStyle(
                                    color: Colors.blue,
                                    fontWeight: FontWeight.bold),
                              ),
                            )
                          ],
                        )
                      ],
                    ),
                  ))
            ],
          ),
        ));
  }
}
