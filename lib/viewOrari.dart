import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'globals.dart' as globals;


//void main() => runApp(const OrariView());

// Create a Form widget.
class OrariView extends StatefulWidget {
  const OrariView({super.key, required this.idCampo});

  final String idCampo;

  @override
  OrariViewState createState() {
    return OrariViewState();
  }
}

// Create a corresponding State class.
// This class holds data related to the form.
class OrariViewState extends State<OrariView> {
  final url_base = "https://sad-spring.azurewebsites.net/";

  final _textControllerGiorno = TextEditingController();
  DateTime Giorno = new DateTime.now();
  var _postsJson = [];

  void fetchPosts() async {
    try {
      print(widget.idCampo);
      String id = widget.idCampo;
      final url = url_base +
          "disponibilitacampo/" +
          id +
          "/" +
          Giorno.millisecondsSinceEpoch.toString();
      final response = await get(Uri.parse(url));
      //print(url);
      //print("orari");
      //print(response.body);
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

  void _selectDate(BuildContext context) async {
    await showDatePicker(
      context: context,
      initialDate: Giorno,
      firstDate: DateTime(2022),
      lastDate: DateTime(2030),
    ).then((selectedDate) {
      if (selectedDate != null) {
        setState(() {
          Giorno = selectedDate;
        });
      }
    });
  }

  void prenota(BuildContext context, int ora) async {

    if (globals.isLoggedIn == false){
      print("errore non loggato");
      final scaffold = ScaffoldMessenger.of(context);
      scaffold.showSnackBar(
        SnackBar(
          content: const Text('Devi autenticarti per fare una prenotazione!'),
          action: SnackBarAction(
              label: 'Annulla', onPressed: scaffold.hideCurrentSnackBar),
        ),
      );
      fetchPosts();
      return;
    }

    DateTime dataPartita = new DateTime(
        Giorno.year, Giorno.month, Giorno.day, ora , 0, 0, 0, 0);

    Map pren = {
      "durataPrenotazione": 60,
      "utenteNonRegistrato": "",
      "dataPartita": dataPartita.millisecondsSinceEpoch.toString(),
      "campoDaGioco": int.parse(widget.idCampo),
      "utente": globals.idUtente,
      "privata": true
    };
    String bPren = json.encode(pren);
    print(bPren);
    try {
      String url = url_base +
          "insertPrenotazione"; //Serve a passare l'id da una view all' altra
      final response = await post(
        Uri.parse(url),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: bPren,
      );
      print(response.statusCode);
      var body = json.decode(response.body);
      print(body.toString());
      _showToast(context);
      final jsonData = jsonDecode(response.body) as List;
      setState(() {
        _postsJson = jsonData;
      });
      fetchPosts();
    } catch (err) {
      print(err);
    }
  }

  void _showToast(BuildContext context) {
    final scaffold = ScaffoldMessenger.of(context);
    scaffold.showSnackBar(
      SnackBar(
        content: const Text('Prenotazione Effettuata'),
        action: SnackBarAction(
            label: 'Annulla', onPressed: scaffold.hideCurrentSnackBar),
      ),
    );
  }

  DateTime date = DateTime(2022, 07, 04);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: MaterialApp(
        home: Scaffold(
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
                children: <Widget>[
                  Padding(padding: EdgeInsets.all(70),
                    child: ListView.builder(
                      scrollDirection: Axis.vertical,
                      shrinkWrap: true,
                      itemCount: _postsJson.length,
                      itemBuilder: (context, i) {
                        final post = _postsJson[i];
                        return Padding(padding: EdgeInsets.all(2.5),
                          child: GestureDetector(
                            onTap: () {
                              _postsJson.remove(post);
                              prenota(context, post);
                              setState(() {});
                            },
                            child: Container(
                              height: 50,
                              width: 50,
                              decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(20)),
                              alignment: Alignment.center,
                              child: Text(post.toString()),
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Padding(padding: EdgeInsets.all(15),
                        child: FloatingActionButton(
                          heroTag: "btnPrev",
                          onPressed: () {
                            Giorno = DateTime(
                                Giorno.year, Giorno.month, Giorno.day - 1);
                            setState(() {});
                            fetchPosts();
                          },
                          child: const Icon(Icons.arrow_back),
                        ),
                      ),
                      Padding(padding: EdgeInsets.all(20),
                        child:  ElevatedButton(
                            onPressed: () {},
                            child: Text(
                                "${Giorno.day} - ${Giorno.month} - ${Giorno.year}")),
                      ),
                      Padding(padding: EdgeInsets.all(15),
                        child: FloatingActionButton(
                          heroTag: "btnNext",
                          onPressed: () {
                            Giorno = DateTime(
                                Giorno.year, Giorno.month, Giorno.day + 1);
                            setState(() {});
                            fetchPosts();
                          },
                          child: const Icon(Icons.arrow_forward),
                        ),
                      ),
                    ],
                  ),
                  Positioned(
                    //constraints.biggest.height to get the height
                    // * .05 to put the position top: 5%
                    bottom: 30,
                    left: 10,
                    child: FloatingActionButton(
                      onPressed: (){
                        Navigator.pop(context);
                      },
                      child: Icon(Icons.cancel),
                    ),
                  ),
                ],
              )
            ),


        ),
        //child: Text("${Giorno.day} - ${Giorno.month} - ${Giorno.year}")),
      ),
    );
  }
}
