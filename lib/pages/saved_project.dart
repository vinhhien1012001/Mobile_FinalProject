import 'package:final_project_mobile/models/project.dart';
import 'package:final_project_mobile/widgets/custom_app_bar.dart';
import 'package:final_project_mobile/widgets/project_widgets.dart';
import 'package:flutter/material.dart';

class SavedProjectScreen extends StatelessWidget {
  final List<Project> allProjects = [];

  SavedProjectScreen({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: const CustomAppBar(),
        body: Column(
          children: [
            Expanded(
              // Pass filtered projects to buildProjectList method
              child: ProjectWidgets.buildProjectList(allProjects),
            ),
          ],
        ));
  }
}
