
import 'package:url_launcher/url_launcher.dart';

class OpenApp {

  // 테스트용
  static const String homeLat = "35.757721";
  static const String homeLng = "139.527805";

  openMaps({required double lat, required double lng}) async {

    Uri googleMap = _google(lat, lng);
    if (await canLaunchUrl(googleMap)) {
      launchUrl(googleMap);
      return;
    }

    Uri appleMap = _apple(lat, lng);
    if (await canLaunchUrl(appleMap)) {
      launchUrl(appleMap);
      return;
    }

  }

  _google(double lat, double lng) {
    return Uri.parse('comgooglemaps://?q=$lat,$lng');
  }

  _apple(double lat, double lng) {
    return Uri.parse('maps://?q=$lat,$lng');
  }
}
