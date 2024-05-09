import 'package:final_project_mobile/features/project/bloc/project_bloc.dart';
import 'package:final_project_mobile/features/project/bloc/project_event.dart';
import 'package:final_project_mobile/models/project.dart';
import 'package:flutter/material.dart';
import 'package:final_project_mobile/pages/favorite_project.dart';
import 'package:final_project_mobile/widgets/project_widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
part "../../widgets/search_bar.dart";

class ProjectStudentContent extends StatefulWidget {
  const ProjectStudentContent({super.key});

  @override
  State<ProjectStudentContent> createState() => _ProjectStudentContentState();
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
    BlocProvider.of<ProjectBloc>(context).add(GetProject());
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

  void _onFavoriteProjectsClicked() {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => FavoriteProjectsScreen(),
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
    if (projectLengthFilter.isEmpty) {
      return true; // No filter applied, so all projects pass
    }

    switch (projectLengthFilter) {
      case 'Less than 1 month':
        return project.projectScopeFlag == 0;
      case '1 to 3 months':
        return project.projectScopeFlag == 1;
      case '3 to 6 months':
        return project.projectScopeFlag == 2;
      case 'More than 6 months':
        return project.projectScopeFlag == 3;
      default:
        return true; // Default to true if the filter doesn't match any case
    }
  }

  bool _checkStudentNeeded(Project project) {
    if (project.numberOfStudents == null) {
      return true;
    }
    return project.numberOfStudents! >= studentNeededFilter;
  }

  bool _checkProposalCount(Project project) {
    return project.countProposals! <= proposalLessThanFilter;
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ProjectBloc, ProjectState>(
      builder: (context, state) {
        if (state is ProjectLoadSuccess) {
          projects = state.projects;
          filteredProjects.addAll(projects);
        }
        if (state is ProjectDeleteSuccess) {
          filteredProjects
              .removeWhere((project) => "${project.id}" == state.projectId);
        }
        if (state is FavoriteProjectUpdateSuccess) {
          filteredProjects
              .where((element) => element.id == state.projectId)
              .forEach((element) {
            element.isFavorite = !state.disableFlag;
          });
        }
        return Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            children: [
              SearchBar(
                onChanged: _onSearchTextChanged,
                onFavoritePressed: _onFavoriteProjectsClicked,
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
      },
    );
  }
}
