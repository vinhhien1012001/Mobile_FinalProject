import 'package:final_project_mobile/pages/profile_pages/student_profile_cv.dart';
import 'package:final_project_mobile/pages/switch_account.dart';
import 'package:final_project_mobile/pages/welcome.dart';
import 'package:final_project_mobile/routes/routes.dart';
import 'package:final_project_mobile/widgets/custom_app_bar.dart';
import 'package:flutter/material.dart';
import 'package:multi_dropdown/multiselect_dropdown.dart';

class Skill {
  final String name;

  Skill({
    required this.name,
  });

  @override
  String toString() {
    return 'Skill(name: $name)';
  }
}

// SKILL SET INPUT
class SkillsetDropdown extends StatefulWidget {
  const SkillsetDropdown({super.key});

  @override
  State<SkillsetDropdown> createState() => _SkillsetDropdownState();

  static const _headerStyle = TextStyle(
    fontSize: 12,
    color: Colors.blue,
  );
}

class _SkillsetDropdownState extends State<SkillsetDropdown> {
  final MultiSelectController<String> _controller = MultiSelectController();

  final List<ValueItem<String>> _selectedOptions = [];

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8),
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            MultiSelectDropDown<String>(
              controller: _controller,
              clearIcon: const Icon(Icons.reddit),
              onOptionSelected: (options) {},
              options: [
                Skill(name: 'iOS Development'),
                Skill(name: 'C'),
                Skill(name: 'Java'),
                Skill(name: 'Kubernetes'),
                Skill(name: 'PostgreSQL'),
                Skill(name: 'Redis'),
                Skill(name: 'Android'),
                Skill(name: 'Node.js'),
                Skill(name: 'Objective-C'),
                Skill(name: 'React Native'),
                Skill(name: 'Microservices'),
                Skill(name: 'Socket.io'),
                Skill(name: 'AWS'),
                Skill(name: 'React'),
                Skill(name: 'Git'),
                Skill(name: 'WebScrape'),
              ]
                  .map((skill) =>
                      ValueItem<String>(label: skill.name, value: skill.name))
                  .toList(),
              // maxItems: 4,
              singleSelectItemStyle:
                  const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              chipConfig: const ChipConfig(
                  wrapType: WrapType.wrap, backgroundColor: Colors.blue),
              optionTextStyle: const TextStyle(fontSize: 16),
              selectedOptionIcon: const Icon(
                Icons.check_circle,
                color: Colors.pink,
              ),
              searchEnabled: true,
              selectedOptionBackgroundColor: Colors.grey.shade300,
              selectedOptionTextColor: Colors.blue,
              dropdownMargin: 2,
              onOptionRemoved: (index, option) {},
              optionBuilder: (context, valueItem, isSelected) {
                return ListTile(
                  title: Text(valueItem.label.toString()),
                  // subtitle: Text(valueItem.value.toString()),
                  trailing: isSelected
                      ? const Icon(Icons.check_circle)
                      : const Icon(Icons.radio_button_unchecked),
                );
              },
            ),
            Wrap(
              children: [
                ElevatedButton(
                  onPressed: () {
                    _controller.setSelectedOptions([
                      // Skill(name: 'Git'),
                      // Skill(name: 'WebScrape'),
                      ValueItem(label: 'Git', value: 'Git'),
                      ValueItem(label: 'WebScrape', value: 'WebScrape'),
                    ]);
                    setState(() {
                      _selectedOptions.addAll(_controller.selectedOptions);
                    });
                  },
                  child: const Text('CLEAR'),
                ),
                const SizedBox(
                  width: 8,
                ),
                ElevatedButton(
                  onPressed: () {
                    setState(() {
                      _selectedOptions.clear();
                      _selectedOptions.addAll(_controller.selectedOptions);
                    });
                  },
                  child: const Text('Get Selected Options'),
                ),
              ],
            ),
            Text(
              'Selected Options: $_selectedOptions',
              style: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class ProjectInput extends StatefulWidget {
  const ProjectInput({super.key});

  @override
  _ProjectInputState createState() => _ProjectInputState();
}

class _ProjectInputState extends State<ProjectInput> {
  // Necessary
  final _formKey = GlobalKey<FormState>();
  final _projects = <Map<String, dynamic>>[];
  String _projectName = '';
  String _projectDescription = '';

  final MultiSelectController<String> _controller = MultiSelectController();

  final List<ValueItem<String>> _selectedOptions = [];

  // Can be reused

  int currentYear = DateTime.now().year;
  List<int> yearList = [];

  _ProjectInputState() {
    int currentYear = DateTime.now().year;
    yearList = [for (var i = 1900; i <= currentYear; i++) i];
  }

  int startYear = DateTime.now().year;
  int startMonth = DateTime.now().month;
  int endYear = DateTime.now().year;
  int endMonth = DateTime.now().month;

  void _addProject() {
    showDialog(
      context: context,
      builder: (context) {
        return StatefulBuilder(
          builder: (BuildContext context, StateSetter setState) {
            return AlertDialog(
              contentPadding: const EdgeInsets.all(16),
              title: const Text('Add Project'),
              content: SizedBox(
                width: MediaQuery.of(context).size.width * 0.9,
                height: MediaQuery.of(context).size.height * 0.7,
                child: Form(
                  key: _formKey,
                  child: SingleChildScrollView(
                    child: Column(
                      children: [
                        // School Name
                        TextFormField(
                          onChanged: (value) {
                            setState(() {
                              _projectName = value;
                            });
                          },
                          decoration: const InputDecoration(
                            labelText: 'Project Name',
                          ),
                        ),

                        // School Brief Description
                        TextFormField(
                          onChanged: (value) {
                            setState(() {
                              _projectDescription = value;
                            });
                          },
                          decoration: const InputDecoration(
                            labelText: 'Project Description',
                          ),
                          minLines: 3,
                          maxLines: 5,
                        ),

                        // Start time
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            const Align(
                              alignment: Alignment.centerLeft,
                              child: Text(
                                'Start Time',
                                style: TextStyle(
                                  fontSize: 15,
                                ),
                              ),
                            ),
                            Row(
                              children: [
                                DropdownButton<int>(
                                  value: startMonth,
                                  onChanged: (int? newValue) {
                                    setState(() {
                                      startMonth = newValue!;
                                    });
                                  },
                                  items: List<int>.generate(
                                          12,
                                          (i) =>
                                              i +
                                              1) // generates a list of 12 months
                                      .map<DropdownMenuItem<int>>((int value) {
                                    return DropdownMenuItem<int>(
                                      value: value,
                                      child: Text(value.toString()),
                                    );
                                  }).toList(),
                                ),
                                DropdownButton<int>(
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
                                )
                              ],
                            ),
                          ],
                        ),

                        // End time
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            const Align(
                              alignment: Alignment.centerLeft,
                              child: Text(
                                'End Time',
                                style: TextStyle(
                                  fontSize: 15,
                                ),
                              ),
                            ),
                            Row(
                              children: [
                                DropdownButton<int>(
                                  value: endMonth,
                                  onChanged: (int? newValue) {
                                    setState(() {
                                      endMonth = newValue!;
                                    });
                                  },
                                  items: List<int>.generate(
                                          12,
                                          (i) =>
                                              i +
                                              1) // generates a list of 12 months
                                      .map<DropdownMenuItem<int>>((int value) {
                                    return DropdownMenuItem<int>(
                                      value: value,
                                      child: Text(value.toString()),
                                    );
                                  }).toList(),
                                ),
                                DropdownButton<int>(
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
                                )
                              ],
                            ),
                          ],
                        ),

                        // Skillset
                        Column(
                          children: [
                            const Padding(
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
                            Padding(
                              padding: const EdgeInsets.all(8),
                              child: SingleChildScrollView(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    MultiSelectDropDown<String>(
                                      controller: _controller,
                                      clearIcon: const Icon(Icons.reddit),
                                      onOptionSelected: (options) {},
                                      options: [
                                        Skill(name: 'iOS Development'),
                                        Skill(name: 'C'),
                                        Skill(name: 'Java'),
                                        Skill(name: 'Kubernetes'),
                                        Skill(name: 'PostgreSQL'),
                                        Skill(name: 'Redis'),
                                        Skill(name: 'Android'),
                                        Skill(name: 'Node.js'),
                                        Skill(name: 'Objective-C'),
                                        Skill(name: 'React Native'),
                                        Skill(name: 'Microservices'),
                                        Skill(name: 'Socket.io'),
                                        Skill(name: 'AWS'),
                                        Skill(name: 'React'),
                                        Skill(name: 'Git'),
                                        Skill(name: 'WebScrape'),
                                      ]
                                          .map((skill) => ValueItem<String>(
                                              label: skill.name,
                                              value: skill.name))
                                          .toList(),
                                      // maxItems: 4,
                                      singleSelectItemStyle: const TextStyle(
                                          fontSize: 16,
                                          fontWeight: FontWeight.bold),
                                      chipConfig: const ChipConfig(
                                          wrapType: WrapType.wrap,
                                          backgroundColor: Colors.blue),
                                      optionTextStyle:
                                          const TextStyle(fontSize: 16),
                                      selectedOptionIcon: const Icon(
                                        Icons.check_circle,
                                        color: Colors.pink,
                                      ),
                                      searchEnabled: true,
                                      selectedOptionBackgroundColor:
                                          Colors.grey.shade300,
                                      selectedOptionTextColor: Colors.blue,
                                      dropdownMargin: 2,
                                      onOptionRemoved: (index, option) {},
                                      optionBuilder:
                                          (context, valueItem, isSelected) {
                                        return ListTile(
                                          title:
                                              Text(valueItem.label.toString()),
                                          // subtitle: Text(valueItem.value.toString()),
                                          trailing: isSelected
                                              ? const Icon(Icons.check_circle)
                                              : const Icon(
                                                  Icons.radio_button_unchecked),
                                        );
                                      },
                                    ),
                                    Wrap(
                                      children: [
                                        ElevatedButton(
                                          onPressed: () {
                                            _controller.clearAllSelection();
                                            setState(() {
                                              _selectedOptions.clear();
                                            });
                                          },
                                          child: const Text('CLEAR'),
                                        ),
                                        const SizedBox(
                                          width: 8,
                                        ),
                                        ElevatedButton(
                                          onPressed: () {
                                            setState(() {
                                              _selectedOptions.clear();
                                              _selectedOptions.addAll(
                                                  _controller.selectedOptions);
                                            });
                                          },
                                          child: const Text(
                                              'Get Selected Options'),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            )
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ),

              // Save button
              actions: [
                TextButton(
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      DateTime startDate = DateTime(startYear, startMonth);
                      DateTime endDate = DateTime(endYear, endMonth);
                      int durationInMonths = endDate.month -
                          startDate.month +
                          12 * (endDate.year - startDate.year) +
                          1;
                      setState(() {
                        _selectedOptions.clear();
                        _selectedOptions.addAll(_controller.selectedOptions);
                      });
                      this.setState(() {
                        _projects.add({
                          'name': _projectName,
                          'description': _projectDescription,
                          'time': '$startMonth/$startYear - $endMonth/$endYear',
                          'duration': durationInMonths.toString(),
                          'skillset': _selectedOptions
                              .map((item) => ValueItem<String>(
                                  value: item.value, label: item.label))
                              .toList(),
                        });
                      });
                      _controller.clearAllSelection();
                      setState(() {
                        _selectedOptions.clear();
                      });
                      print(_projects);
                      // setState(() {
                      //   _controller.clearAllSelection();
                      //   _selectedOptions.clear();
                      //   _selectedOptions.addAll(_controller.selectedOptions);
                      // });
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

  void _deleteProject(int index) {
    setState(() {
      _projects.removeAt(index);
    });
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Padding(
                padding: EdgeInsets.only(bottom: 10, top: 20),
                child: Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    'Projects',
                    style: TextStyle(
                      fontSize: 15,
                    ),
                  ),
                ),
              ),
              IconButton(
                onPressed: _addProject,
                icon: const Icon(Icons.add_outlined),
              ),
            ],
          ),
          ListView.builder(
            shrinkWrap: true,
            physics: const AlwaysScrollableScrollPhysics(),
            itemCount: _projects.length,
            itemBuilder: (context, index) {
              return Padding(
                padding: const EdgeInsets.all(2.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Project name
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(bottom: 0, top: 10),
                          child: Align(
                            alignment: Alignment.centerLeft,
                            child: Text(
                              'Project: ${_projects[index]['name']}',
                              style: const TextStyle(
                                  fontSize: 14, fontWeight: FontWeight.bold),
                            ),
                          ),
                        ),
                        Row(
                          children: [
                            IconButton(
                              onPressed: _addProject,
                              icon: const Icon(Icons.edit_rounded),
                              iconSize: 18,
                            ),
                            IconButton(
                              onPressed: () => _deleteProject(index),
                              icon: const Icon(Icons.delete_rounded),
                              iconSize: 18,
                            ),
                          ],
                        ),
                      ],
                    ),

                    // Project time and duration
                    Text(
                      '${_projects[index]['time']}, ${_projects[index]['duration']} months',
                      style: const TextStyle(fontSize: 12),
                    ),
                    const SizedBox(height: 8),

                    // Project description
                    Text(
                      '${_projects[index]['description']}',
                      style: const TextStyle(fontSize: 14),
                    ),

                    // Skillset
                    Column(
                      children: [
                        const Padding(
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
                        Padding(
                          padding: const EdgeInsets.all(8),
                          child: SingleChildScrollView(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                MultiSelectDropDown<String>(
                                  // controller: _controller,
                                  clearIcon: const Icon(Icons.reddit),
                                  onOptionSelected: (options) {},
                                  options: _projects[index]['skillset'],
                                  selectedOptions: _projects[index]['skillset'],
                                  // maxItems: 4,
                                  singleSelectItemStyle: const TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold),
                                  chipConfig: const ChipConfig(
                                      wrapType: WrapType.wrap,
                                      backgroundColor: Colors.blue),
                                  optionTextStyle:
                                      const TextStyle(fontSize: 16),
                                  selectedOptionIcon: const Icon(
                                    Icons.check_circle,
                                    color: Colors.pink,
                                  ),
                                  searchEnabled: true,
                                  selectedOptionBackgroundColor:
                                      Colors.grey.shade300,
                                  selectedOptionTextColor: Colors.blue,
                                  dropdownMargin: 2,
                                  onOptionRemoved: (index, option) {},
                                  optionBuilder:
                                      (context, valueItem, isSelected) {
                                    return ListTile(
                                      title: Text(valueItem.label.toString()),
                                      // subtitle: Text(valueItem.value.toString()),
                                      trailing: isSelected
                                          ? const Icon(Icons.check_circle)
                                          : const Icon(
                                              Icons.radio_button_unchecked),
                                    );
                                  },
                                ),
                              ],
                            ),
                          ),
                        )
                      ],
                    ),

                    const SizedBox(height: 10),

                    const Divider(color: Colors.black, thickness: 2),
                  ],
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}

void main() {
  runApp(const StudentProfileExperiencePage());
}

class StudentProfileExperiencePage extends StatefulWidget {
  const StudentProfileExperiencePage({super.key});

  @override
  State<StudentProfileExperiencePage> createState() =>
      StudentProfileInputState();
}

class StudentProfileInputState extends State<StudentProfileExperiencePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const AppBarBack(),
      body: Center(
        child: Padding(
            padding: const EdgeInsets.all(20),
            child: SingleChildScrollView(
              child: Column(
                children: [
                  // Header
                  const Text(
                    'Experiences',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),

                  // Brief description
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

                  const ProjectInput(),

                  // Skillset
                  // const Column(
                  //   children: [
                  //     Padding(
                  //       padding: EdgeInsets.only(bottom: 10, top: 20),
                  //       child: Align(
                  //         alignment: Alignment.centerLeft,
                  //         child: Text(
                  //           'Skillset',
                  //           style: TextStyle(
                  //             fontSize: 15,
                  //           ),
                  //         ),
                  //       ),
                  //     ),
                  //     SkillsetDropdown()
                  //   ],
                  // ),

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
                                // Navigator.push(
                                //     context,
                                //     MaterialPageRoute(
                                //         builder: (context) =>
                                //             const WelcomeScreen()));
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
