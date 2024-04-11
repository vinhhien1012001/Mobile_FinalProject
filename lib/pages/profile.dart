import 'package:final_project_mobile/widgets/custom_app_bar.dart';
import 'package:final_project_mobile/pages/switch_account.dart';
import 'package:final_project_mobile/pages/welcome.dart';
import 'package:flutter/material.dart';

class ProfileLoggedInPage extends StatelessWidget {
  const ProfileLoggedInPage({super.key});

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
                      'Welcome to Student Hub',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const Column(
                      children: [
                        Padding(
                          padding: EdgeInsets.only(bottom: 10, top: 30),
                          child: Align(
                            alignment: Alignment.centerLeft,
                            child: Text(
                              'Company name',
                              style: TextStyle(
                                fontSize: 15,
                              ),
                            ),
                          ),
                        ),
                        TextField(
                          decoration: InputDecoration(
                            border: OutlineInputBorder(),
                            contentPadding: EdgeInsets.symmetric(vertical: 5),
                          ),
                        ),
                      ],
                    ),
                    const Column(
                      children: [
                        Padding(
                          padding: EdgeInsets.only(bottom: 10, top: 20),
                          child: Align(
                            alignment: Alignment.centerLeft,
                            child: Text(
                              'Website',
                              style: TextStyle(
                                fontSize: 15,
                              ),
                            ),
                          ),
                        ),
                        TextField(
                          decoration: InputDecoration(
                            border: OutlineInputBorder(),
                            contentPadding: EdgeInsets.symmetric(vertical: 5),
                          ),
                        ),
                      ],
                    ),
                    const Column(
                      children: [
                        Padding(
                          padding: EdgeInsets.only(bottom: 10, top: 20),
                          child: Align(
                            alignment: Alignment.centerLeft,
                            child: Text(
                              'Description',
                              style: TextStyle(
                                fontSize: 15,
                              ),
                            ),
                          ),
                        ),
                        TextField(
                          decoration: InputDecoration(
                            border: OutlineInputBorder(),
                            contentPadding: EdgeInsets.symmetric(vertical: 5),
                          ),
                        ),
                      ],
                    ),
                    const Column(
                      children: [
                        Padding(
                          padding: EdgeInsets.only(bottom: 10, top: 20),
                          child: Align(
                            alignment: Alignment.centerLeft,
                            child: Text(
                              'How many people are in your company?',
                              style: TextStyle(
                                fontSize: 15,
                              ),
                            ),
                          ),
                        ),
                        SingleRadioButton(),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(right: 10),
                          child: SizedBox(
                            width: 100,
                            child: ElevatedButton(
                              onPressed: () {},
                              style: ButtonStyle(
                                shape: MaterialStateProperty.all(
                                  RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(0),
                                  ),
                                ),
                                foregroundColor:
                                    MaterialStateProperty.all(Colors.blue),
                              ),
                              child: const Text('Edit'),
                            ),
                          ),
                        ),
                        SizedBox(
                          width: 100,
                          child: ElevatedButton(
                            onPressed: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) =>
                                          const WelcomeScreen()));
                            },
                            style: ButtonStyle(
                              shape: MaterialStateProperty.all(
                                RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(0),
                                ),
                              ),
                              foregroundColor:
                                  MaterialStateProperty.all(Colors.blue),
                            ),
                            child: const Text('Cancel'),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ],
            )),
      ),
    );
  }
}

class ProfileNotLoggedInPage extends StatelessWidget {
  const ProfileNotLoggedInPage({super.key});

