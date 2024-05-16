import 'dart:developer';

import 'package:final_project_mobile/features/project/bloc/project_bloc.dart';
import 'package:final_project_mobile/features/project/bloc/project_event.dart';
import 'package:final_project_mobile/features/selectRole/bloc/role_bloc.dart';
import 'package:final_project_mobile/features/user/bloc/user_bloc.dart';
import 'package:final_project_mobile/models/user_profile.dart';
import 'package:final_project_mobile/pages/sub-pages/dashboard_company.dart';
import 'package:final_project_mobile/pages/sub-pages/dashboard_student.dart';
import 'package:final_project_mobile/pages/sub-pages/message.dart';
import 'package:final_project_mobile/pages/sub-pages/notification.dart';
import 'package:final_project_mobile/widgets/custom_app_bar.dart';
import 'package:final_project_mobile/pages/sub-pages/project_student.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class DashboardScreen extends StatefulWidget {
  const DashboardScreen({super.key});

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  @override
  int _selectedIndex = 1;
  static const TextStyle optionStyle =
      TextStyle(fontSize: 30, fontWeight: FontWeight.bold);

  late List<Widget> _widgetOptions;
  _DashboardScreenState() {
    _widgetOptions = <Widget>[
      const ProjectStudentContent(),
      const DashboardCompany(), // Display dashboard content
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
    // context.read<UserProfileBloc>().add(const GetUserProfile());
    BlocProvider.of<UserProfileBloc>(context).add(const GetUserProfile());
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
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
    // log('userProfileState.userProfile.roles: ${userProfileState.userProfile}');
    final companyId = userProfileState.userProfile.company?.id;
    return BlocBuilder<RoleBloc, RoleState>(
      builder: (context, state) {
        if (state is RoleLoaded) {
          log('ROLE IN DASHBOARD: ${state.role}');
          if (state.role == Role.Company) {
            // Company role
            _widgetOptions = <Widget>[
              const ProjectStudentContent(),
              const DashboardCompany(),
              const MessagePage(
                projectId: 0,
              ),
              const NotificationPage(),
            ];
          } else if (state.role == Role.Student) {
            // Student role
            _widgetOptions = <Widget>[
              const ProjectStudentContent(),
              StudentDashboardContent(),
              const MessagePage(
                projectId: 0,
              ),
              const NotificationPage(),
            ];
          }
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
                appBar: const AppBarBackProfile(),
                body: IndexedStack(
                  index: _selectedIndex,
                  children: _widgetOptions,
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
}
