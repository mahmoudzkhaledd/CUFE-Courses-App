import 'package:flutter/material.dart';

import '../Models/User.dart';

class Methods {
  static User user = User(department: "HEM");
  static Color hexColor(String color) {
    color = "FF${color.replaceAll("#", "")}";
    return Color(int.parse(color.toString(), radix: 16));
  }

  static void message(BuildContext ctx, String msg) {
    ScaffoldMessenger.of(ctx).showSnackBar(
      SnackBar(
        content: Text(msg),
        showCloseIcon: true,
      ),
    );
  }
}
