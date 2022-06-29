import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart';




class Campi extends StatefulWidget {
  const Campi({super.key});

  @override
  _CampiState createState() => _CampiState();
}

class _CampiState extends State<Campi> {
  final url = "https://sad-spring.azurewebsites.net/campicentro/1";

  var _postsJson = [];

  void fetchPosts() async {
    try {
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
      backgroundColor: Colors.orange.shade200,
      body: ListView.builder(
        itemCount: _postsJson.length,
        itemBuilder: (context, i) {
          final post = _postsJson[i];
          return GestureDetector(
            onTap: () {
              Navigator.pop(context);
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
