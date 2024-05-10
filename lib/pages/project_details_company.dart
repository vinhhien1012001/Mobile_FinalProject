import 'package:final_project_mobile/models/project.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class ProjectDetailsCompany extends StatefulWidget {
  final Project project;

  const ProjectDetailsCompany({Key? key, required this.project})
      : super(key: key);

  @override
  State<ProjectDetailsCompany> createState() => _ProjectDetailsCompanyState();
}

class _ProjectDetailsCompanyState extends State<ProjectDetailsCompany>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 4, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(''),
        bottom: TabBar(
          controller: _tabController,
          tabs: [
            Tab(text: 'Proposal'),
            Tab(text: 'Details'),
            Tab(text: 'Message'),
            Tab(text: 'Hired'),
          ],
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: TabBarView(
          controller: _tabController,
          children: [
            SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 20),
                  const Text(
                    'Student Profiles',
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 10),
                  SizedBox(
                    height: MediaQuery.of(context).size.height,
                    child: ListView.builder(
                      itemCount: 10, // Example count
                      itemBuilder: (context, index) {
                        // Return a Student Profile Card widget
                        return const StudentProfileCard();
                      },
                    ),
                  ),
                ],
              ),
            ),
            Center(child: Text('Details Tab')),
            Center(child: Text('Message Tab')),
            Center(child: Text('Hired Tab')),
          ],
        ),
      ),
    );
  }
}

class StudentProfileCard extends StatelessWidget {
  const StudentProfileCard({Key? key});

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 10),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                // Image widget
                CircleAvatar(
                  radius: 30,
                  // Replace with actual image
                  backgroundImage:
                      NetworkImage('https://via.placeholder.com/150/92c952'),
                ),
                SizedBox(width: 10),
                // Student name and number of years student
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Student Name',
                      style:
                          TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(height: 5),
                    Text('Number of years student'),
                  ],
                ),
              ],
            ),
            const SizedBox(height: 10),
            const Divider(),
            // Job title and Level
            const SizedBox(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Job title',
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                Text(
                  'Level: Excellent',
                  style: TextStyle(color: Colors.green),
                ),
              ],
            ),
            const SizedBox(height: 10),
            // Self proposal
            const Text(
              'Self proposal: Lorem ipsum dolor sit amet, consectetur adipiscing elit. Nulla vitae felis nec tortor euismod sagittis. Cras eu arcu id urna tempor lacinia.',
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
            ),
            const SizedBox(height: 10),
            // Buttons
            Row(
              children: [
                // Button 1
                Expanded(
                  child: ElevatedButton(
                    onPressed: () {},
                    child: const Text('Message'),
                  ),
                ),
                const SizedBox(width: 10),
                // Button 2
                Expanded(
                  child: ElevatedButton(
                    onPressed: () {},
                    child: const Text('Hire'),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
