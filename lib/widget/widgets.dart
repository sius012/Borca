import 'package:flutter/material.dart';

class ListTile2 extends StatelessWidget {
  final List<Widget> title;
  final List<Widget> description;
  final Widget tail;
  final Widget head;
  const ListTile2(
      {Key? key,
      required this.title,
      required this.description,
      required this.head,
      required this.tail})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    return new Expanded(
        child: new Container(
      padding: new EdgeInsets.all(10),
      margin: EdgeInsets.all(10),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: Color.fromARGB(255, 255, 255, 255)),
      child: new Row(
        children: [
          new Container(
            decoration: BoxDecoration(
                border:
                    Border(right: BorderSide(width: 1, color: Colors.black))),
            width: 50,
            child: head,
          ),
          new Divider(
            color: Colors.black,
            height: 10,
          ),
          new Container(
              padding: new EdgeInsets.symmetric(horizontal: 10),
              child: new Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  new Row(
                    children: title,
                  ),
                  new Row(
                    children: description,
                  )
                ],
              )),
          Spacer(),
          new Container(
            child: tail,
          ),
        ],
      ),
    ));
  }
}
