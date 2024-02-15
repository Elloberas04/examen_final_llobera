import 'package:examen_final_llobera/preferences/preferences.dart';
import 'package:flutter/material.dart';

class LoginOrRegisterScreen extends StatefulWidget {
  const LoginOrRegisterScreen({super.key});

  @override
  _LoginOrRegisterScreenState createState() => _LoginOrRegisterScreenState();
}

class _LoginOrRegisterScreenState extends State<LoginOrRegisterScreen>
    with SingleTickerProviderStateMixin {
  final GlobalKey<FormState> _key = GlobalKey();

  bool _isChecked = Preferences.remember;
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

// Comprovam inicialment si l'usuari ja ha fet login o si ha marcat la casella de recordar les credencials.
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance!.addPostFrameCallback((_) {
      if (Preferences.loginDone || Preferences.remember) {
        Navigator.of(context).pushNamed('home');
      }
    });
    // Incialitzem les controllers
    _passwordController.text = Preferences.password;
    _emailController.text = Preferences.email;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            loginOrRegisterForm(context),
            const SizedBox(height: 100),
          ],
        ),
      ),
    );
  }

// Cream el formurlari.
  Widget loginOrRegisterForm(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        const Text('Inicia sessió'),
        SizedBox(
          width: 300.0,
          child: Form(
            key: _key,
            child: Column(
              children: <Widget>[
                TextFormField(
                  controller: _emailController,
                  // initialValue: Preferences.email,
                  validator: (text) {
                    if (text!.isEmpty) {
                      return "Correu es obligatori";
                    }
                    return null;
                  },
                  keyboardType: TextInputType.emailAddress,
                  maxLength: 50,
                  textAlign: TextAlign.left,
                  decoration: InputDecoration(
                    hintText: 'Escrigui el seu correu',
                    labelText: 'Correu',
                    counterText: '',
                    icon:
                        Icon(Icons.email, size: 32.0, color: Colors.blue[800]),
                  ),
                ),
                TextFormField(
                  controller: _passwordController,
                  // initialValue: Preferences.password,
                  validator: (text) {
                    if (text!.isEmpty) {
                      return "Contrasenya és obligatori";
                    } else if (text.length <= 5) {
                      return "Contrasenya mínim de 5 caràcters";
                    }
                    return null;
                  },
                  keyboardType: TextInputType.text,
                  maxLength: 20,
                  textAlign: TextAlign.left,
                  decoration: InputDecoration(
                    hintText: 'Escrigui la contrasenya',
                    labelText: 'Contrasenya',
                    counterText: '',
                    icon: Icon(Icons.lock, size: 32.0, color: Colors.blue[800]),
                  ),
                ),
                CheckboxListTile(
                  value: _isChecked,
                  onChanged: (value) {
                    _isChecked = value!;
                    setState(() {});
                  },
                  title: const Text('Recorda\'m'),
                  controlAffinity: ListTileControlAffinity.leading,
                ),
                IconButton(
                  // Si la casella esta marcada, guardam les dades a Preferences i sino les esborram.
                  onPressed: () => {
                    if (_isChecked)
                      {
                        Preferences.email = _emailController.value.text,
                        Preferences.password = _passwordController.value.text,
                        Preferences.remember = _isChecked,
                      }
                    else
                      {
                        Preferences.email = '',
                        Preferences.password = '',
                        Preferences.remember = _isChecked,
                      },
                    //Indiquem que l'usuari ha fet login i el redirigim a la pantalla principal.
                    Preferences.loginDone = true,
                    Navigator.of(context).pushNamed('home'),
                  },
                  icon: Icon(
                    Icons.arrow_forward,
                    size: 42.0,
                    color: Colors.blue[800],
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
