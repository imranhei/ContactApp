import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'ContactList.dart';

class AddToContacts extends StatelessWidget {
  AddToContacts({Key? key}) : super(key: key);

  final TextEditingController nameController = TextEditingController();
  final TextEditingController phone1Controller = TextEditingController();
  final TextEditingController phone2Controller = TextEditingController();
  final TextEditingController emailController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Add to Contacts'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(25),
        child: Column(
          children: [
            Container(
            ),
            Container(
              padding: const EdgeInsets.all(10),
              child: TextField(
                controller: nameController,
                decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'Name',
                    icon: Icon(Icons.person)
                ),
              ),
            ),
            Container(
              padding: const EdgeInsets.fromLTRB(10, 10, 10, 0),
              child: TextField(
                controller: phone1Controller,
                decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'Personal Phone',
                    icon: Icon(Icons.smartphone)
                ),
              ),
            ),
            Container(
              padding: const EdgeInsets.fromLTRB(10, 10, 10, 0),
              child: TextField(
                controller: phone2Controller,
                decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'Office Phone',
                    icon: Icon(Icons.phone)
                ),
              ),
            ),
            Container(
              padding: const EdgeInsets.fromLTRB(10, 10, 10, 0),
              child: TextField(
                controller: emailController,
                decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'Email',
                    icon: Icon(Icons.email)
                ),
              ),
            ),
            Container(
                height: 50,
                margin: const EdgeInsets.fromLTRB(0, 20, 0, 20),
                padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
                child: ElevatedButton(
                    child: const Text('Save'),
                    onPressed: () {
                      write(nameController.text, phone1Controller.text,
                          phone2Controller.text, emailController.text);
                      Navigator.push(context, MaterialPageRoute(builder: (context) => const ContactList()));
                    }

                )
            ),
          ],
        ),
      ),
    );
  }
}

void write(String name, String phone1, String phone2, String email) async {

  final prefs = await SharedPreferences.getInstance();
  final List<String> data = prefs.getStringList('data') ?? [];
  String contact = '{"name": "$name", "phone1": "$phone1", "phone2": "$phone2", "email": "${email}"}';
  data.add(contact);
  await prefs.setStringList('data', data);
}