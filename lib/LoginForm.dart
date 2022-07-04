import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'dart:convert';

//void main() => runApp(const MyApp());

class MyLogin extends StatelessWidget {
  const MyLogin({super.key});


  @override
  Widget build(BuildContext context) {
    //const appTitle = 'Consulta gli orari disponibili';

        return Scaffold(
          resizeToAvoidBottomInset: false,
          appBar: PreferredSize(
            preferredSize: Size.fromHeight(25.0),
            child: AppBar(
              centerTitle: true,
              title: Text('Login'),
            ),
          ),
          body: MyLoginForm(),
    );
  }
}

// Create a Form widget.
class MyLoginForm extends StatefulWidget {
  const MyLoginForm({super.key});
  final url_base = "https://sad-spring.azurewebsites.net/";

  @override
  MyLoginFormState createState() {
    return MyLoginFormState();
  }
}

// Create a corresponding State class.
// This class holds data related to the form.
class MyLoginFormState extends State<MyLoginForm> {
  final _formKey = GlobalKey<FormState>();

  final _textControllerUsername = TextEditingController();
  final _textControllerPassword = TextEditingController();

  late String username;
  late String password;


  @override
  Widget build(BuildContext context){
    return Form(
      key: _formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          TextFormField(
            controller: _textControllerUsername,
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Inserisci un nome utente';
              }
              return null;
            },
            decoration: InputDecoration(
                suffixIcon: IconButton(
                    onPressed: () {
                      _textControllerUsername.clear();
                    },
                    icon: Icon(Icons.clear)),
                border: UnderlineInputBorder(),
                hintText: 'Username'),
          ),
          //A questo punto per far funzionare le cose, dovrei fare un bottone per ogni campo, e chiamarmi un setstate in ogni bottone, ma così fa cagare.
          TextFormField(
            obscureText: true,
            enableSuggestions: false,
            autocorrect: false,
            controller: _textControllerPassword,
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Inserisci una password';
              }
              return null;
            },
            decoration:  InputDecoration(
                suffixIcon: IconButton(
                    onPressed: () {
                      _textControllerPassword.clear();
                    },
                    icon: Icon(Icons.clear)),
                border: UnderlineInputBorder(), hintText: 'Password'
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 16.0),
            child: ElevatedButton(
              onPressed: () {
                setState(() {
                  username = _textControllerUsername.text;
                  password = _textControllerPassword.text;
                });
                // Validate returns true if the form is valid, or false otherwise.
                if (_formKey.currentState!.validate()) {
                  // If the form is valid, display a snackbar. In the real world,
                  // you'd often call a server or save the information in a database.
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('caricamento dei dati')),
                  );
                }
                login(context);

              },
              child: const Text('Accedi'),
            ),
          ),
        ],
      ),
    );
  }

  void onDateChangeCallback(DateTime data){
    print(data);
  }


  void login(BuildContext context) async {
    Map user = {
      "email": username,
      "password": password,
    };
    String bUser = json.encode(user);
    print(bUser);
    try {
      String url = widget.url_base + "loginUser"; //Serve a passare l'id da una view all' altra
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
      if(utente["id"] == -1){
        final scaffold = ScaffoldMessenger.of(context);
        scaffold.showSnackBar(
          SnackBar(
            content: const Text('Credenziali Errate'),
            action: SnackBarAction(
                label: 'Annulla', onPressed: scaffold.hideCurrentSnackBar),
          ),
        );
      } else {
        final scaffold = ScaffoldMessenger.of(context);
        scaffold.showSnackBar(
          SnackBar(
            content: const Text('Credenziali Errate'),
            action: SnackBarAction(
                label: 'Annulla', onPressed: scaffold.hideCurrentSnackBar),
          ),
        );
      }

      setState(() {});
    } catch (err) {
      print(err);
    }
  }


}
