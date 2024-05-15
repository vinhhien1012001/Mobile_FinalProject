import 'dart:developer';

import 'package:final_project_mobile/features/project/bloc/project_bloc.dart';
import 'package:final_project_mobile/features/project/bloc/project_event.dart';
import 'package:final_project_mobile/features/selectRole/bloc/role_bloc.dart';
import 'package:final_project_mobile/features/user/bloc/user_bloc.dart';
import 'package:final_project_mobile/models/project.dart';
import 'package:final_project_mobile/pages/post_jobs_step.dart';
import 'package:final_project_mobile/routes/routes.dart';
import 'package:final_project_mobile/widgets/project_widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class DashboardCompany extends StatefulWidget {
  const DashboardCompany({super.key});

  @override
  State<DashboardCompany> createState() => _DashboardCompanyState();
}

class _DashboardCompanyState extends State<DashboardCompany> {
  @override
  void initState() {
    super.initState();
    final userProfileState = context.read<UserProfileBloc>().state;
    final companyId = userProfileState.userProfile.company?.id;
    if (companyId != null) {
      BlocProvider.of<ProjectBloc>(context)
          .add(GetProjectsByCompanyId(companyId: '$companyId'));
    }
  }

  List<Project> projects = [];
  List<Project> workingProjects = [];
  List<Project> archivedProjects = [];
  @override
  Widget build(BuildContext context) {
    List<Project> archivedProjects = [];
    return BlocConsumer<RoleBloc, RoleState>(
      listener: (context, state) {},
      builder: (context, state) {
        log('RoleBloc listener: $state');
        return BlocBuilder<ProjectBloc, ProjectState>(
          builder: (context, state) {
            if (state is MyProjectLoadSuccess) {
              projects = state.projects;
              workingProjects =
                  projects.where((project) => project.typeFlag == 1).toList();
              archivedProjects =
                  projects.where((project) => project.typeFlag == 2).toList();
            }
            return Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Padding(
                        padding: EdgeInsets.only(top: 20),
                        child:
                            Text('Your projects'), // Changed from 'Your jobs'
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 20, left: 10),
                        child: ElevatedButton(
                          onPressed: () {
                            Navigator.pushNamed(context, Routes.postJobsStep);
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
                          child: const Text('Post a job'),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 30),
                  Expanded(
                    child: DefaultTabController(
                      length: 3,
                      child: Column(
                        children: [
                          const TabBar(
                            tabs: [
                              Tab(text: 'All projects'),
                              Tab(text: 'Working '),
                              Tab(text: 'Archived '),
                            ],
                          ),
                          Expanded(
                            child: TabBarView(
                              children: [
                                ProjectWidgets.buildProjectList(
                                    projects), // All projects tab
                                ProjectWidgets.buildProjectList(
                                    workingProjects), // All projects tab
                                ProjectWidgets.buildProjectList(
                                    archivedProjects), // Archived projects tab
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            );
          },
        );
      },
    );
  }
}
