import 'package:final_project_mobile/pages/project_detail_student.dart';
import 'package:flutter/material.dart';
// Import the project detail screen

class ProjectWidgets {
  static Widget buildProjectList(List<Map<String, dynamic>> projects) {
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
            title: project['title'],
            created: project['created'],
            proposals: project['proposals'],
            messages: project['messages'],
            hired: project['hired'],
          ),
        );
      },
    );
  }

  static Widget buildProjectCard({
    required String title,
    required String created,
    required int proposals,
    required int messages,
    required int hired,
  }) {
    return Card(
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
                IconButton(
                  onPressed: () {
                    // Handle edit project
                  },
                  icon: const Icon(Icons.more_vert),
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
