import 'dart:convert';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart';
import 'package:sad_flutter_app/Centri_Sportivi.dart';
import 'package:sad_flutter_app/GetCampi.dart';
import 'package:sad_flutter_app/navBar.dart';
import 'package:sad_flutter_app/routes/routes.dart';

//void main() => runApp(MaterialApp(home: HomePage()));

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final url = "https://sad-spring.azurewebsites.net/getCentriSportivi";

  var _postsJson = [];

  void fetchPosts() async {
    try {
      final response = await get(Uri.parse(url));
      final jsonData = jsonDecode(response.body) as List;

      setState(() {
        _postsJson = jsonData;
      });
    } catch (err) {
      print("errore in set state");
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    fetchPosts();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      initialRoute: '/',
      routes: {
        '/': (context) => const Nav_Bar(),
        '/Campi': (context) => const Campi(),
      },
    );
  }
}
