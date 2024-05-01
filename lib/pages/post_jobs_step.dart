import 'dart:developer';

import 'package:final_project_mobile/features/project/bloc/project_bloc.dart';
import 'package:final_project_mobile/features/project/bloc/project_event.dart';
import 'package:final_project_mobile/features/user/bloc/user_bloc.dart';
import 'package:final_project_mobile/models/project.dart';
import 'package:final_project_mobile/pages/sub-pages/dashboard.dart';
import 'package:final_project_mobile/widgets/custom_app_bar.dart';
import 'package:final_project_mobile/widgets/custom_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class PostJobStepScreen extends StatefulWidget {
  const PostJobStepScreen({super.key});

  @override
  State<PostJobStepScreen> createState() => _PostJobStepScreenState();
}

class _PostJobStepScreenState extends State<PostJobStepScreen> {
  int currentStep = 1;
  String title = '';
  String duration = '';
  int numStudents = 0;
  String projectDescription = '';

  @override
  void initState() {
    super.initState();
    context.read<UserProfileBloc>().add(const GetUserProfile());
  }

  @override
  Widget build(BuildContext context) {
    return MultiBlocListener(
      listeners: [
        BlocListener<UserProfileBloc, UserProfileState>(
          listener: (context, state) {
            if (state is UserProfileEvent) {
              log('User profile event $state');
            }
          },
        ),
        BlocListener<ProjectBloc, ProjectState>(
          listener: (context, state) {},
        ),
      ],
      child: BlocBuilder<UserProfileBloc, UserProfileState>(
        builder: (context, userProfileState) {
          final companyId = userProfileState.userProfile.company?.id;
          return BlocListener<ProjectBloc, ProjectState>(
            listener: (context, state) {},
            child: Scaffold(
              appBar: const CustomAppBar(),
              body: Container(
                padding: const EdgeInsets.all(20.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _buildStep(currentStep),
                    const SizedBox(height: 20.0),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        if (currentStep > 1)
                          CustomButton(
                            text: 'Back',
                            onPressed: () {
                              setState(() {
                                currentStep--;
                              });
                            },
                          ),
                        const Spacer(),
                        if (currentStep < 4)
                          CustomButton(
                            text: 'Next',
                            onPressed: () {
                              if (currentStep == 1) {
                                // Save data from step 1
                              } else if (currentStep == 2) {
                                // Save data from step 2
                              }
                              setState(() {
                                currentStep++;
                              });
                            },
                          ),
                        if (currentStep == 4)
                          CustomButton(
                            text: 'Post Job $companyId',
                            onPressed: () {
                              Project project = Project(
                                companyId: "$companyId",
                                projectScopeFlag: 1,
                                title: title,
                                description: projectDescription,
                                numberOfStudents: numStudents,
                              );
                              context
                                  .read<ProjectBloc>()
                                  .add(CreateProject(project: project));

                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) =>
                                          const DashboardScreen()));
                            },
                          ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _buildStep(int step) {
    switch (step) {
      case 1:
        return StepOne(onTitleChanged: (value) {
          setState(() {
            title = value!;
          });
        });
      case 2:
        return StepTwo(
          onDurationChanged: (value) {
            setState(() {
              duration = value!;
            });
          },
          onNumStudentsChanged: (value) {
            setState(() {
              numStudents = int.parse(value!);
            });
          },
        );
      case 3:
        return StepThree(
          onProjectDescriptionChanged: (value) {
            setState(() {
              projectDescription = value!;
            });
          },
        );
      case 4:
        return StepFour(
          title: title,
          duration: duration,
          numStudents: numStudents,
          projectDescription: projectDescription,
        );
      default:
        return Container();
    }
  }
}

class StepOne extends StatelessWidget {
  final ValueChanged<String?>? onTitleChanged;

  const StepOne({super.key, this.onTitleChanged});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildHeaderText("Let's start with a strong title"),
        const SizedBox(height: 8.0),
        _buildDescriptionText(
            "This helps your posts stand out to the right student. It's the first thing they'll see, so make it impressive."),
        const SizedBox(height: 8.0),
        _buildTextField('Write a title for your post here',
            onChanged: onTitleChanged),
        const SizedBox(height: 8.0),
        _buildExampleTitles(),
      ],
    );
  }

  Widget _buildHeaderText(String text) {
    return Text(
      text,
      style: const TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold),
    );
  }

  Widget _buildDescriptionText(String text) {
    return Text(text);
  }

  Widget _buildTextField(String hintText, {ValueChanged<String?>? onChanged}) {
    return TextField(
      onChanged: onChanged,
      decoration: InputDecoration(
        hintText: hintText,
      ),
    );
  }

  Widget _buildExampleTitles() {
    return const Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Example titles:',
          style: TextStyle(fontSize: 16.0, fontWeight: FontWeight.bold),
        ),
        SizedBox(height: 4.0),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('- Build responsive'),
            Text('- Build interactive'),
            Text('- Design beautiful'),
          ],
        ),
      ],
    );
  }
}

