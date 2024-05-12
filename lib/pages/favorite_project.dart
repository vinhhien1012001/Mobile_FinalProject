import 'dart:developer';

import 'package:final_project_mobile/features/project/bloc/project_bloc.dart';
import 'package:final_project_mobile/features/project/bloc/project_event.dart';
import 'package:final_project_mobile/features/user/bloc/user_bloc.dart';
import 'package:final_project_mobile/models/project.dart';
import 'package:final_project_mobile/widgets/custom_app_bar.dart';
import 'package:final_project_mobile/widgets/project_widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class FavoriteProjectsScreen extends StatefulWidget {
  const FavoriteProjectsScreen({Key? key}) : super(key: key);

  @override
  State<FavoriteProjectsScreen> createState() => _FavoriteProjectsScreenState();
}

class _FavoriteProjectsScreenState extends State<FavoriteProjectsScreen> {
  final TextEditingController _searchController = TextEditingController();
  List<Project> _filteredProjects = [];
  List<Project> _allProjects = [];

  @override
  void initState() {
    super.initState();
    final userProfile =
        BlocProvider.of<UserProfileBloc>(context).state.userProfile;
    BlocProvider.of<ProjectBloc>(context).add(
        GetFavoriteProjectsByStudentId(studentId: userProfile.student!.id));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(),
      body: BlocListener<ProjectBloc, ProjectState>(
        listener: (context, state) {
          if (state is FavoriteProjectsLoadSuccess) {
            setState(() {
              _allProjects = state.projects;
              _filteredProjects = _allProjects;
            });
            log('FavoriteProjectsLoadSuccess, projects: $_filteredProjects');
          }
          if (state is FavoriteProjectUpdateSuccess) {
            setState(() {
              _allProjects
                  .removeWhere((element) => element.id == state.projectId);
              _filteredProjects = _allProjects;
            });
          }
        },
        child: Container(
          padding: const EdgeInsets.all(20),
          child: Column(
            children: [
              TextField(
                controller: _searchController,
                onChanged: _filterProjects,
                decoration: const InputDecoration(
                  hintText: 'Search projects',
                  prefixIcon: Icon(Icons.search),
                ),
              ),
              Expanded(
                child: ProjectWidgets.buildProjectList(_filteredProjects),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _filterProjects(String query) {
    setState(() {
      _filteredProjects = _allProjects
          .where((project) =>
              project.title!.toLowerCase().contains(query.toLowerCase()))
          .toList();
    });
  }
}
