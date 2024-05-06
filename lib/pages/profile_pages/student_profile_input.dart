import 'package:final_project_mobile/pages/profile_pages/student_profile_experiences.dart';
import 'package:final_project_mobile/pages/switch_account.dart';
import 'package:final_project_mobile/widgets/custom_multiselect.dart';
import 'package:flutter/material.dart';

class Skill {
  final int id;
  final String name;

  Skill({
    required this.id,
    required this.name,
  });
}

class EducationInput extends StatefulWidget {
  const EducationInput({super.key});

  @override
  _EducationInputState createState() => _EducationInputState();
}

class _EducationInputState extends State<EducationInput> {
  final _schoolTypes = [
    'Primary School',
    'Secondary School',
    'High School',
    'University'
  ];
  final _schools = <Map<String, String>>[];

  final _formKey = GlobalKey<FormState>();
  String _schoolType = 'Primary School';
  String _schoolName = '';
  int currentYear = DateTime.now().year;
  List<int> yearList = [];

  _EducationInputState() {
    int currentYear = DateTime.now().year;
    yearList = [for (var i = 1900; i <= currentYear; i++) i];
  }

  int startYear = DateTime.now().year;
  int endYear = DateTime.now().year;

  void _addSchool() {
    showDialog(
      context: context,
      builder: (context) {
        return StatefulBuilder(
          builder: (BuildContext context, StateSetter setState) {
            return AlertDialog(
              contentPadding: const EdgeInsets.all(16),
              title: const Text('Add School'),
              content: SizedBox(
                width: MediaQuery.of(context).size.width * 0.9,
                height: MediaQuery.of(context).size.height * 0.3,
                child: Form(
                  key: _formKey,
                  child: Column(
                    children: [
                      DropdownButton<String>(
                        value: _schoolType,
                        onChanged: (String? newValue) {
                          setState(() {
                            _schoolType = newValue!;
                          });
                        },
                        items: _schoolTypes
                            .map<DropdownMenuItem<String>>((String value) {
                          return DropdownMenuItem<String>(
                            value: value,
                            child: Text(value),
                          );
                        }).toList(),
                      ),
                      TextFormField(
                        onChanged: (value) {
                          setState(() {
                            _schoolName = value;
                          });
                        },
                        decoration: const InputDecoration(
                          labelText: 'School Name',
                        ),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Align(
                            alignment: Alignment.centerLeft,
                            child: Text(
                              'Start Year',
                              style: TextStyle(
                                fontSize: 15,
                              ),
                            ),
                          ),
                          Align(
                            child: DropdownButton<int>(
                              value: startYear,
                              onChanged: (int? newValue) {
                                if (newValue! <= endYear) {
                                  setState(() {
                                    startYear = newValue;
                                  });
                                }
                              },
                              items: yearList
                                  .map<DropdownMenuItem<int>>((int value) {
                                return DropdownMenuItem<int>(
                                  value: value,
                                  child: Text(value.toString()),
                                );
                              }).toList(),
                            ),
                          ),
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Align(
                            alignment: Alignment.centerLeft,
                            child: Text(
                              'End Year',
                              style: TextStyle(
                                fontSize: 15,
                              ),
                            ),
                          ),
                          Align(
                            child: DropdownButton<int>(
                              value: endYear,
                              onChanged: (int? newValue) {
                                if (newValue! >= startYear) {
                                  setState(() {
                                    endYear = newValue;
                                  });
                                }
                              },
                              items: yearList
                                  .map<DropdownMenuItem<int>>((int value) {
                                return DropdownMenuItem<int>(
                                  value: value,
                                  child: Text(value.toString()),
                                );
                              }).toList(),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
              actions: [
                TextButton(
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      this.setState(() {
                        _schools.add({
                          'type': _schoolType,
                          'name': _schoolName,
                          'time': '$startYear - $endYear',
                        });
                      });
                      Navigator.of(context).pop();
                    }
                  },
                  child: const Text('Save'),
                ),
              ],
            );
          },
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Padding(
              padding: EdgeInsets.only(bottom: 10, top: 20),
              child: Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  'Education',
                  style: TextStyle(
                    fontSize: 15,
                  ),
                ),
              ),
            ),
            IconButton(
              onPressed: _addSchool,
              icon: const Icon(Icons.add_outlined),
            ),
          ],
        ),
        ListView.builder(
          shrinkWrap: true,
          itemCount: _schools.length,
          itemBuilder: (context, index) {
            return ListTile(
              title: Text(
                  '${_schools[index]['name']!} - ${_schools[index]['type']}'),
              subtitle: Text('${_schools[index]['time']}'),
            );
          },
        ),
      ],
    );
  }
}

class LanguageInput extends StatefulWidget {
  const LanguageInput({super.key});

  @override
  _LanguageInputState createState() => _LanguageInputState();
}

class _LanguageInputState extends State<LanguageInput> {
  final _languageLevels = ['Beginner', 'Intermediate', 'Advanced', 'Native'];
  final _languages = [
    'English',
    'Spanish',
    'French',
    'German',
    'Chinese',
    'Japanese',
    'Korean',
    'Russian',
    'Arabic',
    'Portuguese',
    'Italian',
    'Dutch',
    'Turkish',
    'Polish',
    'Swedish',
    'Danish',
    'Vietnamese',
    // Add all your languages here
  ];
  String _languageLevel = 'Beginner';
  String _language = 'Vietnamese';
  final _selectedLanguages = <Map<String, String>>[];
  final _formKey = GlobalKey<FormState>();

  // void _addLanguage() {}

  void _addLanguage() {
    showDialog(
      context: context,
      builder: (context) {
        return StatefulBuilder(
          builder: (BuildContext context, StateSetter setState) {
            return AlertDialog(
              contentPadding: const EdgeInsets.all(16),
              title: const Text('Add Language'),
              content: SizedBox(
                width: MediaQuery.of(context).size.width * 0.9,
                height: MediaQuery.of(context).size.height * 0.3,
                child: Form(
                  key: _formKey,
                  child: Column(
                    children: [
                      Column(
                        children: [
                          const Padding(
                            padding:
                                EdgeInsets.only(bottom: 10, top: 5, right: 15),
                            child: Align(
                              alignment: Alignment.centerLeft,
                              child: Text(
                                'Language:',
                                style: TextStyle(
                                    fontSize: 17, fontWeight: FontWeight.w500),
                              ),
                            ),
                          ),
                          DropdownButton<String>(
                            value: _language,
                            onChanged: (String? newValue) {
                              setState(() {
                                _language = newValue!;
                              });
                            },
                            items: _languages
                                .map<DropdownMenuItem<String>>((String value) {
                              return DropdownMenuItem<String>(
                                value: value,
                                child: Text(value),
                              );
                            }).toList(),
                          ),
                        ],
                      ),
                      Column(
                        children: [
                          const Padding(
                            padding:
                                EdgeInsets.only(bottom: 10, top: 5, right: 15),
                            child: Align(
                              alignment: Alignment.centerLeft,
                              child: Text(
                                'Level:',
                                style: TextStyle(
                                    fontSize: 17, fontWeight: FontWeight.w500),
                              ),
                            ),
                          ),
                          DropdownButton<String>(
                            value: _languageLevel,
                            onChanged: (String? newValue) {
                              setState(() {
                                _languageLevel = newValue!;
                              });
                            },
                            items: _languageLevels
                                .map<DropdownMenuItem<String>>((String value) {
                              return DropdownMenuItem<String>(
                                value: value,
                                child: Text(value),
                              );
                            }).toList(),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
              actions: [
                TextButton(
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      this.setState(() {
                        _selectedLanguages.add({
                          'level': _languageLevel,
                          'name': _language,
                        });
                      });
                      Navigator.of(context).pop();
                    }
                  },
                  child: const Text('Save'),
                ),
              ],
            );
          },
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Padding(
              padding: EdgeInsets.only(bottom: 0, top: 0),
              child: Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  'Languages',
                  style: TextStyle(
                    fontSize: 15,
                  ),
                ),
              ),
            ),
            IconButton(
              onPressed: _addLanguage,
              icon: const Icon(Icons.add_outlined),
            ),
          ],
        ),
        ListView.builder(
          shrinkWrap: true,
          itemCount: _selectedLanguages.length,
          itemBuilder: (context, index) {
            return ListTile(
              title: Text(_selectedLanguages[index]['name']!),
              subtitle: Text('${_selectedLanguages[index]['level']}'),
            );
          },
        ),
      ],
    );
  }
}

void main() {
  runApp(const StudentProfileInputPage());
}

class StudentProfileInputPage extends StatefulWidget {
  const StudentProfileInputPage({super.key});

  @override
  State<StudentProfileInputPage> createState() => StudentProfileInputState();
}

class StudentProfileInputState extends State<StudentProfileInputPage> {
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
                              'Tell us about your self and you will be on your way connect with real-world project',
                              style: TextStyle(
                                fontSize: 15,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  // Techstack
                  Column(
                    children: [
                      const Padding(
                        padding: EdgeInsets.only(bottom: 10, top: 10),
                        child: Align(
                          alignment: Alignment.centerLeft,
                          child: Text(
                            'Techstack',
                            style: TextStyle(
                              fontSize: 15,
                            ),
                          ),
                        ),
                      ),
                      DropdownButtonFormField<String>(
                        decoration: const InputDecoration(
                            labelText: 'Select your role'),
                        items: <String>[
                          'Fullstack Engineer',
                          'Frontend Engineer',
                          'Backend Engineer',
                          'DevOps Engineer',
                          'Data Scientist',
                          'Mobile Developer',
                          'Machine Learning Engineer',
                          'Security Engineer',
                          'Game Developer',
                          'Cloud Engineer',
                        ].map<DropdownMenuItem<String>>((String value) {
                          return DropdownMenuItem<String>(
                            value: value,
                            child: Text(value),
                          );
                        }).toList(),
                        onChanged: (String? newValue) {
                          // Do something with the selected value
                        },
                        validator: (String? value) {
                          if (value == null || value.isEmpty) {
                            return 'Please select your role';
                          }
                          return null;
                        },
                      ),
                    ],
                  ),

                  // Skillset
                  const Column(
                    children: [
                      Padding(
                        padding: EdgeInsets.only(bottom: 0, top: 20),
                        child: Align(
                          alignment: Alignment.centerLeft,
                          child: Text(
                            'Skillset',
                            style: TextStyle(
                              fontSize: 15,
                            ),
                          ),
                        ),
                      ),
                      MutiselectDropdown()
                    ],
                  ),

                  // Languages
                  const LanguageInput(),

                  // Education part
                  const EducationInput(),

                  // Continue button
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
                                            const StudentProfileExperiencePage()));
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
                              child: const Text('Next'),
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
