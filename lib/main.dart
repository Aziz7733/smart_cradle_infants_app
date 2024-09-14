import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:smart_cradle_infants_app/view/logout_page.dart';
import 'package:smart_cradle_infants_app/view/profile_page.dart';

import 'firebase_options.dart';
import 'view/history_record_page.dart';
import 'view/home_page.dart';
import 'view/login_page.dart';
import 'view/signup_page.dart';
import 'view/welcome_page.dart';

Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  await Firebase.initializeApp();
  AwesomeNotifications().createNotification(
    content: NotificationContent(
      id: message.hashCode,
      channelKey: 'high_importance_channel',
      title: message.notification?.title,
      body: message.notification?.body,
    ),
  );
}

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  // Initialize Awesome Notifications
  AwesomeNotifications().initialize(
    null,
    [
      NotificationChannel(
        channelKey: 'high_importance_channel',
        channelName: 'High Importance Notifications',
        channelDescription: 'Notification channel for important messages',
        defaultColor: const Color(0xFF9D50DD),
        importance: NotificationImportance.High,
        channelShowBadge: true,
        locked: true,
      ),
    ],
    debug: true,
  );

  // Request notification permission
  FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);

  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  // This widget is the root of your application.
  @override
  void initState() {
    super.initState();

    // Request permission for notifications on iOS
    FirebaseMessaging.instance.requestPermission();

    // Listen to FCM messages when the app is in the foreground
    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      print('Foreground message: ${message.notification?.title}');

      // Show an Awesome Notification
      AwesomeNotifications().createNotification(
        content: NotificationContent(
          id: message.hashCode,
          channelKey: 'high_importance_channel',
          title: message.notification?.title,
          body: message.notification?.body,
          notificationLayout: NotificationLayout.Default,
        ),
      );
    });

    // // Handle notification taps when app is opened from background
    // FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
    //   print('Notification clicked!');
    // });
    //
    // // Get the FCM token for testing purposes
    // FirebaseMessaging.instance.getToken().then((token) {
    //   print('FCM Token: $token');
    // });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Smart Cradle',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const WelcomePage(),
      debugShowCheckedModeBanner: false,
      routes: {
        'main': (context) => const WelcomePage(),
        'login': (context) => LoginPage(),
        'signup': (context) => SignupPage(),
        'home': (context) => const HomePage(),
        'logout': (context) => LogoutPage(),
        'history': (context) => const HistoryRecordPage(),
      },
    );
  }
}
