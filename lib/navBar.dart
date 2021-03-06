import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:sad_flutter_app/Centri_Sportivi.dart';
import 'package:sad_flutter_app/Registrazione.dart';
import 'package:sad_flutter_app/Campi.dart';
import 'package:sad_flutter_app/LoginForm.dart';
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
        //backgroundColor: Colors.blue.shade400,
        tabBar: CupertinoTabBar(
          backgroundColor: Color(0xFF595b5a),
          items: const <BottomNavigationBarItem>[
            BottomNavigationBarItem(
              icon: Icon(
                Icons.sports_soccer,
                color: Colors.blue,
              ),
            ),
            BottomNavigationBarItem(
              icon: Icon(
                Icons.person,
                color: Colors.blue,
              ),
            ),
          ],
        ),
        tabBuilder: (context, index) {
          switch (index) {
            case 0:
              return CupertinoTabView(builder: (context) {
                return const CupertinoPageScaffold(
                  child: Page0(),
                );
              });
            /*case 1:
              return CupertinoTabView(builder: (context) {
                return const CupertinoPageScaffold(
                  child: Page3(),
                );
              });*/
            case 1:
              return CupertinoTabView(builder: (context) {
                return const CupertinoPageScaffold(
                  child: Page4(),
                );
              });
            default:
              return CupertinoTabView(builder: (context) {
                return const CupertinoPageScaffold(
                  child: Page4(),
                );
              });
          }
        });
  }
}

class Page0 extends StatelessWidget {
  const Page0({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return  SafeArea(
     child: Centri_Sportivi(),
    );
  }
}

class Page1 extends StatelessWidget {
  const Page1({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const SafeArea(
      child: MaterialApp(home: Centri_Sportivi()),
    );
  }
}

/*class Page2 extends StatelessWidget { //Ci mettiamo il form
  const Page2({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const SafeArea(
        child: Campi(),
    );
  }
}*/

/*class Page3 extends StatelessWidget {
  const Page3({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const SafeArea(
      child: MaterialApp(home: MyApp()),
    );
  }
}*/

class Page4 extends StatelessWidget {
  const Page4({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const SafeArea(
      child: MaterialApp(home: MyLogin()),
    );
  }
}
