import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../helper.dart';

class LogoutPage extends StatefulWidget {
  LogoutPage({super.key});

  @override
  State<LogoutPage> createState() => _LogoutPageState();
}

class _LogoutPageState extends State<LogoutPage> {
  User? user = FirebaseAuth.instance.currentUser;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: Colors.black12,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            BackButton(
              onPressed: () {
                Navigator.pop(context);
              },
            ),
            Text(
              "تسجيل الخروج",
              style: TextStyle(
                  fontWeight: FontWeight.w500,
                  color: Colors.blueAccent,
                  fontSize: 16),
            ),
            const ClipOval(
              child: Image(
                image: AssetImage('Assets/logo.jpeg'),
                // Ensure the path is correct
                height: 40,
                width: 40,
                // Width should match height for a perfect circle
                fit: BoxFit.cover, // Use cover to ensure the image fits well
              ),
            ),
          ],
        ),
      ),
      body: SizedBox(
        height: MediaQuery.sizeOf(context).height,
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const Image(
                image: AssetImage("Assets/logo.jpeg"),
                height: 250,
                fit: BoxFit.contain,
              ),
              const SizedBox(
                height: 20,
              ),
              Text(
                " مرحبا ${user?.displayName?.isNotEmpty == true ? user?.displayName : ''}",
                style:
                    const TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
              ),
              const SizedBox(
                height: 20,
              ),
              Text(
                "${user?.email?.isNotEmpty == true ? user?.email : ''}",
                style:
                    const TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
              ),
              const SizedBox(
                height: 20,
              ),
              SizedBox(
                width: 200,
                child: ElevatedButton(
                  onPressed: () {
                    FirebaseAuth.instance.signOut();

                    Helper.showMessage(
                        'تم تسجيل الخروج بنجاح', Colors.green, "#4CAF50FF");

                    // Navigate to login and remove all previous routes
                    Navigator.pushNamedAndRemoveUntil(
                      context,
                      'login',
                      (Route<dynamic> route) => false,
                    );
                  },
                  style: ButtonStyle(
                    backgroundColor:
                        WidgetStateProperty.all<Color>(Colors.blue),
                    textStyle: WidgetStateProperty.all<TextStyle>(
                      const TextStyle(fontSize: 16),
                    ),
                  ),
                  child: const Text(
                    'تسجيل الخروج',
                    style: TextStyle(color: Colors.white),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    ));
  }
}
