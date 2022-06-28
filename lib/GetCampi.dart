import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart';

void main(){
  runApp(MyApp());
}

class MyApp extends StatefulWidget{
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {

  final url = "https://sad-spring.azurewebsites.net/campicentro/1";

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
  void initState() {
    // TODO: implement initState
    super.initState();
    fetchPosts();
  }

  @override
  Widget build(BuildContext context){
    return MaterialApp(
      home: Scaffold(
        body: ListView.builder(
            itemCount: _postsJson.length,
            itemBuilder: (context, i){
              final post = _postsJson[i];
              return Text("id: ${post["id"]}\n nome: ${post["nome"]}\n descrizione: ${post["descrizione"]}\n imgIds: ${post["imgIds"]}\n prenotabile: ${post["prenotabile"]}\n costoOrario: ${post["costoOrario"]}\n timestampApertura: ${post["timestampApertura"]}\n timestampChiusura: ${post["timestampChiusura"]}\n\n");
            }
        ),
      ),
    );
  }
}



