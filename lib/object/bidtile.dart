import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'postingan.dart';
import 'package:borca2/auth_service.dart';
import 'package:flutter_svg/flutter_svg.dart';

class BidModel {
  final PostModel postModel;
  final int amount;
  final Users bider;
  final Users owner;
  final String desc;
  final Timestamp bidDate;
  const BidModel(
      {required this.postModel,
      required this.amount,
      required this.bider,
      required this.owner,
      required this.desc,
      required this.bidDate});

  Map<String, dynamic> toJson() => {
        'postModel': postModel.toJson(),
        'amount': amount,
        'bidder': bider.toJson(),
        'owner': owner.toJson(),
        'desc': desc,
        'bidDate': bidDate
      };

  static BidModel fromJson(Map<String, dynamic> json) => BidModel(
      postModel: PostModel.fromJson(json['postModel']),
      amount: json["amount"],
      bider: Users.fromJson(json["bidder"]),
      owner: Users.fromJson(json["owner"]),
      desc: json["desc"],
      bidDate: json["bidDate"]);
}

class BidTile extends StatefulWidget {
  final BidModel bid;
  const BidTile({Key? key, required this.bid});

  @override
  BidTileState createState() => new BidTileState();
}

class BidTileState extends State<BidTile> {
  @override
  Widget build(BuildContext context) {
    return Container(
        child: new Flexible(
            child: Container(
      decoration: BoxDecoration(border: Border.all(color: Colors.black)),
      child: Row(children: [
        Container(
          padding: EdgeInsets.all(5),
          child: new Icon(Icons.download),
        ),
        SizedBox(
          width: 10,
        ),
        Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            new Row(
              children: [
                new Text(
                  '${widget.bid.bider.namaL}',
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                new Text(
                  ' Melelang ',
                  style: TextStyle(),
                ),
                new Text(
                  '${widget.bid.postModel.title}',
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
              ],
            ),
            new Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                new Text(widget.bid.amount.toString()),
                new Padding(padding: EdgeInsets.all(3)),
                new Text("Penawaran Tertinggi")
              ],
            )
          ],
        ),
        Spacer(),
        new Container(
          child: new SvgPicture.asset(
            "assets/icons/bid.svg",
            width: 20,
          ),
        ),
      ]),
    )));
  }
}
