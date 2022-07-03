
import 'package:flutter/cupertino.dart';

class getOrari extends StatefulWidget{
  const getOrari({super.key,required.this.Giorno})
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