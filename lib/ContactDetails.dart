import 'package:contacts_app/EditContact.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'ContactList.dart';

class ContactDetails extends StatefulWidget {
  final Map<String, dynamic> details;
  final int indx;
  const ContactDetails({Key? key, required this.details, required this.indx})
      : super(key: key);

  @override
  State<ContactDetails> createState() => _ContactDetailsState();
}

class _ContactDetailsState extends State<ContactDetails> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.details['name']),
        actions: [
          PopupMenuButton<String>(
            onSelected: handleClick,
            itemBuilder: (BuildContext context) {
              return {'Edit', 'Delete'}.map((String choice) {
                return PopupMenuItem<String>(
                  value: choice,
                  child: Text(choice),
                );
              }).toList();
            },
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(25),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              padding: const EdgeInsets.all(10),
              child: Text('Name: ${widget.details['name']}'),
            ),
            Container(
                padding: const EdgeInsets.fromLTRB(10, 10, 10, 0),
                child: Text('Personal Phone: ${widget.details['phone1']}')),
            Container(
              padding: const EdgeInsets.all(10),
              child: Text('Office Phone: ${widget.details['phone2']}'),
            ),
            Container(
                padding: const EdgeInsets.fromLTRB(10, 10, 10, 0),
                child: Text('Email: ${widget.details['email']}')),
          ],
        ),
      ),
    );
  }

  void handleClick(String value) {
    switch (value) {
      case 'Edit':
        Navigator.push(context, MaterialPageRoute(builder: (context) => EditContact(details: widget.details, index: widget.indx)));
        break;
      case 'Delete':
        deleteContact();
        Navigator.push(context, MaterialPageRoute(builder: (context) => const ContactList()));
        break;
    }
  }

  deleteContact() async {
    final prefs = await SharedPreferences.getInstance();
    final List<String> data = prefs.getStringList('data') ?? [];
    data.removeAt(widget.indx);
    await prefs.setStringList('data', data);
  }
}
