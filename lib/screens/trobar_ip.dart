import 'package:examen_final_llobera/models/ip_info.dart';
import 'package:examen_final_llobera/providers/trobar_ip_provider.dart';
import 'package:flutter/material.dart';

// Pestanya amb un boto per trobar la IP de l'usuari i la seva localització.
class TorbarIP extends StatelessWidget {
  const TorbarIP({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Trobar IP'),
        ),
        body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              'Clica el boto per trobar la teva IP i obtenir la teva localització',
              style: TextStyle(fontSize: 20),
              textAlign: TextAlign.center,
            ),
            ElevatedButton(
                onPressed: () async {
                  IpInfo info = await PlaceProvider().getIpDetails();

                  Navigator.pushNamed(context, 'mapa', arguments: info);
                },
                child: Text('TROBAR IP'))
          ],
        ));
  }
}
