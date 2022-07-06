import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart';

//void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  final url = "";

  @override
  Widget build(BuildContext context) {
    const appTitle = 'Consulta gli orari disponibili';

    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        backgroundColor: Color(0xFFe7bc80),
        centerTitle: true,
        title: Text('Registrazione'),
        titleTextStyle: TextStyle(fontSize: 40, fontWeight: FontWeight.w500),
      ),
      body: Container(
        alignment: Alignment.center,
        padding: const EdgeInsets.all(32),
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: NetworkImage("https://i.postimg.cc/W14z7zWX/luis-eusebio-5-SUt9q8j-Qr-Q-unsplash.jpg"),
            fit: BoxFit.cover,
          ),
        ),
        child: MyCustomForm(),
      ),
    );
  }
}

// Create a Form widget.
class MyCustomForm extends StatefulWidget {
  const MyCustomForm({super.key});

  @override
  MyCustomFormState createState() {
    return MyCustomFormState();
  }
}

// Create a corresponding State class.
// This class holds data related to the form.
class MyCustomFormState extends State<MyCustomForm> {
  final _formKey = GlobalKey<FormState>();

  final _textControllerNome = TextEditingController();
  final _textControllerCognome = TextEditingController();
  final _textControllerEmail = TextEditingController();
  final _textControllerPassword = TextEditingController();
  final _textControllerGiorno = TextEditingController();

  String Nome = "";
  String Cognome = "";
  String Password = "";
  String Email = "";

  DateTime Giorno = new DateTime.now();

  Future<void> _selectDate(BuildContext context) async {
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
//https://sad-spring.azurewebsites.net/InsertUtente

  void postData(BuildContext context) async {
    Map user = {
      "nome": _textControllerNome.text,
      "cognome": _textControllerCognome.text,
      "email": _textControllerEmail.text,
      "password": _textControllerPassword.text,
      "dataNascita": Giorno.millisecondsSinceEpoch.toString()
    };
    String bUser = json.encode(user);
    print(bUser);
    try {
      String url = "https://sad-spring.azurewebsites.net/InsertUtente";
      final response = await post(
        Uri.parse(url),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: bUser,
      );
      print(response.statusCode);
      var utente = json.decode(response.body);
      print(utente.toString());
      if(response.statusCode >= 400){
        Navigator.pop(context);
        final scaffold = ScaffoldMessenger.of(context);
        scaffold.showSnackBar(
          SnackBar(
            content: const Text('Errore di inserimento dati'),
            action: SnackBarAction(
                label: 'Annulla', onPressed: scaffold.hideCurrentSnackBar),
          ),
        );
      }else {
        Navigator.pop(context);
        final scaffold = ScaffoldMessenger.of(context);
        scaffold.showSnackBar(
          SnackBar(
            content: const Text('Registrazione effettuata con successo'),
            action: SnackBarAction(
                label: 'Annulla', onPressed: scaffold.hideCurrentSnackBar),
          ),
        );
      }
      } catch (err) {
      print(err);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          TextFormField(
            controller: _textControllerNome,
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Inserisci il Nome';
              }
              return null;
            },
            decoration: InputDecoration(
                suffixIcon: IconButton(
                    onPressed: () {
                      _textControllerNome.clear();
                    },
                    icon: Icon(Icons.clear)),
                border: UnderlineInputBorder(),
              hintText: 'Nome',
              hintStyle: TextStyle(fontSize: 20,color: Colors.white),
            ),
          ),
          //A questo punto per far funzionare le cose, dovrei fare un bottone per ogni campo, e chiamarmi un setstate in ogni bottone, ma così fa cagare.
          TextFormField(
            controller: _textControllerCognome,
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Inserisci il Cognome';
              }
              return null;
            },
            decoration: InputDecoration(
                suffixIcon: IconButton(
                    onPressed: () {
                      _textControllerCognome.clear();
                    },
                    icon: Icon(Icons.clear)),
                border: UnderlineInputBorder(),
                hintText: 'Cognome',
              hintStyle: TextStyle(fontSize: 20,color: Colors.white),
            ),
          ),
          TextFormField(
            controller: _textControllerEmail,
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Inserisci un Email';
              }
              return null;
            },
            decoration: InputDecoration(
                suffixIcon: IconButton(
                    onPressed: () {
                      _textControllerEmail.clear();
                    },
                    icon: Icon(Icons.clear)),
                border: UnderlineInputBorder(),
                hintText: 'Email',
              hintStyle: TextStyle(fontSize: 20,color: Colors.white),
            ),
          ),
          TextFormField(
            controller: _textControllerPassword,
            obscureText: true,
            enableSuggestions: false,
            autocorrect: false,
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Inserisci Password';
              }
              return null;
            },
            decoration: InputDecoration(
                suffixIcon: IconButton(
                    onPressed: () {
                      _textControllerPassword.clear();
                    },
                    icon: Icon(Icons.clear)),
                border: UnderlineInputBorder(),
                hintText: 'Password',
              hintStyle: TextStyle(fontSize: 20,color: Colors.white),
            ),
          ),
          TextFormField(
            controller: _textControllerGiorno,
            onTap: () => _selectDate(context),
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Inserire una Data di Nascita';
              }
              return null;
            },
            decoration: const InputDecoration(
                border: UnderlineInputBorder(), hintText: 'Data di nascita',
              hintStyle: TextStyle(fontSize: 20,color: Colors.white),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 16.0),
            child: ElevatedButton(
              onPressed: () => postData(context),
              child: const Text('Conferma'),
            ),

            // Validate returns true if the form is valid, or false otherwise.
          ),
        ],
      ),
    );
  }

  void onDateChangeCallback(DateTime data) {
    print(data);
  }
}
