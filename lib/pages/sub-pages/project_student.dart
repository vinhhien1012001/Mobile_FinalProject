import 'package:final_project_mobile/models/project.dart';
import 'package:flutter/material.dart';
import 'package:final_project_mobile/pages/saved_project.dart';
import 'package:final_project_mobile/widgets/project_widgets.dart';
part "../../widgets/search_bar.dart";

class ProjectStudentContent extends StatefulWidget {
  const ProjectStudentContent({super.key});

  @override
  _ProjectStudentContentState createState() => _ProjectStudentContentState();
}

class _ProjectStudentContentState extends State<ProjectStudentContent> {
  List<Project> projects = [];

  List<Project> filteredProjects = [];
  bool isFilterApplied = false;
  String projectLengthFilter = '';
  int studentNeededFilter = 0;
  int proposalLessThanFilter = 0;
  bool _isTyping = false;

  @override
  void initState() {
    super.initState();
    filteredProjects.addAll(projects);
  }

  void _onSearchTextChanged(String searchText) {
    setState(() {
      _isTyping = searchText.isNotEmpty;
      filteredProjects.clear();
      if (searchText.isEmpty) {
        filteredProjects.addAll(projects);
      } else {
        filteredProjects.addAll(projects.where((project) {
          return (project.title
                  ?.toLowerCase()
                  .contains(searchText.toLowerCase())) ??
              false;
        }));
      }
    });
  }

  void _onSavedProjectsClicked() {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => SavedProjectScreen(),
      ),
    );
  }

  void _showFilterModal() {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (BuildContext context) {
        return StatefulBuilder(
          builder: (BuildContext context, StateSetter setState) {
            return Container(
              padding: const EdgeInsets.all(20),
              height: MediaQuery.of(context).size.height * 2 / 3,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      IconButton(
                        icon: const Icon(Icons.close),
                        onPressed: () {
                          Navigator.of(context).pop();
                        },
                      ),
                      const Text(
                        'Filter by',
                        style: TextStyle(fontSize: 20),
                      ),
                      const SizedBox(width: 48),
                    ],
                  ),
                  const Divider(),
                  const Text(
                    'Project length',
                    style: TextStyle(fontSize: 16),
                  ),
                  DropdownButton<String?>(
                    value: projectLengthFilter.isNotEmpty
                        ? projectLengthFilter
                        : null,
                    onChanged: (String? newValue) {
                      setState(() {
                        projectLengthFilter = newValue ?? '';
                      });
                    },
                    items: <String>[
                      '', // Add an empty string as the default value
                      'Less than 1 month',
                      '1 to 3 months',
                      '3 to 6 months',
                      'More than 6 months',
                    ].map<DropdownMenuItem<String>>((String value) {
                      return DropdownMenuItem<String>(
                        value: value,
                        child: Text(value),
                      );
                    }).toList(),
                  ),
                  const SizedBox(height: 20),
                  const Text(
                    'Student needed',
                    style: TextStyle(fontSize: 16),
                  ),
                  TextField(
                    onChanged: (value) {
                      setState(() {
                        studentNeededFilter = int.tryParse(value) ?? 0;
                      });
                    },
                    keyboardType: TextInputType.number,
                    decoration: const InputDecoration(
                      hintText: 'Enter number of students needed',
                    ),
                  ),
                  const SizedBox(height: 20),
                  const Text(
                    'Proposal less than',
                    style: TextStyle(fontSize: 16),
                  ),
                  TextField(
                    onChanged: (value) {
                      setState(() {
                        proposalLessThanFilter = int.tryParse(value) ?? 0;
                      });
                    },
                    keyboardType: TextInputType.number,
                    decoration: const InputDecoration(
                      hintText: 'Enter number of proposals',
                    ),
                  ),
                  const SizedBox(height: 20),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      ElevatedButton(
                        onPressed: () {
                          setState(() {
                            isFilterApplied = false;
                            projectLengthFilter = '';
                            studentNeededFilter = 0;
                            proposalLessThanFilter = 0;
                          });
                          Navigator.pop(context);
                          _applyFilters();
                        },
                        child: const Text('Clear Filter'),
                      ),
                      const SizedBox(width: 10),
                      ElevatedButton(
                        onPressed: () {
                          Navigator.pop(context);
                          _applyFilters();
                        },
                        child: const Text('Apply'),
                      ),
                    ],
                  ),
                ],
              ),
            );
          },
        );
      },
    );
  }

  void _applyFilters() {
    filteredProjects.clear();
    filteredProjects.addAll(projects.where((project) {
      bool meetsCriteria = true;
      meetsCriteria = _checkProjectLength(project);
      meetsCriteria = meetsCriteria && _checkStudentNeeded(project);
      meetsCriteria = meetsCriteria && _checkProposalCount(project);
      return meetsCriteria;
    }));
    setState(() {
      isFilterApplied = true;
    });
  }

  bool _checkProjectLength(Project project) {
    // Implement logic to check project length
    return true; // Placeholder logic, replace with actual logic
  }

  bool _checkStudentNeeded(Project project) {
    // Implement logic to check student needed
    return true; // Placeholder logic, replace with actual logic
  }

  bool _checkProposalCount(Project project) {
    // Implement logic to check proposal count
    return true; // Placeholder logic, replace with actual logic
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(20),
      child: Column(
        children: [
          SearchBar(
            onChanged: _onSearchTextChanged,
            onFavoritePressed: _onSavedProjectsClicked,
            isFilterApplied: isFilterApplied,
            isTyping: _isTyping,
            onFilterPressed: _showFilterModal,
          ),
          Expanded(
            child: ProjectWidgets.buildProjectList(filteredProjects),
          ),
        ],
      ),
    );
  }
}
