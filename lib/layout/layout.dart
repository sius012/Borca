import 'package:borca2/app_screen.dart';
import 'package:borca2/chat.dart';
import 'package:borca2/notif.dart';
import 'package:flutter/material.dart';
import 'package:borca2/add_post.dart';
import 'package:borca2/profile.dart';
import 'package:flutter_svg/flutter_svg.dart';

class MyNavbar extends StatefulWidget {
  const MyNavbar({Key? key}) : super(key: key);

  @override
  _MyNavbarState createState() => _MyNavbarState();
}

class _MyNavbarState extends State<MyNavbar> {
  @override
  Widget build(BuildContext context) {
    return Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.only(
              topRight: Radius.circular(30), topLeft: Radius.circular(30)),
          boxShadow: [
            BoxShadow(color: Colors.black38, spreadRadius: 0, blurRadius: 10),
          ],
        ),
        child: BottomNavigationBar(
          showSelectedLabels: false,
          showUnselectedLabels: false,
          type: BottomNavigationBarType.fixed,
          items: [
            //home

            //favorite
            BottomNavigationBarItem(
              icon: GestureDetector(
                child: Icon(Icons.home),
                onTap: () {
                  Navigator.push(context, MaterialPageRoute(builder: (contex) {
                    return AppScreen();
                  }));
                },
              ),
              label: '',
            ),
            //loockback
            BottomNavigationBarItem(
              icon: GestureDetector(
                child: Icon(Icons.chat),
                onTap: () {
                  Navigator.push(context, MaterialPageRoute(builder: (contex) {
                    return Chat();
                  }));
                },
              ),
              activeIcon: Icon(Icons.bar_chart),
              label: '',
            ),
            BottomNavigationBarItem(
              icon: new GestureDetector(
                child: new SvgPicture.asset(
                  "assets/icons/add_post.svg",
                  height: 30,
                ),
                onTap: () => Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const AddPostPage()),
                ),
              ),
              activeIcon: Icon(Icons.notifications),
              label: '',
            ),
            BottomNavigationBarItem(
              icon: GestureDetector(
                child: Icon(Icons.notifications),
                onTap: () {
                  Navigator.push(context, MaterialPageRoute(builder: (contex) {
                    return new Notif();
                  }));
                },
              ),
              label: '',
            ),

            //info & support
            BottomNavigationBarItem(
              icon: GestureDetector(
                child: Icon(Icons.account_circle),
                onTap: () {
                  Navigator.push(context, MaterialPageRoute(builder: (contex) {
                    return new Profile();
                  }));
                },
              ),
              activeIcon: Icon(Icons.info),
              label: '',
            ),
          ],
        ));
  }
}
