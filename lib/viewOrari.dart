import 'dart:convert';
import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:sad_flutter_app/Prenotazione.dart';

//void main() => runApp(const OrariView());

/*class Orari extends StatefulWidget {
  const Orari({super.key});




  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
        home:  Scaffold(
          body: OrariView(),
        ),
    );
  }
}*/

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

  final url_base = "https://sad-spring.azurewebsites.net/disponibilitacampo/";

  final _textControllerGiorno = TextEditingController();
  DateTime Giorno = new DateTime.now();
  var _postsJson = [];


  void fetchPosts() async {


    try {
      print(widget.idCampo);
      String id = widget.idCampo;
      final url = url_base + id + "/" + Giorno.millisecond.toString();
      final response = await get(Uri.parse(url));
      print(response);
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


  Future<void> _selectDate(BuildContext context) async {
    print("Eccomi");
    final DateTime? picked = await showDatePicker(
        context: context,
        initialDate: Giorno,
        firstDate: DateTime.now(),
        lastDate: DateTime(2101));
    if (picked != null && picked != Giorno) {
      setState(() {
        Giorno = picked;
        _textControllerGiorno.text = Giorno.toString();
      });
    }
  }
/*
  {
  "durataPrenotazione": 120,
  "utenteNonRegistrato": "",
  "dataPartita": "1656774000000",
  "campoDaGioco": 1,
  "utente": 1,
  "privata": true
  }
*/
  void prenota(BuildContext context) async {
    var pren = {
      "durataPrenotazione": 60,
      "utenteNonRegistrato": "utente",
      "dataPartita": Giorno.millisecond.toString(),
      "campoDaGioco": 1,
      "utente": 1,
      "privata": true
    };

    try {
      String url = url_base + "insertPrenotazione" ;//Serve a passare l'id da una view all' altra
      final response = await post(Uri.parse(url), body: pren.toString());
      print(response.toString());
      print(pren.toString());
      _showToast(context);
      final jsonData = jsonDecode(response.body) as List;
      setState(() {
        _postsJson = jsonData;
      });
    } catch (err) {}
  }

  void _showToast(BuildContext context) {
    final scaffold = ScaffoldMessenger.of(context);
    scaffold.showSnackBar(
      SnackBar(
        content: const Text('Prenotazione Effettuata'),
        action: SnackBarAction(label: 'Annulla', onPressed: scaffold.hideCurrentSnackBar),
      ),
    );
  }


  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: MaterialApp(
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
                           decoration: BoxDecoration(
                               color: Colors.orange
                           ),
                           child: Text("Precedente"),
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
                           decoration: BoxDecoration(
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
                          prenota(context);
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
}




