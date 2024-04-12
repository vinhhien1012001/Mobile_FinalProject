import 'package:final_project_mobile/widgets/custom_app_bar.dart';
import 'package:final_project_mobile/widgets/custom_button.dart';
import 'package:flutter/material.dart';

class ProjectDetailsStudent extends StatelessWidget {
  const ProjectDetailsStudent({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      appBar: CustomAppBar(),
      body: Padding(
        padding: EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Project details',
              style: TextStyle(fontSize: 24.0, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 8.0),
            Text(
              'Title of the job: Senior frontend developer (fintech)',
            ),
            SizedBox(height: 8.0),
            Divider(),
            SizedBox(height: 8.0),
            Text(
              'Students are looking for:',
              style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 4.0),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('- Clear expectations'),
                Text('- The skills required'),
                Text('- Details'),
              ],
            ),
            Divider(),
            Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Icon(Icons.alarm),
                    SizedBox(width: 12.0),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('Project scope:'),
                          Text('  • 3 to 6 months'),
                        ],
                      ),
                    ),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Icon(Icons.people),
                    SizedBox(width: 12.0),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('Student required:'),
                          Text('  • 6 to 10 students'),
                        ],
                      ),
                    ),
                  ],
                ),
              ],
            ),
            Spacer(
              flex: 1,
            ),
            Padding(
              padding: EdgeInsets.only(bottom: 20.0),
              child: Row(
                children: [
                  CustomButton(
                    text: 'Apply Now',
                    width: 140,
                  ),
                  Spacer(),
                  CustomButton(
                    text: 'Saved',
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
