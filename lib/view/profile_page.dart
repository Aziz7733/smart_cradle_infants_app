import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:smart_cradle_infants_app/widgets/input_widgets.dart';

import '../helper.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  final _formKey = GlobalKey<FormState>();
  bool _isLoading = false; // Loading state
  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _passController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _loadUserData();
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: SizedBox(
        height: MediaQuery.sizeOf(context).height,
        child: Center(
          child: Form(
            key: _formKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const Text(
                  "تعديل الملف الشخصي",
                  style: TextStyle(
                      fontWeight: FontWeight.w500,
                      color: Colors.blueAccent,
                      fontSize: 20),
                ),
                SizedBox(
                  height: 20,
                ),
                CustomTextField(
                  hintText: "الاسم",
                  inputType: TextInputType.name,
                  prefixIcon: Icons.person,
                  controller: _nameController,
                  validator: Helper.validationName,
                ),
                SizedBox(
                  height: 20,
                ),
                CustomTextField(
                  hintText: "الايميل",
                  prefixIcon: Icons.email,
                  controller: _emailController,
                  inputType: TextInputType.emailAddress,
                  validator: Helper.validationEmail,
                ),
                SizedBox(
                  height: 20,
                ),
                CustomTextField(
                  hintText: "كلمة السر",
                  obscureText: true,
                  controller: _passController,
                  action: TextInputAction.done,
                  validator: Helper.validationProfilePass,
                ),
                SizedBox(
                  height: 20,
                ),
                _isLoading
                    ? Center(
                        child: CircularProgressIndicator(
                        strokeWidth: 7.0,
                        color: Colors.teal,
                        strokeCap: StrokeCap.butt,
                      ))
                    :
                    //update profile
                    SizedBox(
                        width: 200,
                        child: ElevatedButton(
                          onPressed: () {
                            if (_formKey.currentState!.validate()) {
                              // If the form is valid, proceed with update profile
                              _updateProfile();
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
                            'حفظ التغيرات',
                            style: TextStyle(color: Colors.white),
                          ),
                        ),
                      ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void _loadUserData() async {
    User? user = FirebaseAuth.instance.currentUser;

    if (user != null) {
      _nameController.text = user.displayName ?? '';
      _emailController.text = user.email ?? '';
    }
  }

  //update profile method
  Future<void> _updateProfile() async {
    User? user = FirebaseAuth.instance.currentUser;
    setState(() {
      _isLoading = true;
    });
    if (user != null) {
      try {
        // Update user profile if it is different
        if (user.displayName != _nameController.text) {
          await user.updateProfile(displayName: _nameController.text);
        }
        // Update email if it is different
        if (user.email != _emailController.text) {
          await user.updateEmail(_emailController.text);
        }
        // Handle password change if necessary
        if (_passController.text.isNotEmpty) {
          // Prompt user for re-authentication before changing the password
          // For demonstration purposes, we assume user is already re-authenticated.
          await user.updatePassword(_passController.text);
        }
        // Notify user of success

        Helper.showMessage(
            "تم تحديث الملف الشخصي بنجاح", Colors.green, "#4CAF50FF");
      } catch (e) {
        // Handle errors
        Helper.showMessage(
            'حدث خطأ أثناء تحديث الملف الشخصي: ${e.toString()}',
            Colors.red,
            "#FF0000");
      }
    }
    setState(() {
      _isLoading = false;
    });
  }

//
}
