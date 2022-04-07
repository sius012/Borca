import "package:flutter/material.dart";

class AddPostPage extends StatefulWidget {
  const AddPostPage({Key? key}) : super(key: key);
  @override
  _AddPostPageState createState() => _AddPostPageState();
}

class _AddPostPageState extends State<AddPostPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: new Container(
        child: new Column(
          children: [
            new Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [new Text("Tambahkan Sesuatu")],
            )
          ],
        ),
      ),
    );
  }
}
