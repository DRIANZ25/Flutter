import 'package:flutter/material.dart';
import 'SQLHelper/dbHelper.dart';
import 'home_screen.dart';
import 'settings.dart';


class ListofUsersHome extends StatefulWidget {
  const ListofUsersHome({super.key});


  @override
  State<ListofUsersHome> createState() => _ListofUsersHomeState();
}


class _ListofUsersHomeState extends State<ListofUsersHome> {
  DatabaseHelper dbHelper = DatabaseHelper();
  List<Map<String, dynamic>> listofUsers = [];


  var firstNameController = TextEditingController();
  var middleNameController = TextEditingController();
  var lastNameController = TextEditingController();
  var emailController = TextEditingController();
  var passwordController = TextEditingController();


  int idToEdit = 0;


  @override
  void initState() {
    super.initState();
    getUser();
  }


  Future<void> getUser() async {
    final data = await dbHelper.getUsers();
    setState(() {
      listofUsers = data;
    });
  }


  Future<void> updateUser() async {
    showModalBottomSheet(
      context: context,
      builder: (BuildContext ctx) {
        return Padding(
          padding: const EdgeInsets.all(16.0),
          child: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                buildTextField('First Name', firstNameController),
                buildTextField('Middle Name', middleNameController),
                buildTextField('Last Name', lastNameController),
                buildTextField('Email', emailController),
                buildTextField('Password', passwordController),
                const SizedBox(height: 16),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFFF59E0B),
                  ),
                  onPressed: () async {
                    if (idToEdit > 0) {
                      final result = await dbHelper.updateUser(
                        firstNameController.text,
                        middleNameController.text,
                        lastNameController.text,
                        emailController.text,
                        passwordController.text,
                        idToEdit,
                      );
                      if (result > 0) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                              content: Text("User updated successfully!")),
                        );
                        getUser();
                        Navigator.pop(context);
                      } else {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                              content: Text("Failed to update user!")),
                        );
                      }
                    }
                  },
                  child: const Text('Update User'),
                ),
              ],
            ),
          ),
        );
      },
    );
  }


  Widget buildTextField(String label, TextEditingController controller) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: TextField(
        controller: controller,
        decoration: InputDecoration(
          labelText: label,
          labelStyle: const TextStyle(color: Color(0xFF1E3A8A)),
          border: const OutlineInputBorder(),
          focusedBorder: const OutlineInputBorder(
            borderSide: BorderSide(color: Color(0xFF1E3A8A)),
          ),
        ),
      ),
    );
  }


  void deleteUser(int id) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        backgroundColor: const Color(0xFFF3F4F6),
        title: const Text('Delete User',
            style: TextStyle(color: Color(0xFF1E3A8A))),
        content: const Text('Are you sure you want to delete this user?',
            style: TextStyle(color: Color(0xFF1E3A8A))),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancel',
                style: TextStyle(color: Color(0xFFF59E0B))),
          ),
          TextButton(
            onPressed: () async {
              final result = await dbHelper.deleteUser(id);
              if (result > 0) {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text("User deleted successfully!")),
                );
                getUser();
              } else {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text("Failed to delete user!")),
                );
              }
              Navigator.pop(context);
            },
            child: const Text('Delete',
                style: TextStyle(color: Color(0xFFF59E0B))),
          ),
        ],
      ),
    );
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('List of Users'),
        backgroundColor: const Color(0xFF0296FF),
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
                  MaterialPageRoute(builder: (context) => ListofUsersHome()),
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
      body: listofUsers.isEmpty
          ? const Center(
          child: Text('No users found',
              style: TextStyle(color: Color(0xFF1E3A8A)))
      )
          : ListView.builder(
        itemCount: listofUsers.length,
        itemBuilder: (context, index) {
          var user = listofUsers[index];
          return Card(
            color: const Color(0xFFF3F4F6),
            child: ListTile(
              leading: const Icon(Icons.person, color: Color(0xFFF59E0B)),
              title: Text(
                '${user['lastName']}, ${user['firstName']} ${user['middleName']}',
                style: const TextStyle(color: Color(0xFF1E3A8A)),
              ),
              subtitle: Text(user['email'],
                  style: const TextStyle(color: Color(0xFF1E3A8A))),
              trailing: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  IconButton(
                    icon: const Icon(Icons.edit,
                        color: Color(0xFFF59E0B)),
                    onPressed: () {
                      firstNameController.text = user['firstName'];
                      middleNameController.text = user['middleName'];
                      lastNameController.text = user['lastName'];
                      emailController.text = user['email'];
                      passwordController.text = user['password'];
                      setState(() {
                        idToEdit = user['id'];
                      });
                      updateUser();
                    },
                  ),
                  IconButton(
                    icon: const Icon(Icons.delete,
                        color: Color(0xFFF59E0B)),
                    onPressed: () => deleteUser(user['id']),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}

