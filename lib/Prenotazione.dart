import 'package:json_annotation/json_annotation.dart';

/// This allows the `User` class to access private members in
/// the generated file. The value for this is *.g.dart, where
/// the star denotes the source file name.

/// An annotation for the code generator to know that this class needs the
/// JSON serialization logic to be generated.
///

part 'prenotazione.g.dart';

@JsonSerializable()
class Prenotazione {
  Prenotazione(this.durataPrenotazione, this.utenteNonRegistrato, this.dataPartita, this.campoDaGioco, this.utente, this.privata);

  int durataPrenotazione;
  String utenteNonRegistrato;
  String dataPartita;
  int campoDaGioco;
  int utente;
  bool privata;

  /// A necessary factory constructor for creating a new User instance
  /// from a map. Pass the map to the generated `_$UserFromJson()` constructor.
  /// The constructor is named after the source class, in this case, User.
  factory Prenotazione.fromJson(Map<String, dynamic> json) => _$PrenotazioneFromJson(json);

  /// `toJson` is the convention for a class to declare support for serialization
  /// to JSON. The implementation simply calls the private, generated
  /// helper method `_$UserToJson`.
  Map<String, dynamic> toJson() => _$PrenotazioneToJson(this);
}

Map<String, dynamic> _$PrenotazioneToJson(Prenotazione instance) => <String, dynamic>{
  'durataPrenotazione': instance.durataPrenotazione,
  'utenteNonRegistrato': instance.utenteNonRegistrato,
  'dataPartita': instance.dataPartita,
  'campoDaGioco': instance.campoDaGioco,
  'utente': instance.utente,
  'privata': instance.privata,

};
