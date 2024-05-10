import 'dart:developer';

import 'package:final_project_mobile/features/project/bloc/project_bloc.dart';
import 'package:final_project_mobile/features/project/bloc/project_event.dart';
import 'package:final_project_mobile/features/selectRole/bloc/role_bloc.dart';
import 'package:final_project_mobile/features/user/bloc/user_bloc.dart';
import 'package:final_project_mobile/models/project.dart';
import 'package:final_project_mobile/pages/project_detail_student.dart';
import 'package:final_project_mobile/pages/project_details_company.dart';
import 'package:final_project_mobile/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:toastification/toastification.dart';

// Import the project detail screen

enum ProjectAction {
  viewProposal,
  viewMessage,
  viewHired,
  viewJobPosting,
  editPosting,
  removePosting,
  addToFavorite,
}

class ProjectWidgets {
  static Widget buildProjectList(List<Project> projects) {
    return BlocBuilder<RoleBloc, RoleState>(
      builder: (context, state) {
        return ListView.builder(
          itemCount: projects.length,
          itemBuilder: (context, index) {
            final project = projects[index];
            return GestureDetector(
              onTap: () {
                // Navigate to project detail screen when clicked
                if (state is RoleSelected && state.roleId == 0) {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) =>
                            ProjectDetailsStudent(project: project)),
                  );
                } else {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) =>
                            ProjectDetailsCompany(project: project)),
                  );
                }
              },
              child: ProjectWidgets.buildProjectCard(
                projectId: project.id!,
                title: project.title ?? '',
                created: project.createdAt!,
                proposalsCount: project.countProposals!,
                messages: project.countMessages ?? 0,
                hired: project.countHired ?? 0,
                description: project.description!,
                isFavorite: project.isFavorite ?? true,
                numberOfStudent: project.numberOfStudents ?? 0,
                projectScopeFlag: project.projectScopeFlag ?? 0,
                context: context,
              ),
            );
          },
        );
      },
    );
  }

  static Widget notifTitle(String title) {
    return Text(
      title,
      style: const TextStyle(
        color: Colors.blueAccent,
        fontSize: 18,
        fontWeight: FontWeight.bold,
      ),
    );
  }

  static Widget buildProjectCard({
    required String title,
    required String created,
    required int proposalsCount,
    required int messages,
    required int hired,
    required int projectId,
    required BuildContext context,
    required String description,
    required bool isFavorite,
    required int projectScopeFlag,
    required int numberOfStudent,
  }) {
    String createdAt = DateFormat('dd/MM/yyyy').format(DateTime.parse(created));
    final userProfile = context.read<UserProfileBloc>().state.userProfile;
    return BlocListener<ProjectBloc, ProjectState>(
      listener: (context, state) {
        if (state is ProjectDeleteSuccess &&
            state.projectId == projectId.toString()) {
          toastification.show(
            context: context,
            type: ToastificationType.success,
            style: ToastificationStyle.flat,
            title: const Text('Delete project successfully'),
            alignment: Alignment.bottomRight,
            autoCloseDuration: const Duration(seconds: 4),
            icon: const Icon(Icons.check),
            borderRadius: BorderRadius.circular(12.0),
            showProgressBar: true,
          );
        }
      },
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
                      title.toUpperCase(),
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
                  IconButton(
                    icon: isFavorite
                        ? const Icon(
                            Icons.favorite_border,
                            color: Colors.redAccent,
                          )
                        : const Icon(Icons.favorite_border),
                    onPressed: () {
                      BlocProvider.of<ProjectBloc>(context).add(
                        UpdateFavoriteProject(
                          studentId: userProfile.student!.id,
                          projectId: projectId,
                          disableFlag: isFavorite ? 1 : 0,
                        ),
                      );
                    },
                  ),
                  PopupMenuButton<ProjectAction>(
                    onSelected: (ProjectAction result) {
                      switch (result) {
                        case ProjectAction.removePosting:
                          BlocProvider.of<ProjectBloc>(context).add(
                              DeleteProject(projectId: projectId.toString()));
                          break;
                        case ProjectAction.editPosting:
                          break;
                        default:
                      }
                    },
                    itemBuilder: (BuildContext context) =>
                        <PopupMenuEntry<ProjectAction>>[
                      const PopupMenuItem<ProjectAction>(
                        value: ProjectAction.removePosting,
                        child: Text('Remove posting'),
                      ),
                      const PopupMenuItem<ProjectAction>(
                        value: ProjectAction.editPosting,
                        child: Text('Edit posting'),
                      ),
                      const PopupMenuItem<ProjectAction>(
                        value: ProjectAction.addToFavorite,
                        child: Text('Add to favorite'),
                      ),
                    ],
                  ),
                ],
              ),
              Text(
                'Created $createdAt',
                style: const TextStyle(color: Colors.grey),
              ),
              const SizedBox(height: 10),
              Row(
                children: [
                  const Icon(Icons.people),
                  const SizedBox(width: 10),
                  Text(
                    '$numberOfStudent',
                    style: const TextStyle(color: Colors.grey),
                  ),
                  const SizedBox(width: 30),
                  const Icon(Icons.access_time),
                  const SizedBox(width: 5),
                  Text(
                    // '${projectScopeFlag == 0 ? 'Public' : 'Private'}',
                    switch (projectScopeFlag) {
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
                          description.toCapitalized(),
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
                  ProjectWidgets.buildStatusColumn('Proposals', proposalsCount),
                  ProjectWidgets.buildStatusColumn('Messages', messages),
                  ProjectWidgets.buildStatusColumn('Hired', hired),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  static Widget buildStatusColumn(String label, int value) {
    return Column(
      children: [
        Text(
          '$value',
          style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),
        Text(label),
      ],
    );
  }
}
