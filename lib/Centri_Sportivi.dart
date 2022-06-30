import 'dart:convert';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:sad_flutter_app/AppBar.dart';
import 'package:sad_flutter_app/GetCampi.dart';



class Centri_Sportivi extends StatefulWidget {
  const Centri_Sportivi({super.key});

  @override
  _Centri_SportiviState createState() => _Centri_SportiviState();
}

class _Centri_SportiviState extends State<Centri_Sportivi> {
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
    return Scaffold(
        backgroundColor: Colors.blue.shade400,
        body: ListView.builder(
          itemCount: _postsJson.length,
          itemBuilder: (context, i) {
            final post = _postsJson[i];
            return GestureDetector(
              onTap: () {
               Navigator.push(context, CupertinoPageRoute(builder: (context) => Campi()));
              },
              child: Container(
                height: 250,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(60),
                  image: const DecorationImage(
                      image: AssetImage('assets/images/logo.jpeg')),
                ),
                alignment: Alignment.bottomCenter,
                child: Text(post["nome"]),
              ),
            );
          },
        ),
      );
  }
}