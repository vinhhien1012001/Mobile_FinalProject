import 'dart:developer';

import 'package:final_project_mobile/features/project/bloc/project_bloc.dart';
import 'package:final_project_mobile/features/project/bloc/project_event.dart';
import 'package:final_project_mobile/features/user/bloc/user_bloc.dart';
import 'package:final_project_mobile/models/project.dart';
import 'package:final_project_mobile/models/proposal.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class StudentDashboardContent extends StatelessWidget {
  const StudentDashboardContent({Key? key});

  @override
  Widget build(BuildContext context) {
    final UserProfileBloc userProfileBloc =
        BlocProvider.of<UserProfileBloc>(context);
    final List<Proposal> proposals =
        userProfileBloc.state.userProfile.student!.proposals;
    final List<Proposal> activeProposals = proposals
        .where((element) => element.statusFlag == 1)
        .toList(); // Filter active proposals
    WidgetsBinding.instance!.addPostFrameCallback((_) {
      BlocProvider.of<ProjectBloc>(context).add(GetProjectsByStudentId(
          studentId: userProfileBloc.state.userProfile.student!.id,
          typeFlag: const [0, 1, 2]));
      BlocProvider.of<ProjectBloc>(context).add(GetProjectsByStudentId(
          studentId: userProfileBloc.state.userProfile.student!.id,
          typeFlag: const [1]));
      BlocProvider.of<ProjectBloc>(context).add(GetProjectsByStudentId(
          studentId: userProfileBloc.state.userProfile.student!.id,
          typeFlag: const [2]));
    });
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 16, top: 0, bottom: 0),
            child: Container(
              margin: const EdgeInsets.only(left: 4),
              child: const Text(
                'Your Projects',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
          DefaultTabController(
            length: 3,
            child: Column(
              children: [
                const TabBar(
                  tabs: [
                    Tab(text: 'All Projects'),
                    Tab(text: 'Working'),
                    Tab(text: 'Archived'),
                  ],
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.height -
                      300, // 300 is the height of the bottom navigation bar
                  child: TabBarView(
                    children: [
                      Column(
                        children: [
                          _buildActiveProposalBox(
                              context, activeProposals.length),
                          Expanded(
                            child: BlocConsumer<ProjectBloc, ProjectState>(
                              listener: (context, state) {}, // Consume here
                              builder: (context, state) {
                                if (state is GetProjectByStudentIdDone &&
                                    state.typeFlag.contains(0) &&
                                    state.typeFlag.contains(1) &&
                                    state.typeFlag.contains(2)) {
                                  final projects = state.projects;
                                  return ListView.builder(
                                    itemCount: projects.length,
                                    itemBuilder: (context, index) {
                                      return ProjectWidget(
                                          project: projects[index]);
                                    },
                                  );
                                }
                                return const Center(
                                  child: Text('You have no projects'),
                                );
                              },
                            ),
                          ),
                        ],
                      ),
                      // Content for 'Working' tab (Replace with actual content)
                      Column(
                        children: [
                          Expanded(
                            child: BlocConsumer<ProjectBloc, ProjectState>(
                              listener: (context, state) {}, // Consume here
                              builder: (context, state) {
                                if (state is GetProjectByStudentIdDone &&
                                    !state.typeFlag.contains(0) &&
                                    state.typeFlag.contains(1) &&
                                    !state.typeFlag.contains(2)) {
                                  final projects = state.projects;
                                  return ListView.builder(
                                    itemCount: projects.length,
                                    itemBuilder: (context, index) {
                                      return ProjectWidget(
                                          project: projects[index]);
                                    },
                                  );
                                }
                                return const Center(
                                  child: Text('You have no working projects'),
                                );
                              },
                            ),
                          ),
                        ],
                      ),
                      // Content for 'Archived' tab (Replace with actual content)
                      Column(
                        children: [
                          Expanded(
                            child: BlocConsumer<ProjectBloc, ProjectState>(
                              listener: (context, state) {}, // Consume here
                              builder: (context, state) {
                                if (state is GetProjectByStudentIdDone &&
                                    !state.typeFlag.contains(0) &&
                                    !state.typeFlag.contains(1) &&
                                    state.typeFlag.contains(2)) {
                                  final projects = state.projects;
                                  return ListView.builder(
                                    itemCount: projects.length,
                                    itemBuilder: (context, index) {
                                      return ProjectWidget(
                                          project: projects[index]);
                                    },
                                  );
                                }
                                return const Center(
                                  child: Text('You have no archived projects'),
                                );
                              },
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildActiveProposalBox(BuildContext context, int count) {
    return Container(
      margin: const EdgeInsets.fromLTRB(16, 16, 16, 0), // Add margins
      width: double.infinity, // Expand to full width
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Padding(
        padding:
            const EdgeInsets.fromLTRB(16, 16, 16, 8), // Adjust inner padding
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Active Proposals heading with count
            Text(
              'Active Proposals ($count)',
              style: const TextStyle(
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class ProjectWidget extends StatelessWidget {
  const ProjectWidget({Key? key, required this.project});
  final Project project;
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ProjectBloc, ProjectState>(
      builder: (context, state) {
        DateTime createdAt = DateTime.parse(project.createdAt!);
        Duration difference = DateTime.now().difference(createdAt);
        String timeAgo = difference.inHours < 24
            ? '${difference.inHours} hours ago'
            : '${difference.inDays} days ago';
        return Container(
          margin: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            border: Border.all(color: Colors.grey),
            borderRadius: BorderRadius.circular(8),
          ),
          child: Padding(
            padding:
                const EdgeInsets.only(left: 16, top: 16, right: 16, bottom: 8),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 8),
                Text(
                  '${project.title}',
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  'Submitted ($timeAgo)',
                  style: const TextStyle(
                    fontSize: 12,
                    color: Colors.grey,
                  ),
                ),
                const SizedBox(height: 8),
                const Text('Student are looking for'),
                Text('${project.description}'),
              ],
            ),
          ),
        );
      },
    );
  }
}
