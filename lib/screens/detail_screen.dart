import 'package:examen_final_llobera/providers/TreeService.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

import '../ui/input_decorations.dart';

class DetailScreen extends StatelessWidget {
  const DetailScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final userForm = Provider.of<TreeService>(context, listen: false);
    return Scaffold(
      appBar: AppBar(
        title: Text('Detail Screen'),
      ),
      body: _UserForm(),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          if (userForm.isValidForm()) {
            userForm.saveOrCreateUser();
            Navigator.of(context).pop();
          }
        },
        child: const Icon(Icons.save),
      ),
    );
  }
}

class _UserForm extends StatefulWidget {
  @override
  State<_UserForm> createState() => _UserFormState();
}

class _UserFormState extends State<_UserForm> {
  @override
  Widget build(BuildContext context) {
    final userForm = Provider.of<TreeService>(context, listen: false);
    final tempUser = userForm.tempUser;

    return Padding(
      padding: const EdgeInsets.all(10),
      child: SingleChildScrollView(
        child: Container(
          width: double.infinity,
          decoration: _buildBoxDecoration(),
          child: Padding(
            padding: const EdgeInsets.all(15),
            child: Form(
              key: userForm.formKey,
              autovalidateMode: AutovalidateMode.onUserInteraction,
              child: Column(
                children: [
                  SizedBox(height: 10),
                  TextFormField(
                    initialValue: tempUser.nom,
                    onChanged: (value) => tempUser.nom = value,
                    validator: (value) {
                      if (value == null || value.length < 1)
                        return 'El nom és obligatori';
                    },
                    decoration: InputDecorations.authInputDecoration(
                        hintText: 'Nom', labelText: 'Nom:'),
                  ),
                  SizedBox(height: 30),
                  TextFormField(
                    initialValue: '${tempUser.varietat}',
                    onChanged: (value) {
                      tempUser.varietat = value;
                    },
                    decoration: InputDecorations.authInputDecoration(
                        hintText: 'varietat', labelText: 'varietat:'),
                  ),
                  SizedBox(height: 30),
                  TextFormField(
                    initialValue: tempUser.tipus,
                    onChanged: (value) => tempUser.tipus = value,
                    validator: (value) {
                      if (value == null || value.length < 1)
                        return 'El tipus és obligatori';
                    },
                    decoration: InputDecorations.authInputDecoration(
                        hintText: 'tipus', labelText: 'tipus:'),
                  ),
                  SwitchListTile(
                    title: Text('Autocton'),
                    value: tempUser.autocton,
                    onChanged: ((value) {
                      setState(() {
                        tempUser.autocton = value;
                      });
                    }),
                  ),
                  TextFormField(
                    initialValue: tempUser.foto,
                    onChanged: (value) => tempUser.foto = value,
                    validator: (value) {
                      if (value == null || value.length < 1)
                        return 'El Detall és obligatori';
                    },
                    decoration: InputDecorations.authInputDecoration(
                        hintText: 'URL foto', labelText: 'URL foto:'),
                  ),
                  FadeInImage(
                    placeholder: const AssetImage('assets/no-image.jpg'),
                    image: NetworkImage(tempUser.foto == ''
                        ? 'https://i.stack.imgur.com/GNhxO.png'
                        : tempUser.foto),
                    width: 130,
                    height: 190,
                    fit: BoxFit.cover,
                  ),
                  TextFormField(
                    initialValue: tempUser.detall,
                    onChanged: (value) => tempUser.detall = value,
                    validator: (value) {
                      if (value == null || value.length < 1)
                        return 'El Detall és obligatori';
                    },
                    decoration: InputDecorations.authInputDecoration(
                        hintText: 'Detall', labelText: 'Detall:'),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  BoxDecoration _buildBoxDecoration() => BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.only(
          bottomRight: Radius.circular(25),
          bottomLeft: Radius.circular(25),
        ),
        boxShadow: [
          BoxShadow(
              color: Colors.black.withOpacity(0.05),
              offset: Offset(0, 5),
              blurRadius: 5),
        ],
      );
}
