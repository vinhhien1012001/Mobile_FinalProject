import 'package:final_project_mobile/features/project/bloc/project_bloc.dart';
import 'package:final_project_mobile/features/project/bloc/project_event.dart';
import 'package:final_project_mobile/features/proposal/bloc/proposal_bloc.dart';
import 'package:final_project_mobile/features/user/bloc/user_bloc.dart';
import 'package:final_project_mobile/models/project.dart';
import 'package:final_project_mobile/models/proposal.dart';
import 'package:final_project_mobile/models/user_profile.dart';
import 'package:final_project_mobile/utils/utils.dart';
import 'package:final_project_mobile/widgets/project_widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class StudentDashboardContent extends StatefulWidget {
  StudentDashboardContent({super.key});

  final List<Proposal> allProposals = [];
  @override
  State<StudentDashboardContent> createState() =>
      _StudentDashboardContentState();
}

class _StudentDashboardContentState extends State<StudentDashboardContent> {
  List<Proposal> allProposal = [];
  List<Project> allProjects = [];
  List<Project> workingProjects = [];
  @override
  void initState() {
    super.initState();
    final UserProfileBloc userProfileBloc =
        BlocProvider.of<UserProfileBloc>(context);
    UserProfile userProfile = userProfileBloc.state.userProfile;
    BlocProvider.of<ProposalBloc>(context)
        .add(GetAllProposalsOfStudent(studentId: userProfile.student?.id ?? 0));
    BlocProvider.of<ProjectBloc>(context).add(
        GetAllProjectsByStudentId(studentId: userProfile.student?.id ?? 0));
  }

