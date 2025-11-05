import 'package:flutter/material.dart';
import 'SQLHelper/contactdatabase.dart';
import 'home_screen.dart';
import 'settings.dart';


class ContactScreen extends StatefulWidget {
  const ContactScreen({super.key});


  @override
  State<ContactScreen> createState() => _ContactScreenState();
}


class _ContactScreenState extends State<ContactScreen> {
  List<Map<String, String>> contacts = [];


  @override
  void initState() {
    super.initState();
    _loadContacts();
  }


  void _loadContacts() {
    setState(() {
      contacts = DatabaseHelper.getContacts();
    });
  }


  void _showContactForm({String? name, String? email, String? contactNumber, int? index}) {
    final TextEditingController nameController = TextEditingController(text: name);
    final TextEditingController emailController = TextEditingController(text: email);
    final TextEditingController contactController = TextEditingController(text: contactNumber);


    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(index == null ? "Add Contact" : "Edit Contact"),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                controller: nameController,
                decoration: const InputDecoration(labelText: "Name"),
              ),
              TextField(
                controller: emailController,
                decoration: const InputDecoration(labelText: "Email"),
              ),
              TextField(
                controller: contactController,
                decoration: const InputDecoration(labelText: "Contact Number"),
                keyboardType: TextInputType.phone,
              ),
            ],
          ),
          actions: [
            TextButton(
              child: const Text("Cancel"),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              child: Text(index == null ? "Add" : "Save"),
              onPressed: () {
                if (index == null) {
                  DatabaseHelper.addContact(
                    nameController.text,
                    emailController.text,
                    contactController.text,
                  );
                } else {
                  DatabaseHelper.updateContact(
                    index,
                    nameController.text,
                    emailController.text,
                    contactController.text,
                  );
                }
                _loadContacts();
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }


  void _deleteContact(int index) {
    DatabaseHelper.deleteContact(index);
    _loadContacts();
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Contacts"),
        actions: [
          IconButton(
            icon: const Icon(Icons.add),
            onPressed: () {
              _showContactForm();
            },
          ),
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
          items:[
            BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
            BottomNavigationBarItem(
                icon: Icon(Icons.contacts), label: 'Contacts'),
            BottomNavigationBarItem(
                icon: Icon(Icons.settings), label: 'Settings'),
          ],
          onTap: (index) {
            switch (index) {
              case 0:
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => HomeScreen()),
                );
                break;
              case 1:
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => ContactScreen()),
                );
                break;
              case 2:
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => SettingsScreen()),
                );
                break;
            }
          }
      ),
      body: ListView.builder(
        itemCount: contacts.length,
        itemBuilder: (context, index) {
          final contact = contacts[index];
          return ListTile(
            leading: const Icon(Icons.person),
            title: Text(contact['name']!),
            subtitle: Text("Email: ${contact['email']}, Phone: ${contact['contactNumber']}"),
            trailing: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                IconButton(
                  icon: const Icon(Icons.edit),
                  onPressed: () {
                    _showContactForm(
                      name: contact['name'],
                      email: contact['email'],
                      contactNumber: contact['contactNumber'],
                      index: index,
                    );
                  },
                ),
                IconButton(
                  icon: const Icon(Icons.delete),
                  onPressed: () {
                    _deleteContact(index);
                  },
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}

