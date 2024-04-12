import 'package:final_project_mobile/widgets/custom_app_bar.dart';
import 'package:final_project_mobile/widgets/project_widgets.dart';
import 'package:flutter/material.dart';

class SavedProjectScreen extends StatelessWidget {
  final List<Map<String, dynamic>> allProjects = [
    {
      'title': 'Lalala',
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
  ];

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
