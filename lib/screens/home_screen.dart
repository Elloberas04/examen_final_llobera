import 'package:examen_final_llobera/models/Tree.dart';
import 'package:examen_final_llobera/preferences/preferences.dart';
import 'package:examen_final_llobera/providers/TreeService.dart';
import 'package:examen_final_llobera/ui/ui.dart';
import 'package:examen_final_llobera/widgets/widgets.dart';
import 'package:provider/provider.dart';
import 'package:flutter/material.dart';

/**
 * Dins d'aquesta classe es mostra el llistat d'arbres, i es permet
 * afegir-ne de nous, modificar-ne o esborrar-ne.
 */
class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    // Obtenim el provider del TreeService
    final userService = Provider.of<TreeService>(context);
    List<Tree> usuaris = userService.users;
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Text('Llistat arbres'),
        actions: [
          // Botó per tancar sessió
          IconButton(
            icon: Icon(Icons.logout),
            onPressed: () {
              Preferences.loginDone = false;
              Navigator.pushReplacementNamed(context, '/');
            },
          ),
          // Botó per trobar la IP
          IconButton(
            icon: Icon(Icons.network_cell),
            onPressed: () {
              Navigator.pushNamed(context, 'trobar_ip');
            },
          ),
        ],
      ),
      // Si no hi ha usuaris, mostrem un cercle de carrega
      body: usuaris.isEmpty
          ? Loading()
          : ListView.builder(
              itemCount: usuaris.length,
              itemBuilder: ((context, index) {
                return Dismissible(
                  key: UniqueKey(),
                  direction: DismissDirection.endToStart,
                  background: Container(
                    alignment: AlignmentDirectional.centerEnd,
                    color: Colors.red,
                    child: Padding(
                      padding: EdgeInsets.fromLTRB(0.0, 0.0, 10.0, 0.0),
                      child: Icon(Icons.delete, color: Colors.white),
                    ),
                  ),
                  child: GestureDetector(
                    child: UserCard(usuari: usuaris[index]),
                    onTap: () {
                      // Navegam a la pestanya de detalls
                      userService.tempUser = usuaris[index].copy();
                      Navigator.of(context).pushNamed('detail');
                    },
                  ),
                  onDismissed: (direction) {
                    if (usuaris.length < 2) {
                      setState(() {
                        userService.loadUsers();
                        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                            content:
                                Text('No es pot esborrar tots els elements!')));
                      });
                    } else {
                      userService.deleteUser(usuaris[index]);
                      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                          content: Text(
                              '${userService.users[index].nom} esborrat')));
                    }
                  },
                );
              }),
            ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // Cream un usuari temporal nou, per diferenciar-lo d'un ja creat,
          // per que aquest no tindrà id encara, i d'aquesta forma sabrem
          // discernir al detailscreen que estam creant un usuari nou i no
          // modificant un existent
          userService.tempUser = Tree(
              nom: '',
              varietat: '',
              tipus: '',
              autocton: true,
              foto: '',
              detall: '');
          Navigator.of(context).pushNamed('detail');
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
