import 'dart:convert';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import 'package:take_me_with_you/core/utils/app_pref.dart';
import 'package:take_me_with_you/core/utils/di.dart';

class FcmTokenHandler {
  static const String _fcmTokenKey = 'fcm_token';

  static Future<void> handleFcmToken() async {
    final prefs = await SharedPreferences.getInstance();
    final FirebaseMessaging messaging = FirebaseMessaging.instance;

    final String? currentToken = await messaging.getToken();

    if (currentToken == null) {
      print('null fcm token');
      return;
    }

    final String? savedToken = prefs.getString(_fcmTokenKey);
    final appPreferences = instance<AppPreferences>();
    final String? userToken = appPreferences.getUserToken();

    print('saved token: $savedToken');
    print('current token: $currentToken');
    print('user token: $userToken');

    if (userToken == null) {
      print('no user token available.');
      return;
    }

    if (savedToken != currentToken) {
      await prefs.setString(_fcmTokenKey, currentToken);
      await _sendTokenToServer(currentToken, userToken);
    } else {
      print('token is up-to-date.');
    }
  }

  static Future<void> _sendTokenToServer(
      String fcmToken, String userToken) async {
    const String apiUrl = 'https://3tre2k.nashwati.com/userapi/set-token';

    try {
      final response = await http.post(
        Uri.parse(apiUrl),
        headers: {
          'Authorization': 'Bearer $userToken',
          'Content-Type': 'application/json',
          'Accept': 'application/json',
        },
        body: jsonEncode({'token': fcmToken}),
      );
      if (response.statusCode == 200) {
        print('sent successfully');
      } else {
        print('failed to send: ${response.statusCode} → ${response.body}');
      }
    } catch (e) {
      print('error sending: $e');
    }
  }
}
