import 'package:flutter/material.dart';
import 'package:smart_cradle_infants_app/helper.dart';

import '../service/auth_service.dart';
import '../widgets/input_widgets.dart';

class SignupPage extends StatefulWidget {
  SignupPage({super.key});

  @override
  State<SignupPage> createState() => _SignupPageState();
}

class _SignupPageState extends State<SignupPage> {
  final _auth = AuthService();

  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _passController = TextEditingController();

  final FocusNode _nameFocus = FocusNode();
  final FocusNode _emailFocus = FocusNode();
  final FocusNode _passwordFocus = FocusNode();
  bool _isLoading = false; // Loading state
  final _formKey = GlobalKey<FormState>();

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _passController.dispose();
    _nameFocus.dispose();
    _emailFocus.dispose();
    _passwordFocus.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true, // Adjust layout for keyboard
      appBar: AppBar(
        title: const Center(child: Text("انشاء حساب")),
      ),
      body: SingleChildScrollView(
        child: Center(
          child: Directionality(
            textDirection: TextDirection.rtl, // Set RTL direction
            child: Form(
              key: _formKey, // Assign the form key
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Image(
                    image: AssetImage("Assets/logo.jpeg"),
                    height: 250,
                    fit: BoxFit.contain,
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  CustomTextField(
                    hintText: "أسم المستخدم",
                    prefixIcon: Icons.person,
                    inputType: TextInputType.name,
                    controller: _nameController,
                    focusNode: _nameFocus,
                    onFieldSubmitted: (_) {
                      FocusScope.of(context).requestFocus(_emailFocus);
                    },
                    validator: Helper.validationName,
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  CustomTextField(
                    hintText: "البريد الالكتروني",
                    prefixIcon: Icons.email,
                    inputType: TextInputType.emailAddress,
                    controller: _emailController,
                    focusNode: _emailFocus,
                    onFieldSubmitted: (_) {
                      FocusScope.of(context).requestFocus(_passwordFocus);
                    },
                    validator: Helper.validationEmail,
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  CustomTextField(
                    hintText: "كلمة المرور",
                    obscureText: true,
                    inputType: TextInputType.text,
                    controller: _passController,
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

                      ))
                      :
                  // signup Button
                  SizedBox(
                    width: 200,
                    child: ElevatedButton(
                      onPressed: () {
                        // Handle create action
                        //
                        if (_formKey.currentState!.validate()) {
                          signUp();
                        }
                      },
                      style: ButtonStyle(
                        backgroundColor:
                            WidgetStateProperty.all<Color>(Colors.blue),
                        textStyle: WidgetStateProperty.all<TextStyle>(
                          const TextStyle(fontSize: 16),
                        ),
                      ),
                      child: const Text(
                        'انشاء الحساب',
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
                      const Text("لدي حساب بالفعل؟"),
                      TextButton(
                        onPressed: () {
                          // Navigate to the sign-up page
                          Navigator.pushNamed(context, 'login');
                        },
                        child: const Text(
                          "دخول",
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
    );
  }

  Future<void> signUp() async {
    setState(() {
      _isLoading = true; // Show loading indicator
    });
    final user = await _auth.createUserWithEmailAndPassword(
        _emailController.text, _passController.text, context);
    setState(() {
      _isLoading = false; // Show loading indicator
    });
    if (user != null) {
      await user.updateProfile(displayName: _nameController.text);
      await _auth.signOut();

      Navigator.pushNamed(context, 'login');
    } else {
      Helper.showMessage("فشل إنشاءالمستخدم", Colors.red, "#FF0000");
    }
  }
}
