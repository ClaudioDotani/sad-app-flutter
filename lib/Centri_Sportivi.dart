import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:sad_flutter_app/Campi.dart';




class Centri_Sportivi extends StatefulWidget {
  const Centri_Sportivi({super.key});


  @override
  _Centri_SportiviState createState() => _Centri_SportiviState();

}

class _Centri_SportiviState extends State<Centri_Sportivi> {
  final url_base = "https://sad-spring.azurewebsites.net/";

  var _postsJson = [];
  var imageArray = [];

  void fetchPosts() async {
    try {
      String url = url_base + "getCentriSportivi";
      final response = await get(Uri.parse(url));
      final jsonData = jsonDecode(response.body) as List;
      jsonData.forEach((element) async {
        var imgData = await fetchImage(element["id"]);
        Uint8List decodedBytes = base64Decode(imgData);
        imageArray.add(decodedBytes);
        setState(() {});
      });
      print("data");
      print(jsonData[0]);
      setState(() {
        _postsJson = jsonData;
      });
    } catch (err) {
      print("errore in set state");
    }
  }

  Future<String> fetchImage(int id) async {
    try {
      String url = url_base + "getImageOfCentro/" + id.toString();
      final response = await get(Uri.parse(url));
      if(response.statusCode == 200) {
        String byteImage = response.body;
        print("byte ");
        print(byteImage);
        return byteImage;
      } else {
        print(response.statusCode);
        return "";
      }

    } catch (err) {
      print("errore in set state");
      return "";
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
          itemCount: imageArray.length,
          itemBuilder: (context, i) {
            final post = _postsJson[i];
            return GestureDetector(
              onTap: () {
                print(_postsJson[i]["id"]);
               Navigator.push(context, CupertinoPageRoute(builder: (context) => Campi(idCentro: _postsJson[i]["id"])));
               },
              child: Container(
                height: 250,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(60),
                  image: DecorationImage(
                      image: MemoryImage(imageArray[i])
                  ),
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
