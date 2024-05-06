import 'dart:developer';

import 'package:final_project_mobile/features/project/bloc/project_bloc.dart';
import 'package:final_project_mobile/features/project/bloc/project_event.dart';
import 'package:final_project_mobile/features/user/bloc/user_bloc.dart';
import 'package:final_project_mobile/models/proposal.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class StudentDashboardContent extends StatelessWidget {
  const StudentDashboardContent({super.key});

  @override
  Widget build(BuildContext context) {
    final UserProfileBloc userProfileBloc =
        BlocProvider.of<UserProfileBloc>(context);
    final List<Proposal> proposals =
        userProfileBloc.state.userProfile.student!.proposals;
    BlocProvider.of<ProjectBloc>(context).add(GetProjectsByProjectIds(
        projectIds: proposals.map((e) => e.projectId.toString()).toList()));

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
                          Expanded(
                            child:
                                BlocConsumer<UserProfileBloc, UserProfileState>(
                              listener: (context, state) {}, // Consume here
                              builder: (context, state) {
                                if (state is UserProfileLoadSuccess) {
                                  final List<Proposal> proposals =
                                      state.userProfile.student!.proposals;
                                  return ListView.builder(
                                    itemCount: proposals.length,
                                    itemBuilder: (context, index) {
                                      final UserProfileBloc userProfileBloc =
                                          BlocProvider.of<UserProfileBloc>(
                                              context);
                                      final List<Proposal> proposals =
                                          userProfileBloc.state.userProfile
                                              .student!.proposals;
                                      final int projectId =
                                          proposals[index].projectId!;

                                      // Parse the createdAt timestamp into a DateTime object
                                      DateTime createdAt = DateTime.parse(
                                          proposals[index].createdAt!);
                                      // Calculate the difference between createdAt and current time
                                      Duration difference =
                                          DateTime.now().difference(createdAt);
                                      String timeAgo = difference.inHours < 24
                                          ? '${difference.inHours} hours ago'
                                          : '${difference.inDays} days ago';

                                      return BlocBuilder<ProjectBloc,
                                          ProjectState>(
                                        builder: (context, state) {
                                          if (state is MyProjectLoadSuccess) {
                                            return ProposalWidget(
                                              coverLetter:
                                                  '${proposals[index].coverLetter}',
                                              submitted: timeAgo,
                                              projectId: projectId,
                                            );
                                          }
                                          return ProposalWidget(
                                            coverLetter:
                                                '${proposals[index].coverLetter}',
                                            submitted: timeAgo,
                                            projectId: projectId,
                                          );
                                        },
                                      );
                                    },
                                  );
                                } else {
                                  return const Center(
                                    child: CircularProgressIndicator(),
                                  );
                                }
                              },
                            ),
                          ),
                        ],
                      ),
                      // Content for 'Working' tab (Replace with actual content)
                      const Center(
                        child: Text('Working Projects'),
                      ),
                      // Content for 'Archived' tab (Replace with actual content)
                      const Center(
                        child: Text('Archived Projects'),
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
}

class ProposalWidget extends StatelessWidget {
  const ProposalWidget({
    super.key,
    this.coverLetter,
    this.submitted,
    this.title,
    this.projectId,
  });
  final String? coverLetter;
  final String? submitted;
  final String? title;
  final int? projectId;
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ProjectBloc, ProjectState>(
      builder: (context, state) {
        if (state is ProjectsByIdsLoadingDone) {
          final project =
              state.projects.firstWhere((element) => element.id == projectId);
          return Container(
            margin: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              border: Border.all(color: Colors.grey),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Padding(
              padding: const EdgeInsets.only(
                  left: 16, top: 16, right: 16, bottom: 8),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Active Proposals heading
                  const SizedBox(height: 8),
                  Text(
                    '${project.title}',
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    'Submitted ($submitted)',
                    style: const TextStyle(
                      fontSize: 12,
                      color: Colors.grey,
                    ),
                  ),
                  const SizedBox(height: 8),
                  // Replace with your actual list
                  const Text('Student are looking for'),
                  Text('$coverLetter'),
                  const Text('List item 1'),
                ],
              ),
            ),
          );
        } else {
          return Container(
            margin: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              border: Border.all(color: Colors.grey),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Padding(
              padding: const EdgeInsets.only(
                  left: 16, top: 16, right: 16, bottom: 8),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Active Proposals heading
                  const SizedBox(height: 8),
                  const CircularProgressIndicator(),
                  Text(
                    'Submitted ($submitted)',
                    style: const TextStyle(
                      fontSize: 12,
                      color: Colors.grey,
                    ),
                  ),
                  const SizedBox(height: 8),
                  // Replace with your actual list
                  const Text('Student are looking for'),
                  Text('$coverLetter'),
                  const Text('List item 1'),
                ],
              ),
            ),
          );
        }
      },
    );
  }
}
