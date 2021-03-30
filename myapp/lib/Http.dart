import 'package:http/http.dart' as http;

class Http {
  static const String URL =
      'https://credible-rider-308921.uc.r.appspot.com/students';

  static void post(name) async {
    await http.post(Uri.parse(URL),
        headers: {"Content-type": "application/json"},
        body: '{"name": "' + name + '"}');
  }

  static Future<http.Response> get() async {
    return await http.get(Uri.parse(URL));
  }
}
