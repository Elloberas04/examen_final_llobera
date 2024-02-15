import 'dart:convert';

class Tree {
  String nom;
  String varietat;
  String tipus;
  bool autocton;
  String foto;
  String detall;

  Tree({
    required this.nom,
    required this.varietat,
    required this.tipus,
    required this.autocton,
    required this.foto,
    required this.detall,
  });

  factory Tree.fromJson(String str) => Tree.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory Tree.fromMap(Map<String, dynamic> json) => Tree(
        nom: json["nom"] ?? '',
        varietat: json["varietat"] ?? '',
        tipus: json["tipus"] ?? '',
        autocton: json["autocton"] ?? '',
        foto: json["foto"] ?? '',
        detall: json["detall"] ?? '',
      );

  Map<String, dynamic> toMap() => {
        "nom": nom,
        "varietat": varietat,
        "tipus": tipus,
        "autocton": autocton,
        "foto": foto,
        "detall": detall,
      };

  Tree copy() => Tree(
      nom: nom,
      varietat: varietat,
      tipus: tipus,
      autocton: autocton,
      foto: foto,
      detall: detall);
}
