import 'package:examen_final_llobera/preferences/preferences.dart';
import 'package:examen_final_llobera/providers/TreeService.dart';
import 'package:examen_final_llobera/screens/detail_screen.dart';
import 'package:examen_final_llobera/screens/login_or_register.dart';
import 'package:examen_final_llobera/screens/mapa_screen.dart';
import 'package:examen_final_llobera/screens/screens.dart';
import 'package:examen_final_llobera/screens/trobar_ip.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

/**
 * Dins del main, s'ha d'assegurar que Preferences s'ha inicialitzat abans de
 * que es carregui l'aplicació. A més, s'ha d'assegurar que el TreeService
 * estigui disponible per a tota l'aplicació.
 */
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Preferences.init();
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => TreeService()),
      ],
      child: const MyApp(),
    ),
  );
}

/**
 * Aquesta és la classe principal de l'aplicació. Aquí es defineixen les rutes
 * de l'aplicació i el tema, el titol, etc.
 */
class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter EXAMEN',
      theme: ThemeData(primarySwatch: Colors.blue),
      routes: {
        '/': (_) => const LoginOrRegisterScreen(),
        'home': (_) => const HomeScreen(),
        'detail': (_) => const DetailScreen(),
        'trobar_ip': (_) => const TorbarIP(),
        'mapa': (_) => const MapaScreen(),
      },
    );
  }
}
