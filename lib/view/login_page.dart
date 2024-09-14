import 'package:flutter/material.dart';

import '../helper.dart';
import '../service/auth_service.dart';
import '../widgets/input_widgets.dart';

class LoginPage extends StatefulWidget {
  LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final auth = AuthService();

  final _email = TextEditingController();
  final _pass = TextEditingController();
  final FocusNode _emailFocus = FocusNode();
  final FocusNode _passwordFocus = FocusNode();
  final _formKey = GlobalKey<FormState>();
  bool _isLoading = false; // Loading state

  @override
  void dispose() {
    _email.dispose();
    _pass.dispose();
    _emailFocus.dispose();
    _passwordFocus.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true, // Adjust layout for keyboard
      appBar: AppBar(
        title: const Center(child: Text("تسجيل الدخول")),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Directionality(
            textDirection: TextDirection.rtl, // Set RTL direction
            child: Center(
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: Form(
                  key: _formKey, // Assign the form key
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      // Logo Image
                      const Image(
                        image: AssetImage("Assets/logo.jpeg"),
                        height: 250,
                        fit: BoxFit.contain,
                      ),
                      const SizedBox(height: 20),
                      // Username TextField
                      CustomTextField(
                        hintText: "البريد الالكتروني",
                        prefixIcon: Icons.person,
                        inputType: TextInputType.emailAddress,
                        controller: _email,
                        focusNode: _emailFocus,
                        onFieldSubmitted: (_) {
                          FocusScope.of(context).requestFocus(_passwordFocus);
                        },
                        validator: Helper.validationEmail,
                      ),
                      const SizedBox(height: 20),

                      // Password TextField with an Icon
                      CustomTextField(
                        hintText: "كلمة المرور",
                        obscureText: true,
                        controller: _pass,
                        focusNode: _passwordFocus,
                        action: TextInputAction.done,
                        validator: Helper.validationPassword,
                      ),
                      const SizedBox(height: 20),

                      _isLoading
                          ? Center(
                              child: CircularProgressIndicator(
                              strokeWidth: 7.0,
                              color: Colors.teal,
                              strokeCap: StrokeCap.butt,
                            ))
                          :
                          // Login Button
                          SizedBox(
                              width: 200,
                              child: ElevatedButton(
                                onPressed: () {
                                  if (_formKey.currentState!.validate()) {
                                    // If the form is valid, proceed with login
                                    login(context);
                                  }
                                },
                                style: ButtonStyle(
                                  backgroundColor:
                                      WidgetStateProperty.all<Color>(
                                          Colors.blue),
                                  textStyle: WidgetStateProperty.all<TextStyle>(
                                    const TextStyle(fontSize: 16),
                                  ),
                                ),
                                child: const Text(
                                  'دخول',
                                  style: TextStyle(color: Colors.white),
                                ),
                              ),
                            ),
                      const SizedBox(
                        height: 10,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Text("ليس لدي حساب؟"),
                          TextButton(
                            onPressed: () {
                              // Navigate to the sign-up page
                              Navigator.pushNamed(context, 'signup');
                            },
                            child: const Text(
                              "إنشاء حساب",
                              style: TextStyle(color: Colors.blue),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  login(BuildContext context) async {
    setState(() {
      _isLoading = true; // Show loading indicator
    });
    final user = await auth.loginWithEmailAndPassword(_email.text, _pass.text);
    setState(() {
      _isLoading = false; // Show loading indicator
    });
    if (user != null) {
      Helper.showMessage(
          "تم تسجيل الدخول بنجاح", Colors.green, "#4CAF50FF");

      Navigator.pushNamed(context, 'home');
    } else {
      Helper.showMessage(
          "البريد الالكتروني او كلمة المرور خطاء", Colors.red, "#FF0000");
    }
  }
}
