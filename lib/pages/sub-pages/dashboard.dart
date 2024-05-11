import 'dart:developer';

import 'package:final_project_mobile/features/project/bloc/project_bloc.dart';
import 'package:final_project_mobile/features/project/bloc/project_event.dart';
import 'package:final_project_mobile/features/selectRole/bloc/role_bloc.dart';
import 'package:final_project_mobile/features/user/bloc/user_bloc.dart';
import 'package:final_project_mobile/models/project.dart';
import 'package:final_project_mobile/pages/sub-pages/message.dart';
import 'package:final_project_mobile/pages/sub-pages/notification.dart';
import 'package:final_project_mobile/widgets/custom_app_bar.dart';
import 'package:final_project_mobile/pages/post_jobs_step.dart';
import 'package:final_project_mobile/pages/sub-pages/project_student.dart';
import 'package:final_project_mobile/widgets/project_widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class DashboardScreen extends StatefulWidget {
  const DashboardScreen({super.key});

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  List<Project> projects = [];

  int _selectedIndex = 1;
  static const TextStyle optionStyle =
      TextStyle(fontSize: 30, fontWeight: FontWeight.bold);

  late List<Widget> _widgetOptions;
  _DashboardScreenState() {
    _widgetOptions = <Widget>[
      const ProjectStudentContent(),
      dashboardContent(), // Display dashboard content
      const Text(
        'Index 2: Message',
        style: optionStyle,
      ),
      const Text(
        'Index 3: Alerts',
        style: optionStyle,
      ),
    ];
  }

  @override
  void initState() {
    super.initState();
    context.read<UserProfileBloc>().add(const GetUserProfile());
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    log('didChangeDependencies');
    final userProfileState = context.read<UserProfileBloc>().state;
    final companyId = userProfileState.userProfile.company?.id;
    log("companyId.toString(): ${companyId.toString()}");
    context
        .read<ProjectBloc>()
        .add(GetProjectsByCompanyId(companyId: "$companyId"));
    log('didChangeDependencies 2, userProfileState: $userProfileState');
  }

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    final userProfileState = context.read<UserProfileBloc>().state;
    log('userProfileState.userProfile.roles: ${userProfileState.userProfile}');
    final companyId = userProfileState.userProfile.company?.id;
    return BlocBuilder<RoleBloc, RoleState>(
      builder: (context, state) {
        if (state.roleId == 1) {
          // Company role
          _widgetOptions = <Widget>[
            const ProjectStudentContent(),
            dashboardContent(), // Display dashboard content
            const MessagePage(),
            const NotificationPage(),
          ];
        } else {
          // Student role
          _widgetOptions = <Widget>[
            const ProjectStudentContent(),
            studentDashboardContent(),
            const MessagePage(),
            const NotificationPage(),
          ];
        }
        return BlocListener<ProjectBloc, ProjectState>(
          listener: (context, state) {
            if (state is ProjectDeleteSuccess) {
              context
                  .read<ProjectBloc>()
                  .add(GetProjectsByCompanyId(companyId: "$companyId"));
            }
          },
          child: BlocBuilder<ProjectBloc, ProjectState>(
            builder: (context, projectState) {
              return Scaffold(
                appBar: const CustomAppBar(),
                body: Center(
                  child: _widgetOptions.elementAt(_selectedIndex),
                ),
                bottomNavigationBar: BottomNavigationBar(
                  items: const <BottomNavigationBarItem>[
                    BottomNavigationBarItem(
                      icon: Icon(Icons.list),
                      label: 'Projects',
                    ),
                    BottomNavigationBarItem(
                      icon: Icon(Icons.dashboard),
                      label: 'Dashboard',
                    ),
                    BottomNavigationBarItem(
                      icon: Icon(Icons.message),
                      label: 'Message',
                    ),
                    BottomNavigationBarItem(
                      icon: Icon(Icons.notifications),
                      label: 'Notification',
                    ),
                  ],
                  currentIndex: _selectedIndex,
                  selectedItemColor: Colors.blue[800],
                  unselectedItemColor: Colors.grey,
                  onTap: _onItemTapped,
                ),
              );
            },
          ),
        );
      },
    );
  }

  Widget dashboardContent() {
    List<Project> archivedProjects = [];
    return BlocConsumer<RoleBloc, RoleState>(
      listener: (context, state) {},
      builder: (context, state) {
        log('RoleBloc listener: $state');
        return BlocBuilder<ProjectBloc, ProjectState>(
          builder: (context, state) {
            if (state is ProjectLoadSuccess) {
              projects = state.projects;
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
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => const PostJobStepScreen(),
                              ),
                            );
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
                      length: 2,
                      child: Column(
                        children: [
                          const TabBar(
                            tabs: [
                              Tab(text: 'All projects'),
                              Tab(text: 'Archived projects'),
                            ],
                          ),
                          Expanded(
                            child: TabBarView(
                              children: [
                                ProjectWidgets.buildProjectList(
                                    projects), // All projects tab
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

  Widget studentDashboardContent() {
    return Container(
      height: double.infinity,
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Padding(
              padding: EdgeInsets.only(left: 16, top: 0, bottom: 10),
              child: Text(
                'Your Projects',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
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
                    height: MediaQuery.of(context).size.height /
                        2, // Adjust as needed
                    child: TabBarView(
                      children: [
                        // Content for 'All Projects' tab
                        Column(
                          children: [
                            Expanded(
                              child: ListView.builder(
                                itemCount: 2,
                                itemBuilder: (context, index) {
                                  return Container(
                                    margin: const EdgeInsets.all(16),
                                    decoration: BoxDecoration(
                                      border: Border.all(color: Colors.grey),
                                      borderRadius: BorderRadius.circular(8),
                                    ),
                                    child: const Padding(
                                      padding: EdgeInsets.only(
                                          left: 16,
                                          top: 16,
                                          right: 16,
                                          bottom: 8),
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          // Active Proposals heading

                                          SizedBox(height: 8),
                                          Text(
                                            'Title',
                                            style: TextStyle(
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                          Text(
                                            'Submitted (time ago)',
                                            style: TextStyle(
                                              fontSize: 12,
                                              color: Colors.grey,
                                            ),
                                          ),
                                          SizedBox(height: 8),
                                          // Replace with your actual list
                                          Text('List item 1'),
                                          Text('List item 2'),
                                          Text('List item 3'),
                                        ],
                                      ),
                                    ),
                                  );
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
      ),
    );
  }
}
