import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'ContactList.dart';

String msg = '';

class LogInForm extends StatefulWidget {
  const LogInForm({Key? key}) : super(key: key);

  @override
  State<LogInForm> createState() => _LogInFormState();
}

class _LogInFormState extends State<LogInForm> {

  TextEditingController nameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text(
          'Log In',
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(25),
        child: Column(
          children: [
            Container(
                alignment: Alignment.center,
                padding: const EdgeInsets.all(10),
                child: const Text(
                  'Log In',
                  style: TextStyle(
                      color: Colors.blue,
                      fontWeight: FontWeight.w500,
                      fontSize: 30),
                )),
            Container(
              padding: const EdgeInsets.all(10),
              child: TextField(
                controller: nameController,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'User Name',
                ),
              ),
            ),
            Container(
              padding: const EdgeInsets.fromLTRB(10, 10, 10, 0),
              child: TextField(
                obscureText: true,
                controller: passwordController,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Password',
                ),
              ),
            ),
            Container(
                height: 50,
                margin: const EdgeInsets.fromLTRB(0, 20, 0, 20),
                padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
                child: ElevatedButton(
                  child: const Text('Login'),
                  onPressed: () {
                    logIn(nameController.text, passwordController.text);
                  },
                )
            ),
            Text(msg, style: const TextStyle(color: Colors.redAccent))
          ],
        ),
      ),
    );
  }
  void logIn(user, pass) async{
    final prefs = await SharedPreferences.getInstance();
    final String? userName = prefs.getString('userName');
    final String? password= prefs.getString('password');

    if(userName == user && password == pass){
      await prefs.setBool('loggedIn', true);
      setState(() {
        msg = '';
      });
      Navigator.push(context, MaterialPageRoute(builder: (context) => ContactList()));
    }
    else{
      setState(() {
        msg = 'Login information is incorrect, please try again.';
      });
      Navigator.push(context, MaterialPageRoute(builder: (context) => LogInForm()));
    }
  }
}