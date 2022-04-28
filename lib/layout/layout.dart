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
              icon: Icon(
                Icons.home,
              ),
              activeIcon: Icon(
                Icons.home,
              ),
              label: '',
            ),
            //loockback
            BottomNavigationBarItem(
              icon: Icon(Icons.list),
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
              activeIcon: Icon(Icons.bar_chart),
              label: '',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.bar_chart),
              activeIcon: Icon(Icons.bar_chart),
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
