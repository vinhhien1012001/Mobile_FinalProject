import 'package:final_project_mobile/features/default/bloc/default_bloc.dart';
import 'package:final_project_mobile/features/default/bloc/default_event.dart';
import 'package:final_project_mobile/models/user_profile.dart';
import 'package:final_project_mobile/routes/routes.dart';
import 'package:final_project_mobile/widgets/custom_app_bar.dart';
import 'package:final_project_mobile/pages/switch_account.dart';
import 'package:final_project_mobile/pages/welcome.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:toastification/toastification.dart';

class ProfileLoggedInPage extends StatelessWidget {
  const ProfileLoggedInPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const AppBarBack(),
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
                              Navigator.pushNamed(context, Routes.welcome);
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

// COMPANY CREATE NEW PROFILE
class ProfileCompanyCreatePage extends StatefulWidget {
  const ProfileCompanyCreatePage({super.key});

  @override
  State<ProfileCompanyCreatePage> createState() =>
      _ProfileCompanyCreatePageState();
}

class _ProfileCompanyCreatePageState extends State<ProfileCompanyCreatePage> {
  TextEditingController sizeController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();
  TextEditingController nameController = TextEditingController();
  TextEditingController websiteController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocListener<DefaultBloc, DefaultState>(
      listener: (context, state) {
        if (state is CreateCompanyProfileSuccess) {
          print('CREATE PROFILE SUCCESS STATE');
          toastification.show(
            context: context,
            type: ToastificationType.success,
            style: ToastificationStyle.flat,
            title: const Text(
              'Create company profile success!',
              style: TextStyle(fontSize: 16),
            ),
            alignment: Alignment.topCenter,
            autoCloseDuration: const Duration(seconds: 6),
            icon: const Icon(Icons.check, size: 40),
            borderRadius: BorderRadius.circular(12.0),
            showProgressBar: true,
          );
          // Navigator.pushReplacement(
          //   context,
          //   MaterialPageRoute(builder: (context) => const WelcomeScreen()),
          // );
          Navigator.pushNamed(context, Routes.welcome);
        } else if (state is CreateProfileFailure) {
          print('ERROR: ${state.error}');
          toastification.show(
            context: context,
            type: ToastificationType.error,
            style: ToastificationStyle.flat,
            title: Text(
              'CREATE COMPANY ACCOUNT failed!  ${state.error.toString().replaceFirst('Exception: ', '')}',
              style:
                  const TextStyle(fontSize: 16), // Increase the font size here
            ),
            alignment: Alignment.topCenter,
            autoCloseDuration: const Duration(seconds: 4),
            icon: const Icon(Icons.error,
                size: 40), // Increase the icon size here
            borderRadius: BorderRadius.circular(12.0),
            showProgressBar: true,
          );
        }
      },
      child: Scaffold(
        appBar: const AppBarBack(),
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

                    // SIZE
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

                    // COMPANY NAME
                    Column(
                      children: [
                        const Padding(
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
                          decoration: const InputDecoration(
                            border: OutlineInputBorder(),
                            contentPadding: EdgeInsets.symmetric(vertical: 5),
                          ),
                          onChanged: (value) {
                            nameController.text = value;
                          },
                        ),
                      ],
                    ),

                    // WEBSITE
                    Column(
                      children: [
                        const Padding(
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
                          decoration: const InputDecoration(
                            border: OutlineInputBorder(),
                            contentPadding: EdgeInsets.symmetric(vertical: 5),
                          ),
                          onChanged: (value) {
                            websiteController.text = value;
                          },
                        ),
                      ],
                    ),

                    // DESCRIPTION
                    Column(
                      children: [
                        const Padding(
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
                          decoration: const InputDecoration(
                            border: OutlineInputBorder(),
                            contentPadding: EdgeInsets.symmetric(vertical: 25),
                          ),
                          onChanged: (value) {
                            descriptionController.text = value;
                          },
                        ),
                      ],
                    ),

                    // SUBMIT BUTTON
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
                                  if (nameController.text.isEmpty ||
                                      descriptionController.text.isEmpty ||
                                      websiteController.text.isEmpty) {
                                    ScaffoldMessenger.of(context).showSnackBar(
                                      const SnackBar(
                                          content: Text(
                                              'Please fill in all fields')),
                                    );
                                  } else {
                                    context
                                        .read<DefaultBloc>()
                                        .add(CreateCompanyProfile(
                                            company: Company(
                                          companyName: nameController.text,
                                          website: websiteController.text,
                                          size: 3,
                                          description:
                                              descriptionController.text,
                                        )));
                                  }
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
