import 'package:firebase_messaging/firebase_messaging.dart';

class NotificationHandler {
  final FirebaseMessaging _firebaseMessaging = FirebaseMessaging.instance;

  // Request notification permission
  Future<void> requestNotificationPermission() async {
    
    NotificationSettings settings = await _firebaseMessaging.requestPermission(
      alert: true,
      announcement: false,
      badge: true,
      carPlay: false,
      criticalAlert: false,
      provisional: false,
      sound: true,
    );

    if (settings.authorizationStatus == AuthorizationStatus.authorized) {
      print('User granted permission');
    } else if (settings.authorizationStatus ==
        AuthorizationStatus.provisional) {
      print('User granted provisional permission');
    } else {
      print('User declined or has not accepted permission');
    }
  }

  // Get device token
  Future<String?> getDeviceToken({String? vapidKey}) async {
    try {
      return await _firebaseMessaging.getToken(
          vapidKey: vapidKey
          );
    } catch (e) {
      print('Error fetching FCM token: $e');
      return null;
    }
  }

  // Handle token refresh
  void handleTokenRefresh(Function(String token) updateToken) {
    _firebaseMessaging.onTokenRefresh.listen((newToken) {
      updateToken(newToken);
    }).onError((error) {
      print('Error during token refresh: $error');
    });
  }
}
