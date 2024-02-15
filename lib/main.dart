import 'package:examen_final_llobera/preferences/preferences.dart';
import 'package:examen_final_llobera/providers/TreeService.dart';
import 'package:examen_final_llobera/screens/detail_screen.dart';
import 'package:examen_final_llobera/screens/login_or_register.dart';
import 'package:examen_final_llobera/screens/screens.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Preferences.init();
  runApp(AppState());
}

class AppState extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => TreeService()),
        // ChangeNotifierProvider(create: (_) => DBProvider()),
      ],
      child: MyApp(),
    );
  }
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(primarySwatch: Colors.blue),
      routes: {
        '/': (_) => LoginOrRegisterScreen(),
        'home': (_) => HomeScreen(),
        'detail': (_) => DetailScreen(),
      },
    );
  }
}
