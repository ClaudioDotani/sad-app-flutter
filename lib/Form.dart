import 'package:flutter/material.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  final url = "";

  @override
  Widget build(BuildContext context) {
    const appTitle = 'Consulta gli orari disponibili';

    return MaterialApp(
      title: appTitle,
      home: Scaffold(
        appBar: AppBar(
          title: const Text(appTitle),
          centerTitle: true,
        ),
        body: const MyCustomForm(),
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

  final _textController = TextEditingController();

  String Centro = '';
  String Campo = '';
  String Giorno = '';

  @override
  Widget build(BuildContext context) {
    // Build a Form widget using the _formKey created above.
    return Form(
      key: _formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          //Visione del Testo (Test Per vedere se funziona)
          Expanded(
            child: Container(
              child: Center(
                child: Text(Campo, style: TextStyle(fontSize: 35)),
              ),
            ),
          ),

          //Input Testo
          TextFormField(
            controller: _textController,
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Inserisci un centro';
              }
              return null;
            },
            decoration: InputDecoration(
                suffixIcon: IconButton(
                    onPressed: () {
                      _textController.clear();
                    },
                    icon: Icon(Icons.clear)),
                border: UnderlineInputBorder(),
                hintText: 'Nome del Centro'),
          ),
          //A questo punto per far funzionare le cose, dovrei fare un bottone per ogni campo, e chiamarmi un setstate in ogni bottone, ma così fa cagare.
          TextFormField(
            controller: _textController,
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Inserisci un campo';
              }
              return null;
            },
            decoration: const InputDecoration(
                border: UnderlineInputBorder(), hintText: 'Campo'),
          ),
          TextFormField(
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Inserisci un Giorno';
              }
              return null;
            },
            decoration: const InputDecoration(
                border: UnderlineInputBorder(), hintText: 'Giorno'),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 16.0),
            child: ElevatedButton(
              onPressed: () {
                setState(() {
                  //SBAGLIATO!!! con un pulsante voglio prendere tuti i dati del form, in questo modo mi viene preso solo Centro
                  Centro = _textController.text;
                  Campo = _textController.text;
                  Giorno = _textController.text;
                });
                // Validate returns true if the form is valid, or false otherwise.
                if (_formKey.currentState!.validate()) {
                  // If the form is valid, display a snackbar. In the real world,
                  // you'd often call a server or save the information in a database.
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('Processamnto dei dati')),
                  );
                }
              },
              child: const Text('Conferma'),
            ),
          ),
        ],
      ),
    );
  }
}
