import 'package:final_project_mobile/components/custom_app_bar.dart';
import 'package:final_project_mobile/pages/dashboard.dart';
import 'package:flutter/material.dart';

class WelcomeScreen extends StatelessWidget {
  const WelcomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(),
      body: Center(
        child: Padding(
            padding: const EdgeInsets.all(20),
            child: Stack(
              children: [
                Column(
                  children: [
                    const Padding(
                      padding: EdgeInsets.only(top: 20),
                      child: Icon(
                        Icons.favorite,
                        color: Colors.pink,
                        size: 40.0,
                      ),
                    ),
                    const Padding(
                      padding: EdgeInsets.only(top: 30, bottom: 30),
                      child: Center(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Text(
                              'Welcome, Hai!',
                              style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            Text(
                              'Let\'s start with your first project post.',
                              style: TextStyle(
                                fontSize: 16,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    ElevatedButton(
                      onPressed: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const DashboardScreen()));
                      },
                      style: ButtonStyle(
                        shape: MaterialStateProperty.all(
                          RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(0),
                          ),
                        ),
                        foregroundColor: MaterialStateProperty.all(Colors.blue),
                      ),
                      child: const Text('Get started'),
                    ),
                  ],
                ),
              ],
            )),
      ),
    );
  }
}
