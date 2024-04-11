import 'package:final_project_mobile/components/custom_app_bar.dart';
import 'package:final_project_mobile/pages/login.dart';
import 'package:final_project_mobile/pages/sign_up.dart';
import 'package:flutter/material.dart';

class JoinAs extends StatelessWidget {
  const JoinAs({super.key});

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
                    const Text(
                      'Join as Company or Student',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 20),
                    const RadioExample(),
                    const SizedBox(height: 20),
                    ElevatedButton(
                      onPressed: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const SignUpPage()));
                      },
                      style: ButtonStyle(
                        shape: MaterialStateProperty.all(
                          RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(0),
                          ),
                        ),
                        foregroundColor: MaterialStateProperty.all(Colors.blue),
                      ),
                      child: const Text('Create Account'),
                    ),
                    Center(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Text('Already have an account?'),
                          const SizedBox(width: 10),
                          TextButton(
                            onPressed: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) =>
                                          const LoginScreen()));
                            },
                            style: ButtonStyle(
                              textStyle: MaterialStateProperty.all(
                                const TextStyle(
                                  decoration: TextDecoration.underline,
                                ),
                              ),
                            ),
                            child: const Text('Sign In'),
                          ),
                        ],
                      ),
                    )
                  ],
                ),
              ],
            )),
      ),
    );
  }
}

class RadioExample extends StatefulWidget {
  const RadioExample({super.key});

  @override
  State<RadioExample> createState() => _CompanyOrStudentRole();
}

enum RoleEnum { company, student }

class _CompanyOrStudentRole extends State<RadioExample> {
  RoleEnum? _role = RoleEnum.company;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Padding(
          padding:
              const EdgeInsets.only(bottom: 16.0), // Add space between boxes
          child: GestureDetector(
            onTap: () {
              setState(() {
                _role = RoleEnum.company;
              });
            },
            child: Container(
              decoration: BoxDecoration(
                border: Border.all(color: Colors.black), // Border
                borderRadius: BorderRadius.circular(8.0), // Rounded corners
              ),
              padding:
                  const EdgeInsets.all(16.0), // Padding inside the container
              child: Row(
                children: [
                  const Icon(Icons.people), // Icon of person
                  const SizedBox(width: 10), // Spacer between icon and text
                  const Expanded(
                    child: Text(
                      'I am a company, find engineer for project',
                      style: TextStyle(fontSize: 16.0),
                    ),
                  ),
                  Radio<RoleEnum>(
                    value: RoleEnum.company,
                    groupValue: _role,
                    onChanged: (RoleEnum? value) {
                      setState(() {
                        _role = value;
                      });
                    },
                  ),
                ],
              ),
            ),
          ),
        ),
        GestureDetector(
          onTap: () {
            setState(() {
              _role = RoleEnum.student;
            });
          },
          child: Container(
            decoration: BoxDecoration(
              border: Border.all(color: Colors.black), // Border
              borderRadius: BorderRadius.circular(8.0), // Rounded corners
            ),
            padding: const EdgeInsets.all(16.0), // Padding inside the container
            child: Row(
              children: [
                const Icon(Icons.person), // Icon of person
                const SizedBox(width: 10), // Spacer between icon and text
                const Expanded(
                  child: Text(
                    'I am a student, find project for doing',
                    style: TextStyle(fontSize: 16.0),
                  ),
                ),
                Radio<RoleEnum>(
                  value: RoleEnum.student,
                  groupValue: _role,
                  onChanged: (RoleEnum? value) {
                    setState(() {
                      _role = value;
                    });
                  },
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
