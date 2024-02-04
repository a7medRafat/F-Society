import 'dart:io';
import 'package:http/http.dart' as http;

class Api {
  final HttpClient httpClient = HttpClient();
  final String fcmUrl = 'https://fcm.googleapis.com/fcm/send';
  var fcmKey =
      "AAAAYpAau1s:APA91bEwAgSBoWQvILdm6RUwBJPFDXldIhrKGUXWQnVn8B7EbjaGfnRZQo9KcFg9iQ1Jz23cEwvF2fgmNtkR2Ux2yPY6_q0yjI5EBfBGG5uNMXo0PtF4lb4GP3JACZvoTstrBLUB0XhN";

  void sendFcm(
      {required String title,
        required String body,
        required String type,
        required String fcmToken,
        required String uid}) async {
    var headers = {
      'Content-Type': 'application/json',
      'Authorization': 'key=$fcmKey'
    };
    var request = http.Request('POST', Uri.parse(fcmUrl));
    request.body = '''{
    "to":"$fcmToken",
    "priority":"high",

    "notification":{
    "title":"$title",
    "body":"$body",
    "sound": "default"},

    "data":{
    "type":"$type",
    "id":"0",
    "uid":"$uid",
    "click_action": "FLUTTER_NOTIFICATION_CLICK"},

    }''';
    request.headers.addAll(headers);

    http.StreamedResponse response = await request.send();

    if (response.statusCode == 200) {
      print(await response.stream.bytesToString());
      print('success noyification');
    } else {
      print(response.reasonPhrase);
      print('error noyification');
    }
  }
}
