import 'package:final_project_mobile/pages/profile_pages/student_profile_experiences.dart';
import 'package:final_project_mobile/pages/switch_account.dart';
import 'package:flutter/material.dart';
import 'package:multi_select_flutter/multi_select_flutter.dart';

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
  final _schoolTypes = ['Primary', 'Secondary', 'High School', 'University'];
  final _schools = <Map<String, String>>[];

  final _formKey = GlobalKey<FormState>();
  String _schoolType = 'Primary';
  String _schoolName = '';
  final String _studyTime = '';

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
        return AlertDialog(
          title: const Text('Add School'),
          content: Form(
            key: _formKey,
            child: Column(
              children: [
                DropdownButton<String>(
                  value: _schoolType,
                  onChanged: (String? newValue) {
                    _schoolType = newValue!;
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
                  onChanged: (value) => _schoolName = value,
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
                          startYear = newValue!;
                        },
                        items: yearList.map<DropdownMenuItem<int>>((int value) {
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
                          endYear = newValue!;
                          setState(() {
                            endYear = newValue;
                          });
                        },
                        items: yearList.map<DropdownMenuItem<int>>((int value) {
                          return DropdownMenuItem<int>(
                            value: value,
                            child: Text(value.toString()),
                          );
                        }).toList(),
                      ),
                    ),
                  ],
                ),
                // DropdownButton<int>(
                //   value: endYear,
                //   onChanged: (int? newValue) {
                //     endYear = newValue!;
                //   },
                //   items: yearList.map<DropdownMenuItem<int>>((int value) {
                //     return DropdownMenuItem<int>(
                //       value: value,
                //       child: Text(value.toString()),
                //     );
                //   }).toList(),
                // ),
              ],
            ),
          ),
          actions: [
            TextButton(
              onPressed: () {
                if (_formKey.currentState!.validate()) {
                  setState(() {
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
              title: Text(_schools[index]['name']!),
              subtitle: Text(
                  '${_schools[index]['type']} - ${_schools[index]['time']}'),
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
  static final List<Skill> _skills = [
    Skill(id: 1, name: 'iOS Development'),
    Skill(id: 2, name: 'C'),
    Skill(id: 3, name: 'Java'),
    Skill(id: 4, name: 'Kubernetes'),
    Skill(id: 5, name: 'PostgreSQL'),
    Skill(id: 6, name: 'Redis'),
    Skill(id: 7, name: 'Android'),
    Skill(id: 8, name: 'Node.js'),
    Skill(id: 9, name: 'Objective-C'),
    Skill(id: 10, name: 'React Native'),
    Skill(id: 11, name: 'Microservices'),
    Skill(id: 12, name: 'Socket.io'),
    Skill(id: 13, name: 'AWS'),
    Skill(id: 14, name: 'React'),
    Skill(id: 15, name: 'Git'),
    Skill(id: 16, name: 'WebScrape'),
    // Add all your skills here
  ];

  final _items = _skills
      .map((skill) => MultiSelectItem<Skill>(skill, skill.name))
      .toList();

  List<Skill> _selectedSkills = [];
  final _multiSelectKey = GlobalKey<FormFieldState>();

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
  ].map((language) => MultiSelectItem<String>(language, language)).toList();

  List<String> _selectedLanguages = [];
  String _selectedProficiency = 'Beginner';

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
                  Column(
                    children: [
                      const Padding(
                        padding: EdgeInsets.only(bottom: 10, top: 20),
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
                      MultiSelectDialogField(
                        key: _multiSelectKey,
                        onConfirm: (val) {
                          _selectedSkills = val;
                        },
                        items: _items,
                        initialValue: _selectedSkills,
                        searchable: true,
                        chipDisplay: MultiSelectChipDisplay<Skill>(
                          onTap: (value) {
                            setState(() {
                              _selectedSkills.remove(value);
                              _multiSelectKey.currentState
                                  ?.didChange(_selectedSkills);
                            });
                          },
                        ),
                      )
                    ],
                  ),

                  // Languages
                  Column(
                    children: [
                      const Padding(
                        padding: EdgeInsets.only(bottom: 10, top: 20),
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
                      MultiSelectDialogField<String>(
                        onConfirm: (values) {
                          setState(() {
                            _selectedLanguages = values;
                          });
                        },
                        items: _languages,
                        initialValue: _selectedLanguages,
                        searchable: true,
                        chipDisplay: MultiSelectChipDisplay<String>(
                          onTap: (value) {
                            setState(() {
                              _selectedLanguages.remove(value);
                            });
                          },
                        ),
                      ),
                      DropdownButton<String>(
                        value: _selectedProficiency,
                        onChanged: (String? newValue) {
                          setState(() {
                            _selectedProficiency = newValue!;
                          });
                        },
                        items: <String>[
                          'Beginner',
                          'Intermediate',
                          'Advanced',
                          'Native'
                        ].map<DropdownMenuItem<String>>((String value) {
                          return DropdownMenuItem<String>(
                            value: value,
                            child: Text(value),
                          );
                        }).toList(),
                      ),
                    ],
                  ),

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
