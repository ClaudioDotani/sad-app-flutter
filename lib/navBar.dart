import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:sad_flutter_app/Centri_Sportivi.dart';
import 'package:sad_flutter_app/main.dart';

void main() => runApp(MaterialApp(home: Nav_Bar()));

class Nav_Bar extends StatefulWidget{
  const Nav_Bar({super.key});

  @override
  _Nav_BarState createState() => _Nav_BarState();
}



class _Nav_BarState extends State<Nav_Bar>{


  @override
  Widget build (BuildContext context){
    return Scaffold(
      body: HomePage(),
      bottomNavigationBar: CurvedNavigationBar(
        backgroundColor: Colors.orange.shade200,
        items: const [
          Icon(
            Icons.home,
            color: Colors.deepOrange,
          ),
          Icon(
            Icons.sports_football,
            color: Colors.deepOrange,
          ),
          Icon(
            Icons.search,
            color: Colors.deepOrange,
          ),
        ],
      ),
    );
  }
}



