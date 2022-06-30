import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:sad_flutter_app/AppBar.dart';
import 'package:sad_flutter_app/Centri_Sportivi.dart';
import 'package:sad_flutter_app/GetCampi.dart';
import 'package:sad_flutter_app/main.dart';

class Nav_Bar extends StatefulWidget {
  const Nav_Bar({super.key});

  @override
  _Nav_BarState createState() => _Nav_BarState();
}

class _Nav_BarState extends State<Nav_Bar> {
  @override
  Widget build(BuildContext context) {
    return CupertinoTabScaffold(
      backgroundColor: Colors.blue.shade400,
        tabBar: CupertinoTabBar(
          backgroundColor: Colors.white,
          items: const <BottomNavigationBarItem>[
            BottomNavigationBarItem(
              icon: Icon(
                Icons.home,
                color: Colors.blue,
              ),
            ),
            BottomNavigationBarItem(
              icon: Icon(
                Icons.sports_soccer,
                color: Colors.brown,
              ),
            ),
          ],
        ),
        tabBuilder: (context, index) {
          switch (index) {
            case 0:
              return CupertinoTabView(builder: (context) {
                return const CupertinoPageScaffold(
                  child: Centri_Sportivi(),
                );
              });
            case 1:
              return CupertinoTabView(builder: (context) {
                return const CupertinoPageScaffold(
                  child: Page2(),
                );
              });
            default:
              return CupertinoTabView(builder: (context) {
                return const CupertinoPageScaffold(
                  child: Page2(),
                );
              });
          }
        });
  }
}

class Page1 extends StatelessWidget{
  const Page1({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context){
    return const SafeArea(
      child: Nav_Bar(),

    );
  }
}

class Page2 extends StatelessWidget {
  const Page2({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const SafeArea(
      child: Campi(),
    );
  }
}
