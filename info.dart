import 'package:flutter/material.dart';

class InfoScreen extends StatelessWidget {
  final List<Map<String, String>> teamMembers = [
    {
      'name': 'Fairah Alang',
      'position': 'Web App Dev',
      'hobbies': 'Procrastinate',
    },
    {
      'name': 'Jarry Garzon',
      'position': '',
      'hobbies': 'Playing Games',
    },
    {
      'name': 'Lance',
      'position': '',
      'hobbies': 'Playing Games',
    },
    {
      'name': 'Mark',
      'position': '',
      'hobbies': 'Playing Roblox',
    },
    {
      'name': 'Orpilla',
      'position': '',
      'hobbies': 'Always Late',
    },
    {
      'name': 'Pasilan',
      'position': '',
      'hobbies': 'Playing Games',
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('About Team'),
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: ListView.builder(
        padding: EdgeInsets.all(16),
        itemCount: teamMembers.length,
        itemBuilder: (context, index) {
          final member = teamMembers[index];
          return Card(
            margin: EdgeInsets.symmetric(vertical: 8),
            elevation: 3,
            shape:
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
            child: ListTile(
              leading: Icon(
                Icons.person,
                color: member['position'] == 'Web App Dev'
                    ? Colors.blue
                    : Colors.grey,
                size: 40,
              ),
              title: Text(
                member['name']!,
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 18,
                ),
              ),
              subtitle: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  if (member['position']!.isNotEmpty)
                    Text(
                      member['position']!,
                      style: TextStyle(color: Colors.blue),
                    ),
                  Text('Hobbies: ${member['hobbies']}'),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
