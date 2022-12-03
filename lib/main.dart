import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'ContactList.dart';
import 'LogIn.dart';
import 'SignUp.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {

  late String _userName = '';
  late String _password = '';
  late bool _loggedIn = false;

  getLogInInfo() async{
    final prefs = await SharedPreferences.getInstance();
    final String? userName = prefs.getString('userName');
    final String? password= prefs.getString('password');
    final bool? loggedIn = prefs.getBool('loggedIn');

    setState(() {
      _userName = userName ?? '';
      _password = password ?? '';
      _loggedIn = loggedIn ?? false;
    });
  }

  @override
  void initState() {
    super.initState();
    getLogInInfo();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: _loggedIn ? ContactList() : _userName == '' ? SignUpForm() : LogInForm(),
    );
  }
}