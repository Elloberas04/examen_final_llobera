import 'dart:convert';
import 'package:examen_final_llobera/models/Tree.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class TreeService extends ChangeNotifier {
  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  final String _baseUrl =
      "examen-flutter-65e86-default-rtdb.europe-west1.firebasedatabase.app";
  List<Tree> users = [];
  late Tree tempUser;
  Tree? newUser;

  TreeService() {
    loadUsers();
  }

  bool isValidForm() {
    return formKey.currentState?.validate() ?? false;
  }

  // updateVerification(bool value) {
  //   this.tempUser.verificat = value;
  //   notifyListeners();
  // }

  loadUsers() async {
    print('CARREGANT...');
    users.clear();
    final url = Uri.https(_baseUrl, 'arbres.json');
    final response = await http.get(url);
    final Map<String, dynamic> usersMap = json.decode(response.body);

    // Mapejam la resposta del servidor, per cada usuari, el convertim a la classe i l'afegim a la llista
    usersMap.forEach((key, value) {
      final auxUser = Tree.fromMap(value);
      auxUser.nom = key;
      users.add(auxUser);
    });

    notifyListeners();
  }

  Future saveOrCreateUser() async {
    if (tempUser.nom == null) {
      //Cream l'usuari
      await this.createUser();
    } else {
      //Actualitzam l'usuari
      await this.updateUser();
    }
    loadUsers();
  }

  updateUser() async {
    final url = Uri.https(_baseUrl, 'arbres/${tempUser.nom}.json');
    final response = await http.put(url, body: tempUser.toJson());
    final decodedData = response.body;
  }

  createUser() async {
    final url = Uri.https(_baseUrl, 'arbres.json');
    final response = await http.post(url, body: tempUser.toJson());
    final decodedData = json.decode(response.body);
  }

  deleteUser(Tree usuari) async {
    final url = Uri.https(_baseUrl, 'arbres/${usuari.nom}.json');
    final response = await http.delete(url);
    final decodedData = json.decode(response.body);
    print(decodedData);
    loadUsers();
  }
}
