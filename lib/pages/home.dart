import 'package:final_project_mobile/routes/routes.dart';
import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: appBar,
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          // Center the text
          Center(
            child: Column(
              children: [
                pageTitle(),
                // Text
                const Padding(
                  padding: EdgeInsets.only(left: 20, right: 20),
                  child: Text(
                    'Find and onboard best-skilled student for your product. Student works to gain experience & skills from real-world project',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.normal,
                    ),
                  ),
                ),
                // 2 buttons here
                loginAsButtons(
                  context,
                ),
                // Last text
                const Padding(
                  padding: EdgeInsets.only(left: 20, right: 20),
                  child: Text(
                    'StudentHub is university market place to connect high-skilled student and company on real-world project',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.normal,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Padding pageTitle() {
    return const Padding(
      padding: EdgeInsets.only(top: 40, bottom: 40),
      child: Text(
        'Build your product with high-skilled student',
        style: TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }

  Padding loginAsButtons(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 20, bottom: 20),
      child: Column(
        children: [
          SizedBox(
            width: 120,
            child: ElevatedButton(
              onPressed: () {
                Navigator.pushNamed(context, Routes.login);
              },
              style: ButtonStyle(
                shape: MaterialStateProperty.all(
                  RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(0),
                  ),
                ),
                foregroundColor: MaterialStateProperty.all(Colors.blue),
              ),
              child: const Text('Company'),
            ),
          ),
          const SizedBox(height: 20),
          SizedBox(
            width: 120,
            child: ElevatedButton(
              onPressed: () {
                Navigator.pushNamed(context, Routes.login);
              },
              style: ButtonStyle(
                shape: MaterialStateProperty.all(
                  RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(0),
                  ),
                ),
                foregroundColor: MaterialStateProperty.all(Colors.blue),
              ),
              child: const Text('Student'),
            ),
          ),
        ],
      ),
    );
  }
}
