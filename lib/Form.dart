import 'package:flutter/material.dart';

//void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  final url = "";

  @override
  Widget build(BuildContext context) {
    const appTitle = 'Consulta gli orari disponibili';

    return   const Scaffold(
        body: MyCustomForm(),
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

  final _textControllerCentro = TextEditingController();
  final _textControllerCampo = TextEditingController();
  final _textControllerGiorno = TextEditingController();

  String Centro = "" ;
  late String Campo;
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
        _textControllerGiorno.text=Giorno.toString();
      });
    }
  }



  @override
  Widget build(BuildContext context){
    return Form(
      key: _formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          TextFormField(
            controller: _textControllerCentro,
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Inserisci un centro';
              }
              return null;
            },
            decoration: InputDecoration(
                suffixIcon: IconButton(
                    onPressed: () {
                      _textControllerCentro.clear();
                    },
                    icon: Icon(Icons.clear)),
                border: UnderlineInputBorder(),
                hintText: 'Nome del Centro'),
          ),
          //A questo punto per far funzionare le cose, dovrei fare un bottone per ogni campo, e chiamarmi un setstate in ogni bottone, ma così fa cagare.
          TextFormField(
            controller: _textControllerCampo,
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Inserisci un Campo';
              }
              return null;
            },
            decoration:  InputDecoration(
                suffixIcon: IconButton(
                    onPressed: () {
                      _textControllerCampo.clear();
                    },
                    icon: Icon(Icons.clear)),
                border: UnderlineInputBorder(), hintText: 'Campo'
            ),
          ),
          TextFormField(
            controller: _textControllerGiorno,
            onTap:  () => _selectDate(context),
            validator: (value){
              if(value == null || value.isEmpty){
                return 'Inserisci una Data';
              }
              return null;
            },
            decoration: const InputDecoration(
              border: UnderlineInputBorder(), hintText: 'Inserisci Giorno'
            ),

          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 16.0),
            child: ElevatedButton(
              onPressed: () {
                setState(() {
                  Centro = _textControllerCentro.text;
                  Campo = _textControllerCampo.text;
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

  void onDateChangeCallback(DateTime data){
    print(data);
  }

  String url_base = "https://sad-spring.azurewebsites.net";
  String slash = "/";


}
