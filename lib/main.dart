import 'dart:convert';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';
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
            return Text(
                "id: ${post["id"]}\n "
                "nome: ${post["nome"]}\n "
                "indirizzo: ${post["indirizzo"]}\n "
                "numeroDiTelefono: ${post["numeroDiTelefono"]}\n "
                "imId: ${post["imId"]}\n\n"
            );
            },
        ),
        bottomNavigationBar: CurvedNavigationBar(
          backgroundColor: Colors.deepPurple,
          items: [
            Icon(Icons.home),
            Icon(Icons.search),
          ],
        ),
      ),
    );
  }


  Widget barra(BuildContext context){
    return Scaffold(
      //backgroundColor: Colors.deepPurple,
      bottomNavigationBar: CurvedNavigationBar(
        backgroundColor: Colors.deepPurple,
        items: [
          Icon(Icons.home),
          Icon(Icons.search),
        ],
      ),
    );

  }
}




