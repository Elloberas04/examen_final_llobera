import 'dart:convert';

import 'package:google_maps_flutter/google_maps_flutter.dart';

class IpInfo {
  String ip;
  String city;
  String region;
  String country;
  String loc;
  String org;
  String postal;
  String timezone;
  String readme;

  IpInfo({
    required this.ip,
    required this.city,
    required this.region,
    required this.country,
    required this.loc,
    required this.org,
    required this.postal,
    required this.timezone,
    required this.readme,
  });

  LatLng getLatLng() {
    final latLng = loc.split(',');
    final latitude = double.parse(latLng[0]);
    final longitude = double.parse(latLng[1]);

    return LatLng(latitude, longitude);
  }

  factory IpInfo.fromJson(String str) => IpInfo.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory IpInfo.fromMap(Map<String, dynamic> json) => IpInfo(
        ip: json["ip"],
        city: json["city"],
        region: json["region"],
        country: json["country"],
        loc: json["loc"],
        org: json["org"],
        postal: json["postal"],
        timezone: json["timezone"],
        readme: json["readme"],
      );

  Map<String, dynamic> toMap() => {
        "ip": ip,
        "city": city,
        "region": region,
        "country": country,
        "loc": loc,
        "org": org,
        "postal": postal,
        "timezone": timezone,
        "readme": readme,
      };
}
