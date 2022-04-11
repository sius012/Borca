import 'package:borca2/auth_service.dart';
import 'package:borca2/register.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_login/flutter_login.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:provider/provider.dart';

import 'app_screen.dart';

const users = const {
  'dezoditing012@gmail.com': '12345',
};

class LoginPage extends StatefulWidget {
  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  late TextEditingController email;
  late TextEditingController password;

  final _authClient = AuthService();

  @override
  void initState() {
    super.initState();
    email = TextEditingController();
    password = TextEditingController();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: new SafeArea(
      child: new Stack(
        children: [
          new Container(
            width: MediaQuery.of(context).size.width,
            decoration: BoxDecoration(color: Color.fromARGB(255, 34, 34, 34)),
          ),
          new Positioned(
              top: 75,
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
                      style:
                          TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
                    ),
                    new Padding(padding: new EdgeInsets.all(10)),
                    new SvgPicture.asset(
                      "assets/icons/borca_logo.svg",
                      height: 50,
                    ),
                    new Padding(padding: new EdgeInsets.all(10)),
                    new Text(
                      "Sign Up",
                      style:
                          TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
                    ),
                    new Padding(padding: new EdgeInsets.all(12)),
                    new Padding(padding: new EdgeInsets.all(5)),
                    new Padding(
                      padding: new EdgeInsets.symmetric(horizontal: 50),
                      child: new TextField(
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
                        controller: password,
                        obscureText: true,
                        decoration: new InputDecoration(
                            contentPadding: new EdgeInsets.all(10.0),
                            hintText: "Masukan Password",
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(20))),
                      ),
                    ),
                    new Padding(padding: new EdgeInsets.all(50)),
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
                                        final User? user =
                                            await _authClient.loginUser(
                                                email: email.text,
                                                password: password.text);

                                        if (user != null) {
                                          Navigator.of(context)
                                              .pushAndRemoveUntil(
                                                  MaterialPageRoute(
                                                      builder: (contex) =>
                                                          AppScreen()),
                                                  (route) => false);
                                        }
                                      },
                                      child: new Text(
                                        "Sign In",
                                        style: TextStyle(color: Colors.white),
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
                                    builder: (context) =>
                                        const RegisterPage()));
                          }),
                          child: new Text(
                            "Sign Up",
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
