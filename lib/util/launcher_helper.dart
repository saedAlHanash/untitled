import 'package:url_launcher/url_launcher.dart';

class LauncherHelper {
  static Future<void> openMap(num lat, num lng) async {
    final googleUrl =
        Uri.parse('https://www.google.com/maps/search/?api=1&query=$lat,$lng');

    if (await canLaunchUrl(googleUrl)) {
      await launchUrl(googleUrl);
    } else {
      throw 'Could not open the map.';
    }
  }

  static Future<void> openPage(String url) async {
    final googleUrl = Uri.parse(url);
      await launchUrl(googleUrl);
  }
  static callPhone(String phoneNumber) async {
    String uri = 'tel:$phoneNumber';
    await launchUrl(Uri.parse(uri));
  }
}