class StepTwo extends StatefulWidget {
  final void Function(String?)? onDurationChanged;
  final void Function(String?)? onNumStudentsChanged;

  const StepTwo({
    super.key,
    required this.onDurationChanged,
    required this.onNumStudentsChanged,
  });

  @override
  StepTwoState createState() => StepTwoState();
}

class StepTwoState extends State<StepTwo> {
  String? _selectedDuration;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Next, estimate the scope of your job',
          style: TextStyle(fontSize: 24.0, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 8.0),
        const Text(
          'Consider the size of your project and the timeline.',
        ),
        const SizedBox(height: 8.0),
        const Text(
          'How long will your project take?',
          style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 4.0),
        DropdownButton<String>(
          value: _selectedDuration,
          onChanged: (value) {
            setState(() {
              _selectedDuration = value;
            });
            widget.onDurationChanged?.call(value);
          },
          items: const [
            DropdownMenuItem<String>(
              value: '1-3',
              child: Text('1 to 3 months'),
            ),
            DropdownMenuItem<String>(
              value: '3-6',
              child: Text('3 to 6 months'),
            ),
          ],
          hint: const Text('Select duration'),
        ),
        const SizedBox(height: 8.0),
        const Text(
          'How many students do you want for this project?',
          style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 4.0),
        TextField(
          decoration:
              const InputDecoration(labelText: "Enter number of students"),
          keyboardType: TextInputType.number,
          inputFormatters: <TextInputFormatter>[
            FilteringTextInputFormatter.digitsOnly
          ], // Only numbers can be entered
          onChanged: widget.onNumStudentsChanged,
        ),
      ],
    );
  }
}

class StepThree extends StatefulWidget {
  final void Function(String?)? onProjectDescriptionChanged;
  const StepThree({super.key, required this.onProjectDescriptionChanged});

  @override
  StepThreeState createState() => StepThreeState();
}

class StepThreeState extends State<StepThree> {
  String? _projectDescription;
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Next, provide project description',
          style: TextStyle(fontSize: 24.0, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 8.0),
        const Text(
          'Students are looking for:',
          style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 4.0),
        const Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('- Clear expectations about your project or deliverables'),
            Text('- The skills required for your project'),
            Text('- Details about your project'),
          ],
        ),
        const SizedBox(height: 8.0),
        const Text(
          'Describe your project:',
          style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 4.0),
        TextField(
          maxLines: null,
          decoration: const InputDecoration(
            hintText: 'Enter project description',
          ),
          onChanged: (value) {
            setState(() {
              _projectDescription = value;
            });
            widget.onProjectDescriptionChanged?.call(value);
          },
        ),
      ],
    );
  }
}

class StepFour extends StatelessWidget {
  final String title;
  final String duration;
  final int numStudents;
  final String projectDescription;

  const StepFour({
    super.key,
    required this.title,
    required this.duration,
    required this.numStudents,
    required this.projectDescription,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Project details',
          style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 8.0),
        Text(
          'Job title: $title',
          style: const TextStyle(fontSize: 16.0, fontWeight: FontWeight.w600),
        ),
        // const SizedBox(height: 8.0),
        // Text(
        //   'Duration: $duration',
        // ),
        // const SizedBox(height: 8.0),
        // Text(
        //   'Number of students: $numStudents',
        // ),
        const SizedBox(height: 16.0),
        const Divider(),
        const SizedBox(height: 16.0),
        const Text(
          'Students are looking for:',
          style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 4.0),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(projectDescription),
          ],
        ),
        const SizedBox(height: 16.0),
        const Divider(),
        const SizedBox(height: 16.0),
        Row(
          children: [
            const Icon(Icons.alarm),
            const SizedBox(width: 8.0),
            Column(
              children: [
                Container(
                  margin: const EdgeInsets.only(right: 24.0),
                  child: const Text('Project Scope'),
                ),
                Container(
                  margin: const EdgeInsets.only(left: 32.0),
                  child: duration == '1-3'
                      ? const Text(' • 1 to 3 months')
                      : const Text(' • 3 to 6 months'),
                ),
              ],
            )
          ],
        ),
        const SizedBox(height: 8.0),
        Row(
          children: [
            const Icon(Icons.people),
            const SizedBox(width: 8.0),
            Column(
              children: [
                Container(
                  margin: const EdgeInsets.only(left: 12.0),
                  child: const Text('Student required'),
                ),
                Container(
                  margin: const EdgeInsets.only(left: 24.0),
                  child: Text(' • $numStudents students'),
                ),
              ],
            )
          ],
        ),
      ],
    );
  }
}