  @override
  Widget build(BuildContext context) {
    final UserProfileBloc userProfileBloc =
        BlocProvider.of<UserProfileBloc>(context);
    final List<Proposal> proposals =
        userProfileBloc.state.userProfile.student?.proposals ?? [];
    WidgetsBinding.instance.addPostFrameCallback((_) {});
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 16, top: 0, bottom: 0),
            child: Container(
              margin: const EdgeInsets.only(left: 4),
            ),
          ),
          DefaultTabController(
            length: 3,
            child: Column(
              children: [
                const TabBar(
                  tabs: [
                    Tab(text: 'All Proposals'),
                    Tab(text: 'Working'),
                    Tab(text: 'Archived'),
                  ],
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.height -
                      250, // 300 is the height of the bottom navigation bar
                  child: TabBarView(
                    children: [
                      BlocBuilder<ProposalBloc, ProposalState>(
                        builder: (context, state) {
                          if (state is GetAllProposalsOfStudentSuccess) {
                            allProposal = state.proposals;
                          }
                          return Column(
                            children: [
                              _buildActiveProposalBox(
                                  context,
                                  allProposal
                                      .where(
                                          (element) => element.statusFlag == 1)
                                      .length),
                              Expanded(
                                child:
                                    BlocConsumer<ProposalBloc, ProposalState>(
                                  listener: (context, state) {}, // Consume here
                                  builder: (context, state) {
                                    return ListView.builder(
                                      itemCount: allProposal.length,
                                      itemBuilder: (context, index) {
                                        return ProposalWidget(
                                            proposal: allProposal[index]);
                                      },
                                    );
                                  },
                                ),
                              ),
                            ],
                          );
                        },
                      ),
                      // Content for 'Working' tab (Replace with actual content)
                      Column(
                        children: [
                          Expanded(
                            child: BlocConsumer<ProjectBloc, ProjectState>(
                              listener: (context, state) {}, // Consume here
                              builder: (context, state) {
                                final List<Project> projects = [];
                                if (state is GetAllProjectsByStudentIdSuccess &&
                                    state.projects.isNotEmpty) {
                                  allProjects = state.projects;
                                  workingProjects = state.projects
                                      .where((element) => element.typeFlag == 1)
                                      .toList();
                                }
                                if (state is GetAllProjectsByStudentIdLoading) {
                                  return const Center(
                                    child: CircularProgressIndicator(),
                                  );
                                } else {
                                  return ListView.builder(
                                    itemCount: workingProjects.length,
                                    itemBuilder: (context, index) {
                                      return WorkingProjectWidget(
                                          projectId:
                                              workingProjects[index].id!);
                                    },
                                  );
                                }
                              },
                            ),
                          ),
                        ],
                      ),
                      // Content for 'Archived' tab (Replace with actual content)
                      Column(
                        children: [
                          Expanded(
                            child: BlocConsumer<ProposalBloc, ProposalState>(
                              listener: (context, state) {}, // Consume here
                              builder: (context, state) {
                                if (state is GetAllProposalsOfStudentSuccess) {
                                  final proposals = state.proposals
                                      .where(
                                          (element) => element.statusFlag == 2)
                                      .toList();
                                  return ListView.builder(
                                    itemCount: proposals.length,
                                    itemBuilder: (context, index) {
                                      return ProposalWidget(
                                          proposal: proposals[index]);
                                    },
                                  );
                                } else {
                                  return const Center(
                                    child:
                                        Text('You have no archived projects'),
                                  );
                                }
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

class ProposalWidget extends StatefulWidget {
  const ProposalWidget({super.key, required this.proposal});
  final Proposal proposal;

  @override
  State<ProposalWidget> createState() => _ProposalWidgetState();
}

class _ProposalWidgetState extends State<ProposalWidget>
    with AutomaticKeepAliveClientMixin {
  bool shouldBeKeptAlive = false;

  late Project project = Project();
  @override
  void initState() {
    super.initState();
    // Fetch project data if it's not already loaded
    final projectBloc = BlocProvider.of<ProjectBloc>(context);
    if (projectBloc.state is! ProjectLoadingDone ||
        (projectBloc.state as ProjectLoadingDone).project.id !=
            widget.proposal.projectId) {
      projectBloc.add(GetProjectById(
        projectId: widget.proposal.projectId.toString(),
      ));
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ProposalBloc, ProposalState>(
      builder: (context, state) {
        DateTime createdAt = DateTime.parse(widget.proposal.createdAt!);
        Duration difference = DateTime.now().difference(createdAt);
        String timeAgo = difference.inHours < 24
            ? '${difference.inHours} hours ago'
            : '${difference.inDays} days ago';
        return BlocBuilder<ProjectBloc, ProjectState>(
          builder: (context, state) {
            shouldBeKeptAlive = state is ProjectLoadingDone;
            if (state is ProjectLoadingDone &&
                state.project.id == widget.proposal.projectId) {
              project = state.project;
            }
            return Container(
              margin:
                  const EdgeInsets.only(left: 16, right: 16, top: 8, bottom: 8),
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
                    const SizedBox(height: 8),
                    Container(
                      decoration: BoxDecoration(
                        color: Colors.grey[200], // Background color
                        borderRadius:
                            BorderRadius.circular(8), // Rounded corners
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: [
                            BlocBuilder<ProjectBloc, ProjectState>(
                              builder: (context, state) {
                                if (state is ProjectLoading) {
                                  return const Text('Loading ...');
                                }
                                return Text(
                                  '${project.title}',
                                  style: const TextStyle(
                                    fontWeight: FontWeight.bold,
                                  ),
                                );
                              },
                            ),
                            Text(
                              'Submitted ($timeAgo)',
                              style: const TextStyle(
                                fontSize: 12,
                                color: Colors.grey,
                              ),
                            ),
                            const SizedBox(height: 8),
                            const Text(
                              'Your cover letter:',
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            Container(
                              padding: const EdgeInsets.only(top: 8),
                              child: Text(
                                '${widget.proposal.coverLetter}',
                                style: const TextStyle(
                                  fontSize: 14,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    ProjectWidgets.buildProjectCard(
                      title: project.title ?? '',
                      created: project.createdAt ?? DateTime.now().toString(),
                      context: context,
                      description: project.description ?? '',
                      hired: project.countHired ?? 0,
                      isFavorite: project.isFavorite ?? false,
                      messages: project.countMessages ?? 0,
                      numberOfStudent: project.numberOfStudents ?? 0,
                      projectId: project.id ?? 0,
                      projectScopeFlag: project.projectScopeFlag ?? 0,
                      proposalsCount: project.countProposals ?? 0,
                    )
                  ],
                ),
              ),
            );
          },
        );
      },
    );
  }

  @override
  bool get wantKeepAlive => shouldBeKeptAlive;
}

class WorkingProjectWidget extends StatefulWidget {
  const WorkingProjectWidget({super.key, required this.projectId});
  final int projectId;

  @override
  State<WorkingProjectWidget> createState() => _WorkingProjectWidgetState();
}

class _WorkingProjectWidgetState extends State<WorkingProjectWidget> {
  late Project project = Project();
  @override
  void initState() {
    super.initState();
    BlocProvider.of<ProjectBloc>(context)
        .add(GetProjectById(projectId: widget.projectId.toString()));
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ProjectBloc, ProjectState>(
      builder: (context, state) {
        if (state is ProjectLoadingDone &&
            state.project.id == widget.projectId) {
          project = state.project;
        }
        return Container(
          margin: const EdgeInsets.only(left: 16, right: 16, top: 8, bottom: 8),
          child: Card(
            margin: const EdgeInsets.symmetric(vertical: 10, horizontal: 0),
            child: Padding(
              padding: const EdgeInsets.all(15),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        child: Text(
                          project.title ?? '',
                          style: const TextStyle(
                            fontSize: 22,
                            color: Colors.blueAccent,
                            fontWeight: FontWeight.w500,
                          ),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          softWrap: true,
                        ),
                      ),
                    ],
                  ),
                  Text(
                    'Created ${project.createdAt}',
                    style: const TextStyle(color: Colors.grey),
                  ),
                  const SizedBox(height: 10),
                  Row(
                    children: [
                      const Icon(Icons.people),
                      const SizedBox(width: 10),
                      Text(
                        '${project.numberOfStudents}',
                        style: const TextStyle(color: Colors.grey),
                      ),
                      const SizedBox(width: 30),
                      const Icon(Icons.access_time),
                      const SizedBox(width: 5),
                      Text(
                        switch (project.projectScopeFlag ?? 0) {
                          0 => 'Less than one month',
                          1 => 'One to three months',
                          2 => 'Three to sixth months',
                          3 => 'More than six months',
                          int() => 'Unknown',
                        },
                        style: const TextStyle(color: Colors.grey),
                      ),
                    ],
                  ),
                  const SizedBox(height: 5),
                  const Text(
                    'Project description: ',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 10),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(left: 0),
                        child: Column(
                          children: [
                            Text(
                              style: const TextStyle(
                                fontSize: 16,
                              ),
                              project.description.toString().toCapitalized(),
                              textAlign: TextAlign.justify,
                              maxLines: 4,
                              locale: const Locale('vi', 'VN'),
                              softWrap: true,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ],
                        ),
                      )
                    ],
                  ),
                  const SizedBox(height: 10),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      ProjectWidgets.buildStatusColumn(
                          'Proposals', project.countProposals ?? 0),
                      ProjectWidgets.buildStatusColumn(
                          'Messages', project.countMessages ?? 0),
                      ProjectWidgets.buildStatusColumn(
                          'Hired', project.countHired ?? 0),
                    ],
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
