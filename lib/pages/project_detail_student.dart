import 'package:final_project_mobile/features/project/bloc/project_bloc.dart';
import 'package:final_project_mobile/features/project/bloc/project_event.dart';
import 'package:final_project_mobile/models/project.dart';
import 'package:final_project_mobile/pages/7-student-submit-proposal/submit_proposal.dart';
import 'package:final_project_mobile/widgets/custom_app_bar.dart';
import 'package:final_project_mobile/widgets/custom_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ProjectDetailsStudent extends StatefulWidget {
  final Project project;
  const ProjectDetailsStudent({
    super.key,
    required this.project,
  });
  @override
  State<ProjectDetailsStudent> createState() => _ProjectDetailsStudentState();
}

class _ProjectDetailsStudentState extends State<ProjectDetailsStudent> {
  @override
  void initState() {
    super.initState();
    BlocProvider.of<ProjectBloc>(context)
        .add(GetProjectById(projectId: (widget.project.id!).toString()));
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ProjectBloc, ProjectState>(
      listener: (context, state) {
        if (state is ProjectLoadingDone) {}
      },
      builder: (context, state) {
        final projectDetails = widget.project;
        return Scaffold(
          appBar: const CustomAppBar(),
          body: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Project details',
                  style: TextStyle(fontSize: 24.0, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 8.0),
                Text(
                  "Job title: ${projectDetails.title}",
                ),
                const SizedBox(height: 8.0),
                const Divider(),
                const SizedBox(height: 8.0),
                const Text(
                  'Students are looking for:',
                  style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 4.0),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    projectDetails.description != null
                        ? Text(
                            projectDetails.description!,
                          )
                        : const Text('No description'),
                  ],
                ),
                const Divider(),
                Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Icon(Icons.alarm),
                        const SizedBox(width: 12.0),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Text('Project scope:'),
                              projectDetails.projectScopeFlag == 1
                                  ? const Text(' • 1 to 3 months')
                                  : const Text('  • 3 to 6 months'),
                            ],
                          ),
                        ),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Icon(Icons.people),
                        const SizedBox(width: 12.0),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Text('Student required:'),
                              Text(
                                  '  • ${projectDetails.numberOfStudents} students'),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
                const Spacer(
                  flex: 1,
                ),
                Padding(
                  padding: const EdgeInsets.only(bottom: 45.0),
                  child: Row(
                    children: [
                      const CustomButton(
                        text: 'Saved',
                      ),
                      const Spacer(),
                      CustomButton(
                        text: 'Apply Now',
                        width: 140,
                        onPressed: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => const SubmitProposal()));
                        },
                      )
                    ],
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
