import 'package:flutter/material.dart';

class SettingsPage extends StatelessWidget {
  const SettingsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Settings'),
      ),
      body: ListView(
        children: const [
          ListTile(
            leading: CircleAvatar(
              // Replace with your profile icon
              backgroundImage: AssetImage('assets/profile_icon.png'),
            ),
            title: Text('John Doe'),
            subtitle: Text('john.doe@example.com'),
          ),
          Divider(),
          ListTile(
            title: Text('Display'),
          ),
          Divider(),
          ListTile(
            title: Text('Security'),
          ),
          Divider(),
          ListTile(
            title: Text('Privacy'),
          ),
        ],
      ),
    );
  }
}
