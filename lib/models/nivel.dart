import 'dart:convert';

List<Nivel> NivelFromJson(var str) =>
    List<Nivel>.from(json.decode(str).map((x) => Nivel.fromJson(x)));

String NivelToJson(List<Nivel> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Nivel {
  Nivel(
      {required this.id,
      required this.reservatorio,
      required this.nivel,
      required this.dataHora});

  String id;
  String reservatorio;
  String nivel;
  String dataHora;

  factory Nivel.fromJson(Map<String, dynamic> json) => Nivel(
        id: json["id"],
        reservatorio: json["reservatorio"],
        nivel: json["nivel"],
        dataHora: json["dataHora"],
      );
  factory Nivel.fromMap(Map<String, dynamic> json) => Nivel(
        id: json["id"],
        reservatorio: json["reservatorio"],
        nivel: json["nivel"],
        dataHora: json["dataHora"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "reservatorio": reservatorio,
        "nivel": nivel,
        "dataHora": dataHora,
      };
}