  AppBar appBar(BuildContext context) {
    return AppBar(
      title: const Text('StudentHub'),
      centerTitle: false,
      backgroundColor: Colors.blue,
      actions: <Widget>[
        IconButton(
          icon: const Icon(Icons.person),
          onPressed: () {
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => const SwitchAccountPage()));
          },
        ),
        //
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBar(context),
      body: Center(
        child: Padding(
            padding: const EdgeInsets.all(20),
            child: SingleChildScrollView(
              child: Column(
                children: [
                  const Text(
                    'Welcome to Student Hub',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const Column(
                    children: [
                      Padding(
                        padding: EdgeInsets.only(bottom: 10, top: 20),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Tell us about your company and you will be on your way connect with high-skilled students',
                              style: TextStyle(
                                fontSize: 15,
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.only(top: 20),
                              child: Text(
                                'How many people are in your company?',
                                style: TextStyle(
                                  fontSize: 15,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      RadioListTileExample(),
                    ],
                  ),
                  const Column(
                    children: [
                      Padding(
                        padding: EdgeInsets.only(bottom: 10, top: 10),
                        child: Align(
                          alignment: Alignment.centerLeft,
                          child: Text(
                            'Company name',
                            style: TextStyle(
                              fontSize: 15,
                            ),
                          ),
                        ),
                      ),
                      TextField(
                        decoration: InputDecoration(
                          border: OutlineInputBorder(),
                          contentPadding: EdgeInsets.symmetric(vertical: 5),
                        ),
                      ),
                    ],
                  ),
                  const Column(
                    children: [
                      Padding(
                        padding: EdgeInsets.only(bottom: 10, top: 20),
                        child: Align(
                          alignment: Alignment.centerLeft,
                          child: Text(
                            'Website',
                            style: TextStyle(
                              fontSize: 15,
                            ),
                          ),
                        ),
                      ),
                      TextField(
                        decoration: InputDecoration(
                          border: OutlineInputBorder(),
                          contentPadding: EdgeInsets.symmetric(vertical: 5),
                        ),
                      ),
                    ],
                  ),
                  const Column(
                    children: [
                      Padding(
                        padding: EdgeInsets.only(bottom: 10, top: 20),
                        child: Align(
                          alignment: Alignment.centerLeft,
                          child: Text(
                            'Description',
                            style: TextStyle(
                              fontSize: 15,
                            ),
                          ),
                        ),
                      ),
                      TextField(
                        decoration: InputDecoration(
                          border: OutlineInputBorder(),
                          contentPadding: EdgeInsets.symmetric(vertical: 25),
                        ),
                      ),
                    ],
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 20),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(right: 10),
                          child: SizedBox(
                            width: 140,
                            child: ElevatedButton(
                              onPressed: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            const WelcomeScreen()));
                              },
                              style: ButtonStyle(
                                shape: MaterialStateProperty.all(
                                  RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(0),
                                  ),
                                ),
                                foregroundColor:
                                    MaterialStateProperty.all(Colors.blue),
                              ),
                              child: const Text('Continue'),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            )),
      ),
    );
  }
}

class SingleRadioButton extends StatefulWidget {
  const SingleRadioButton({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _SingleRadioButtonState createState() => _SingleRadioButtonState();
}

class _SingleRadioButtonState extends State<SingleRadioButton> {
  bool _checkboxValue = false;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: const Text('It\'s just me!'),
      leading: Checkbox(
        checkColor: Colors.white,
        fillColor: MaterialStateProperty.resolveWith((states) {
          if (states.contains(MaterialState.selected)) {
            return Colors.blue;
          }
          return null; // Use the default value.
        }),
        value: _checkboxValue,
        shape: const CircleBorder(),
        onChanged: (bool? value) {
          setState(() {
            _checkboxValue = value!;
          });
        },
      ),
    );
  }
}

enum CompanySize { onlyMe, under10, under100, under1000, over1000 }

class RadioListTileExample extends StatefulWidget {
  const RadioListTileExample({super.key});

  @override
  State<RadioListTileExample> createState() => _RadioListTileExampleState();
}

class _RadioListTileExampleState extends State<RadioListTileExample> {
  CompanySize? _character = CompanySize.onlyMe;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        SizedBox(
          height: 40,
          child: RadioListTile<CompanySize>(
            title: const Text('It\'s just me!'),
            value: CompanySize.onlyMe,
            groupValue: _character,
            onChanged: (CompanySize? value) {
              setState(() {
                _character = value;
              });
            },
          ),
        ),
        SizedBox(
          height: 40,
          child: RadioListTile<CompanySize>(
            title: const Text('2-9 employees'),
            value: CompanySize.under10,
            groupValue: _character,
            onChanged: (CompanySize? value) {
              setState(() {
                _character = value;
              });
            },
          ),
        ),
        SizedBox(
          height: 40,
          child: RadioListTile<CompanySize>(
            title: const Text('10-99 employees'),
            value: CompanySize.under100,
            groupValue: _character,
            onChanged: (CompanySize? value) {
              setState(() {
                _character = value;
              });
            },
          ),
        ),
        SizedBox(
          height: 40,
          child: RadioListTile<CompanySize>(
            title: const Text('100-1000 employees'),
            value: CompanySize.under1000,
            groupValue: _character,
            onChanged: (CompanySize? value) {
              setState(() {
                _character = value;
              });
            },
          ),
        ),
        RadioListTile<CompanySize>(
          title: const Text('More than 1000 employees'),
          value: CompanySize.over1000,
          groupValue: _character,
          onChanged: (CompanySize? value) {
            setState(() {
              _character = value;
            });
          },
        ),
      ],
    );
  }
}
