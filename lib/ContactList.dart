import 'dart:convert';
import 'package:contacts_app/LogIn.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'AddToContactsForm.dart';
import 'ContactDetails.dart';

class ContactList extends StatefulWidget {
  const ContactList({Key? key}) : super(key: key);

  @override
  State<ContactList> createState() => _ContactListState();
}

class _ContactListState extends State<ContactList> {

  var _contacts = [];
  List<Map<String, dynamic>> contactList = [];

  getContacts() async{
    final prefs = await SharedPreferences.getInstance();
    final List<String> data = prefs.getStringList('data') ?? [];

    for (var element in data) {
      Map<String, dynamic> temp = jsonDecode(element);
      contactList.add(temp);
    }

    setState(() {
      _contacts = contactList;
    });
  }

  @override
  void initState() {
    super.initState();
    getContacts();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(

      appBar: AppBar(
        title: Text('${_contacts.length} Contacts', textAlign: TextAlign.right,),
        actions: [
          IconButton(
            icon: const Icon(
              Icons.logout,
              color: Colors.white,
            ),
            onPressed: (){
              logOut();
              Navigator.push(context, MaterialPageRoute(builder: (context) => const LogInForm()));
            },
          )
        ],
      ),
      body: Column(
        children: [
          Container(
            padding: const EdgeInsets.all(2),
            margin: const EdgeInsets.all(5),
            child: TextField(
              decoration: const InputDecoration(
                border: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular((25)))),
                prefix: Icon(Icons.search),
                labelText: 'Search',
              ),
              onChanged: (value) {
                filterContact(value.toLowerCase());
              },
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemBuilder: (context, index) {
                return Card(
                  elevation: 2.0,
                  shape: RoundedRectangleBorder(
                      side: const BorderSide(color: Colors.white70, width: 1),
                      borderRadius: BorderRadius.circular(10)
                  ),
                  child: InkWell(
                    onTap: () {
                      Navigator.push(context, MaterialPageRoute(builder: (context) => ContactDetails(details: _contacts[index], indx: index)));
                    },
                    child: Container(
                      margin: const EdgeInsets.all(9.0),
                      padding: const EdgeInsets.all(6.0),
                      child: Row(
                        children: [
                          CircleAvatar(
                            backgroundColor: const Color(0xff00695c),
                            foregroundColor: Colors.white,
                            child: Text(_contacts[index]['name'][0]),
                          ),
                          const Padding(padding: EdgeInsets.all(6.0)),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                _contacts[index]['name'],
                                style: const TextStyle(fontSize: 20.0),
                              ),
                              Text(
                                _contacts[index]['phone1'],
                                style: const TextStyle(fontSize: 18.0, color: Colors.green),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              },
              itemCount: _contacts.length,
            ),
          )
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(context, MaterialPageRoute(builder: (context) => AddToContacts()));
        },
        child: const Icon(Icons.add),
      ),
    );
  }

  void filterContact(String searchTerm){
    var tempSearchList = [];
    tempSearchList.addAll(contactList);

    if(searchTerm.isNotEmpty){

      List<Map<String, dynamic>> tempList = [];
      for (var element in tempSearchList) {
        if(element['name'].toLowerCase().contains(searchTerm.trim())){
          tempList.add(element);
        }
      }

      setState(() {
        _contacts = tempList;
      });
      return;
    }
    else{
      setState(() {
        _contacts = contactList;
      });
      return;
    }
  }

  void logOut() async{
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool('loggedIn', false);
  }
}