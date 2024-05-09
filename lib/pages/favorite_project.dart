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
  const FavoriteProjectsScreen({super.key});

  @override
  State<FavoriteProjectsScreen> createState() => _FavoriteProjectsScreenState();
}

class _FavoriteProjectsScreenState extends State<FavoriteProjectsScreen> {
  @override
  void initState() {
    super.initState();
    // Fetch all projects
    final userProfile =
        BlocProvider.of<UserProfileBloc>(context).state.userProfile;
    BlocProvider.of<ProjectBloc>(context).add(
        GetFavoriteProjectsByStudentId(studentId: userProfile.student!.id));
  }

  final List<Project> allProjects = [];

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ProjectBloc, ProjectState>(
      builder: (context, state) {
        if (state is FavoriteProjectsLoadSuccess) {
          log('FavoriteProjectsLoadSuccess, projects: ${state.projects}');
          allProjects.addAll(state.projects);
        }
        if (state is FavoriteProjectUpdateSuccess) {
          allProjects.removeWhere((element) => element.id == state.projectId);
        }
        return Scaffold(
            appBar: const CustomAppBar(),
            body: Container(
              padding: const EdgeInsets.all(20),
              child: Column(
                children: [
                  Expanded(
                    // Pass filtered projects to buildProjectList method
                    child: ProjectWidgets.buildProjectList(allProjects),
                  ),
                ],
              ),
            ));
      },
    );
  }
}
