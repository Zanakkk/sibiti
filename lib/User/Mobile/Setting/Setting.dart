// ignore_for_file: file_names, library_private_types_in_public_api

import 'package:flutter/material.dart';

class SettingsPage extends StatefulWidget {
  const SettingsPage({super.key});

  @override
  _SettingsPageState createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  bool receiveNotifications = true;
  bool darkMode = false;
  bool autoPlayVideos = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('SETTING'),
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Card(
                color: Colors.black12,
                child: Padding(
                  padding: const EdgeInsets.all(8),
                  child: Column(
                    children: [
                      SwitchListTile(
                        inactiveThumbColor:
                            Theme.of(context).colorScheme.primary,
                        title: const Text('Receive Notifications'),
                        value: receiveNotifications,
                        onChanged: (newValue) {
                          setState(() {
                            receiveNotifications = newValue;
                          });
                        },
                      ),
                      SwitchListTile(
                        inactiveThumbColor:
                            Theme.of(context).colorScheme.primary,
                        title: const Text('Dark Mode'),
                        value: darkMode,
                        onChanged: (newValue) {
                          setState(() {
                            darkMode = newValue;
                            // You can add logic to change the theme here
                          });
                        },
                      ),
                      SwitchListTile(
                        inactiveThumbColor:
                            Theme.of(context).colorScheme.primary,
                        title: const Text('Auto-play Videos'),
                        value: autoPlayVideos,
                        onChanged: (newValue) {
                          setState(() {
                            autoPlayVideos = newValue;
                          });
                        },
                      ),
                    ],
                  ),
                )),
            const SizedBox(height: 20),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    'Language',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(width: 10),
                  DropdownButton<String>(
                    value:
                        'English', // Change this value based on the selected language
                    onChanged: (String? newValue) {
                      // Add logic to change language
                    },
                    items: <String>['English', 'Spanish', 'French', 'German']
                        .map<DropdownMenuItem<String>>((String value) {
                      return DropdownMenuItem<String>(
                        value: value,
                        child: Text(value),
                      );
                    }).toList(),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 20),
            SizedBox(
              width: double.infinity,
              height: 50,
              child: ElevatedButton(
                onPressed: () {
                  // Add logic to sign out
                },
                child: const Text('Sign Out'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
