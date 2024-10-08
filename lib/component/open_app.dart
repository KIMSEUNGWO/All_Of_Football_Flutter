
import 'dart:io';

import 'package:all_of_football/domain/cash/kakao_ready_response.dart';
import 'package:url_launcher/url_launcher.dart';

class OpenApp {

  // 테스트용
  static const String homeLat = "35.757721";
  static const String homeLng = "139.527805";

  openMaps({required double lat, required double lng}) async {

    String openApp = 'comgooglemaps://';
    print(await canLaunchUrl(Uri.parse(openApp)));
    // await launchUrl(Uri.parse(openApp));
    Uri googleMap = _google(lat, lng);
    if (await canLaunchUrl(googleMap)) {
      await launchUrl(googleMap);
    }

    Uri appleMap = _apple(lat, lng);
    if (await canLaunchUrl(appleMap)) {
      launchUrl(appleMap);
      return;
    }

  }

  kakaoOpenUrl(KakaoReady kakao) async {
    await launchUrl(Uri.parse(kakao.next_redirect_app_url));
    closeInAppWebView();
    // if (Platform.isAndroid && await canLaunchUrl(Uri.parse(kakao.android_app_scheme))) {
    //   await launchUrl(Uri.parse(kakao.android_app_scheme));
    //   return;
    // } else if (Platform.isIOS && await canLaunchUrl(Uri.parse(kakao.ios_app_scheme))) {
    //   await launchUrl(Uri.parse(kakao.ios_app_scheme), mode: LaunchMode.externalApplication);
    //   return;
    // }
  }

  _google(double lat, double lng) {
    return Uri.parse('comgooglemaps://?q=$lat,$lng');
  }

  _apple(double lat, double lng) {
    return Uri.parse('maps://?q=$lat,$lng');
  }
}
