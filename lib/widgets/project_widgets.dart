import 'dart:developer';

import 'package:final_project_mobile/features/project/bloc/project_bloc.dart';
import 'package:final_project_mobile/features/project/bloc/project_event.dart';
import 'package:final_project_mobile/models/project.dart';
import 'package:final_project_mobile/pages/project_detail_student.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:toastification/toastification.dart';

// Import the project detail screen

enum ProjectAction {
  viewProposal,
  viewMessage,
  viewHired,
  viewJobPosting,
  editPosting,
  removePosting
}

class ProjectWidgets {
  static Widget buildProjectList(List<Project> projects) {
    log("projects.toString() ${projects.toString()}");
    return ListView.builder(
      itemCount: projects.length,
      itemBuilder: (context, index) {
        final project = projects[index];
        return GestureDetector(
          onTap: () {
            // Navigate to project detail screen when clicked
            Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => const ProjectDetailsStudent()),
            );
          },
          child: ProjectWidgets.buildProjectCard(
            projectId: project.id!,
            title: project.title!,
            created: project.createdAt!,
            proposals: 1,
            messages: project.numberOfStudents!,
            hired: project.numberOfStudents!,
            context: context,
          ),
        );
      },
    );
  }

  static Widget notifTitle(String title) {
    return Text(
      title,
      style: const TextStyle(
        fontSize: 18,
        fontWeight: FontWeight.bold,
      ),
    );
  }

  static Widget buildProjectCard({
    required String title,
    required String created,
    required int proposals,
    required int messages,
    required int hired,
    required int projectId,
    required BuildContext context,
  }) {
    return BlocListener<ProjectBloc, ProjectState>(
      listener: (context, state) {
        if (state is ProjectDeleteSuccess &&
            state.projectId == projectId.toString()) {
          toastification.show(
            context: context,
            type: ToastificationType.success,
            style: ToastificationStyle.flat,
            title: Text('Delete project successfully'),
            alignment: Alignment.bottomRight,
            autoCloseDuration: const Duration(seconds: 4),
            icon: Icon(Icons.check),
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
                      title,
                      style: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  PopupMenuButton<ProjectAction>(
                    onSelected: (ProjectAction result) {
                      switch (result) {
                        case ProjectAction.removePosting:
                          BlocProvider.of<ProjectBloc>(context).add(
                              DeleteProject(projectId: projectId.toString()));
                          break;
                        case ProjectAction.editPosting:
                          // Handle delete project
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
                    ],
                  ),
                ],
              ),
              Text(
                'Created $created',
                style: const TextStyle(color: Colors.grey),
              ),
              const SizedBox(height: 10),
              const Text(
                'Student are looking for',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 10),
              const Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: EdgeInsets.only(left: 20),
                    child: Column(
                      children: [
                        Text(
                          '• Clear expectations about your project or deliverables',
                        ),
                        Text(
                          '• Clear expectations about your project or deliverables',
                        ),
                        Text(
                          '• Clear expectations about your project or deliverables',
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
                  ProjectWidgets.buildStatusColumn('Proposals', proposals),
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
