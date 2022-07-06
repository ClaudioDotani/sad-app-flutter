import 'dart:convert';
import 'dart:typed_data';
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

  String url_base = "https://sad-spring.azurewebsites.net/";

  var _postsJson = [];
  var imageArray = [];

  void fetchPosts() async {
    try {
      String url = url_base + "campicentro/" +  widget.idCentro.toString(); //Serve a passare l'id da una view all' altra
      final response = await get(Uri.parse(url));
      final jsonData = jsonDecode(response.body) as List;
      //print("campo");
      //print(jsonData);
      jsonData.forEach((element) async {
        var imgData = await fetchImage(element["id"]);
        Uint8List decodedBytes = base64Decode(imgData);
        imageArray.add(decodedBytes);
        setState(() {});
      });
      //print("data");
      //print(jsonData[0]);
      setState(() {
        _postsJson = jsonData;
      });
    } catch (err) {}
  }

  Future<String> fetchImage(int id) async {
    try {
      String url = url_base + "getImageOfCampo/" + id.toString() + "/0";
      print(url);
      final response = await get(Uri.parse(url));
      if(response.statusCode == 200) {
        String byteImage = response.body;
        //print("byte ");
        //print(byteImage);
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
    return SafeArea(
        child: Scaffold(
            backgroundColor: Colors.blue.shade400,
            body: Container(
              alignment: Alignment.center,
              padding: const EdgeInsets.all(32),
              decoration: const BoxDecoration(
                image: DecorationImage(
                  image: NetworkImage("https://i.postimg.cc/W14z7zWX/luis-eusebio-5-SUt9q8j-Qr-Q-unsplash.jpg"),
                  fit: BoxFit.cover,
                ),
              ),
              child: Stack(
                children: [
                  ListView.builder(
                    itemCount: imageArray.length,
                    itemBuilder: (context, i) {
                      final post = _postsJson[i];
                      return GestureDetector(
                          onTap: () {
                            Navigator.push(context,CupertinoPageRoute(builder: (context) => OrariView(idCampo: _postsJson[i]["id"].toString())));
                          },
                          child: Padding(padding: EdgeInsets.all(35),
                            child: Container(
                              height: 250,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(60),
                                image: DecorationImage(
                                    image: MemoryImage(imageArray[i])
                                ),
                              ),
                              alignment: Alignment.bottomCenter,
                              child: RichText(text: TextSpan(
                                text: post["nome"],
                                style: TextStyle(color: Colors.white.withOpacity(1),
                                    fontSize: 40
                                ),
                              ),),
                            ),)
                      );
                    },
                  ),
                  FloatingActionButton(onPressed: (){
                    Navigator.pop(context);
                  },
                    child: Icon(Icons.arrow_back),
                  )
                ],
              ),
            ),


        ),
    );
  }
}
