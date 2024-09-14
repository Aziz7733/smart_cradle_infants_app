import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:intl/intl.dart';

class Helper {
  static String? validationPassword(value) {
    if (value == null || value.isEmpty) {
      return 'يرجى إدخال كلمة المرور';
    } else if (value.length < 8) {
      return 'يجب أن يكون طول كلمة المرور على الاقل 8';
    }
    return null;
  }

  static String? validationEmail(value) {
    if (value == null || value.isEmpty) {
      return 'يرجى إدخال البريد الإلكتروني';
    } else if (!RegExp(r'^[^@]+@[^@]+\.[^@]+').hasMatch(value)) {
      return 'يرجى إدخال بريد إلكتروني صالح';
    }
    return null;
  }

  static String? validationName(value) {
    if (value == null || value.isEmpty) {
      return 'يرجى إدخال أسم المستخدم';
    }
    return null;
  }

  static String? validationProfilePass(value) {
    if (value == null || value.isEmpty) {
      return null;
    } else if (value.length < 8) {
      return 'يجب أن يكون طول كلمة المرور على الاقل 8';
    }
    return null;
  }

  static void showMessage(String msgContent, Color colorBg, String webBg) {
    Fluttertoast.showToast(
        msg: msgContent,
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.SNACKBAR,
        webPosition: "center",
        timeInSecForIosWeb: 3,
        backgroundColor: colorBg,
        textColor: Colors.white,
        webBgColor: webBg,
        fontSize: 16.0);
  }

// Format date and time
  static String formatDateTime(DateTime dateTime) {
    return DateFormat('HH:mm  dd-MM-yyyy').format(dateTime);
  }
  static String formatDate(DateTime dateTime) {
    return DateFormat('dd-MM-yyyy').format(dateTime);
  }
}
