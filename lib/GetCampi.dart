import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:sad_flutter_app/viewOrari.dart';

class Campi extends StatefulWidget {
  const Campi({super.key,required this.idCentro});

  final int idCentro;
  @override
  _CampiState createState() => _CampiState();
}

class _CampiState extends State<Campi> {

  String url_base = "https://sad-spring.azurewebsites.net/campicentro/";

  var _postsJson = [];

  void fetchPosts() async {
    try {
      String url = url_base + widget.idCentro.toString(); //Serve a passare l'id da una view all' altra
      final response = await get(Uri.parse(url));
      final jsonData = jsonDecode(response.body) as List;

      setState(() {
        _postsJson = jsonData;
      });
    } catch (err) {}
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
              Navigator.push(context,CupertinoPageRoute(builder: (context) => OrariView(idCampo: _postsJson[i]["id"].toString())));
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
