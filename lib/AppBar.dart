import 'package:flutter/material.dart';
import 'package:sad_flutter_app/Centri_Sportivi.dart';

void main()=>runApp(Barra());

class Barra extends StatelessWidget {
  const Barra({Key? key}) : super(key: key);

  static const String _title = 'Flutter Code Sample';

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      title: _title,
      home: MyStatelessWidget(),
    );
  }
}

class MyStatelessWidget extends StatelessWidget {
  const MyStatelessWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Centri Sportivi'),

      ),
      body: const Center(
        child: Centri_Sportivi(),
      ),
    );
  }
}
