import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:goal_bank/models/dto/message_dto.dart';

class PushNotificationsProvider extends ChangeNotifier {
  Future _handleMessage(Message message) {
    print(message.title);
  }

  void init() {
    final FirebaseMessaging _firebaseMessaging = FirebaseMessaging();

    _firebaseMessaging.requestNotificationPermissions(
      IosNotificationSettings(
        alert: true,
        badge: true,
        sound: true,
      ),
    );

    _firebaseMessaging.configure(
      onLaunch:  (Map<String, dynamic> message) async => _handleMessage(
        Message(message),
      ),
      onResume:  (Map<String, dynamic> message) async => _handleMessage(
        Message(message),
      ),
      onMessage: (Map<String, dynamic> message) async => _handleMessage(
        Message(message),
      ),
    );

    _firebaseMessaging
        .getToken()
        .then((token) => print("FCM Token =>[$token]"));
  }
}
