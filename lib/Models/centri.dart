
import 'package:json_annotation/json_annotation.dart';

@JsonSerializable(createToJson: false)
class Centri{
  String? id;
  String? nome;
  String? indirizzo;
  String? numeroDiTelefono;
  String? imID;

  Centri(this.id, this.nome, this.indirizzo, this.numeroDiTelefono, this.imID);

}
