import 'dart:convert';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;

Future<List<String?>?> createNotificationTraccar() async {
  List<String?> id = [];
  String traccarUser = dotenv.get("traccarUser");
  String traccarPass = dotenv.get("traccarPass");
  String traccarApi = dotenv.get("traccarApi");
  String basicAuth =
      'Basic ' + base64Encode(utf8.encode('$traccarUser:$traccarPass'));

  Map data = {
    "attributes": {},
    "calendarId": 0,
    "always": true,
    "type": "deviceOffline",
    "notificators": "web,mail,firebase"
  };
  String body = json.encode(data);

  var response = await http.post(Uri.parse("$traccarApi/notifications"),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'authorization': basicAuth,
      },
      body: body);
  print(response.body);
  if (response.statusCode == 200) {
    var decodedResponse = json.decode(response.body);
    id.add(decodedResponse["id"].toString());

    data = {
      "attributes": {},
      "calendarId": 0,
      "always": true,
      "type": "deviceMoving",
      "notificators": "web,mail,firebase"
    };
    String body = json.encode(data);

    response = await http.post(Uri.parse("$traccarApi/notifications"),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          'authorization': basicAuth,
        },
        body: body);
    if (response.statusCode == 200) {
      var decodedResponse = json.decode(response.body);
      id.add(decodedResponse["id"].toString());
    }

    return id;
  } else
    return null;
}
