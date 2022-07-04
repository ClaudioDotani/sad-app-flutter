
/*import 'package:flutter/cupertino.dart';

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
  }*/

@override
Widget build(BuildContext context) {
  return SafeArea(
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        home: Scaffold(
            backgroundColor: Colors.blue.shade400,
            body: Stack(
              children: <Widget>[
                Container(
                  child:  Row(
                    children: [
                      GestureDetector(
                        onTap: () {
                          print("on prev");
                        },
                        child: Container(
                          height: 20,
                          width: 100,
                          decoration: const BoxDecoration(
                              color: Colors.orange
                          ),
                          child: const Text("Precedente"),
                        ),
                      ),
                      Text("${Giorno.day} - ${Giorno.month} - ${Giorno.year}"),
                      GestureDetector(
                        onTap: () {
                          print("on next");
                        },
                        child: Container(
                          height: 20,
                          width: 100,
                          decoration: const BoxDecoration(
                              color: Colors.orange
                          ),
                          child: Text("Successivo"),
                        ),
                      ),
                    ],
                  ),
                ),
                ListView.builder(
                  scrollDirection: Axis.vertical,
                  shrinkWrap: true,
                  itemCount: _postsJson.length,
                  itemBuilder: (context, i) {
                    final post = _postsJson[i];
                    return GestureDetector(
                      onTap: () {
                        _showToast(context);
                      },
                      child: Container(
                        height: 50,
                        width: 50,
                        decoration: BoxDecoration(
                            color: Colors.orange,
                            borderRadius: BorderRadius.circular(100)
                        ),
                        alignment: Alignment.center,
                        child: Text(post.toString()),
                      ),
                    );
                  },
                ),
              ],
            )
        ),
      )
  );
}