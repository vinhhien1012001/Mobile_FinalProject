
import 'package:final_project_mobile/widgets/project_widgets.dart';
import 'package:flutter/material.dart';
part "../../widgets/search_bar.dart";

class ProjectStudentContent extends StatefulWidget {
  const ProjectStudentContent({super.key});

  @override
  _ProjectStudentContentState createState() => _ProjectStudentContentState();
}

class _ProjectStudentContentState extends State<ProjectStudentContent> {
  // Define a list to hold all projects
  List<Map<String, dynamic>> projects = [
    {
      'title': 'Senior frontend developer (fintech)',
      'created': '3 days ago',
      'proposals': 10,
      'messages': 5,
      'hired': 3,
    },
    {
      'title': 'Senior frontend developer (fintech)',
      'created': '3 days ago',
      'proposals': 10,
      'messages': 5,
      'hired': 3,
    },
    {
      'title': 'Senior frontend developer (fintech)',
      'created': '3 days ago',
      'proposals': 10,
      'messages': 5,
      'hired': 3,
    },
    {
      'title': '121312',
      'created': '3 days ago',
      'proposals': 10,
      'messages': 5,
      'hired': 3,
    },
  ];

  // Define a list to hold filtered projects
  List<Map<String, dynamic>> filteredProjects = [];

  @override
  void initState() {
    super.initState();
    // Initialize filteredProjects with all projects initially
    filteredProjects.addAll(projects);
  }

  // Implement onChanged callback to filter projects based on search text
  void _onSearchTextChanged(String searchText) {
    setState(() {
      filteredProjects.clear();
      if (searchText.isEmpty) {
        // If search text is empty, show all projects
        filteredProjects.addAll(projects);
      } else {
        // Filter projects based on search text
        filteredProjects.addAll(projects.where((project) {
          return project['title']
              .toLowerCase()
              .contains(searchText.toLowerCase());
        }));
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(20),
      child: Column(
        children: [
          // Pass onChanged callback to SearchBar
          SearchBar(
            onChanged: _onSearchTextChanged,
          ),
          Expanded(
            // Pass filtered projects to buildProjectList method
            child: ProjectWidgets.buildProjectList(filteredProjects),
          ),
        ],
      ),
    );
  }
}
