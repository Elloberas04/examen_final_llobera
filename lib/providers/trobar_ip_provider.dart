import 'package:examen_final_llobera/models/ip.dart';
import 'package:examen_final_llobera/models/ip_info.dart';
import 'package:http/http.dart' as http;

/**
 * Aquesta classe s'encarrega de cercar la IP de l'usuari i de cercar-ne
 * els detalls mitjançant la API d'ipinfo.io. Tornam les dades de la IP
 * i de la localització.
 */
class PlaceProvider {
  Future<String> getIp() async {
    print('Cercant IP...');
    var url = Uri.https('api.ipify.org', '/', {'format': 'json'});

    final result = await http.get(url);

    final moviesBySearchResponse = Ip.fromJson(result.body);

    print(moviesBySearchResponse.ip);
    return moviesBySearchResponse.ip;
  }

  Future<IpInfo> getIpDetails() async {
    var url = Uri.https('ipinfo.io', '${await getIp()}/geo');

    print(url);
    final result = await http.get(url);

    final response = IpInfo.fromJson(result.body);

    return response;
  }
}
