import 'package:flutter/material.dart';
import 'package:games/admin/dashboard_admin.dart';
import 'package:games/admin/tabbar_admin.dart';
import 'package:games/admin/testimg.dart';
import 'package:games/user/dashboard_user.dart';
import 'package:games/user/login_user.dart';
import 'package:games/user/tabbar_user.dart';
import 'package:shared_preferences/shared_preferences.dart';

extension BoolParsing on String {
  bool parseBool() {
    if (this.toLowerCase() == 'true') {
      return true;
    } else if (this.toLowerCase() == 'false') {
      return false;
    }

    throw '"$this" can not be parsed to boolean.';
  }
}

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  SharedPreferences preferences = await SharedPreferences.getInstance();
  var Email = preferences.getString('Email');
  var UserType = preferences.getString('usertype');

  Widget home() {
    if (Email != null && UserType == "Admin") {
      return tabbar_admin();
    } else if (Email != null && UserType == "User") {
      return tabbar_user();
    } else {
      return login_user();
    }
  }

  runApp(MaterialApp(
    theme: ThemeData(
      primarySwatch: Colors.blue,
    ),
    debugShowCheckedModeBanner: false,
    home: home(),
  ));
}
