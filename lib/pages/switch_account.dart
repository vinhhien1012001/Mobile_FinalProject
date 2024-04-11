import 'package:final_project_mobile/widgets/custom_app_bar.dart';
import 'package:final_project_mobile/pages/profile.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const SwitchAccountPage());
}

class SwitchAccountPage extends StatefulWidget {
  const SwitchAccountPage({super.key});

  @override
  State<SwitchAccountPage> createState() => _SwitchAccountPageState();
}

class _SwitchAccountPageState extends State<SwitchAccountPage> {
  String _selectedAccount = 'Account 1';
  final List<Map<String, dynamic>> _accounts = [
    {'name': 'Account 1', 'icon': Icons.account_circle},
    {'name': 'Account 2', 'icon': Icons.account_circle},
    {'name': 'Account 3', 'icon': Icons.account_circle},
  ];

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: const CustomAppBar(),
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Container(
              padding: const EdgeInsets.all(16.0),
              decoration: const BoxDecoration(
                border: Border(
                  bottom: BorderSide(
                    color: Colors.grey,
                    width: 1.0,
                  ),
                ),
              ),
              child: DropdownButtonFormField<Map<String, dynamic>>(
                value: _accounts[0],
                items: _accounts.map((account) {
                  return DropdownMenuItem<Map<String, dynamic>>(
                    value: account,
                    child: Row(
                      children: [
                        Icon(account['icon']),
                        const SizedBox(width: 10),
                        Text(account['name']),
                      ],
                    ),
                  );
                }).toList(),
                onChanged: (Map<String, dynamic>? newValue) {
                  setState(() {
                    _selectedAccount = newValue!['name'];
                  });
                },
              ),
            ),
            ElevatedButton.icon(
              onPressed: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const ProfileNotLoggedInPage()));
              },
              icon: const Icon(Icons.account_circle),
              label: const Text('Profiles'),
              style: ElevatedButton.styleFrom(
                foregroundColor: Colors.white,
                backgroundColor: Colors.blue, // Background color
                padding: const EdgeInsets.all(12.0), // Button padding
                alignment: Alignment.centerLeft,
                shape: const RoundedRectangleBorder(), // Button border
              ),
            ),
            ElevatedButton.icon(
              onPressed: () {},
              icon: const Icon(Icons.settings),
              label: const Text('Settings'),
              style: ElevatedButton.styleFrom(
                foregroundColor: Colors.white,
                backgroundColor: Colors.green, // Background color
                padding: const EdgeInsets.all(12.0), // Button padding
                alignment: Alignment.centerLeft,
                shape: const RoundedRectangleBorder(), // Button border
              ),
            ),
            ElevatedButton.icon(
              onPressed: () {},
              icon: const Icon(Icons.logout),
              label: const Text('Logout'),
              style: ElevatedButton.styleFrom(
                foregroundColor: Colors.white,
                backgroundColor: Colors.red, // Background color
                padding: const EdgeInsets.all(12.0), // Button padding
                alignment: Alignment.centerLeft,
                shape: const RoundedRectangleBorder(), // Button border
              ),
            ),
          ],
        ),
      ),
    );
  }
}
