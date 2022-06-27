import 'dart:convert';

import 'package:flutter/material.dart';

void main(){
  runApp(MyApp());
}

class MyApp extends StatefulWidget{
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {

  final url = "https://sad-spring.azurewebsites.net/getCentriSportivi";

  var _postsJson = [];

  void fetchPosts() async{

    try {
      final response = await get(Uri.parse(url));
      final jsonData = jsonDecode(response.body) as List;

      setState((){
        _postsJson = jsonData;
      });
    } catch (err) {

    }
  }

  @override
  Widget build(BuildContext context){
    return MaterialApp(
      home:scaffold(
        body: ListView.builder(
        itemCount: _postsJson.length,
        itemBuilder: (context, i)(
          final post = _postsJson[i];
          return Text("id: ${post["id"]}\n nome: ${post["nome"]}\n indirizzo: ${post["indirizzo"]}\n numeroDiTelefono: ${post["numeroDiTelefono"]}\n imId: ${post["null"]}\n
          ),
        );
        )
    return Container();
  }

}