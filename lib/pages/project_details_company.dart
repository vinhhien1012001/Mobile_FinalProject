import 'package:final_project_mobile/models/project.dart';
import 'package:final_project_mobile/pages/project_detail_student.dart';
import 'package:final_project_mobile/widgets/project_widgets.dart';
import 'package:flutter/material.dart';

class ProjectDetailsCompany extends StatefulWidget {
  final Project project;

  const ProjectDetailsCompany({super.key, required this.project});

  @override
  State<ProjectDetailsCompany> createState() => _ProjectDetailsCompanyState();
}

class _ProjectDetailsCompanyState extends State<ProjectDetailsCompany>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  Project? project;

  @override
  void initState() {
    super.initState();
    project = widget.project;
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
        automaticallyImplyLeading: true,
        title: const Text('StudentHub'),
        centerTitle: false,
        backgroundColor: Colors.blue,
        bottom: TabBar(
          controller: _tabController,
          tabs: const [
            Tab(
              text: 'Proposal',
            ),
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
            Column(
              children: [
                // Center(
                //   child: ProjectWidgets.buildProjectCard(
                //       title: project?.title ?? '',
                //       created: project?.createdAt ?? '',
                //       proposalsCount: project?.countProposals ?? 0,
                //       messages: project?.countMessages ?? 0,
                //       hired: project?.countHired ?? 0,
                //       projectId: project?.id ?? 0,
                //       context: context,
                //       description: project?.description ?? '',
                //       isFavorite: project?.isFavorite ?? true,
                //       projectScopeFlag: project?.projectScopeFlag ?? 0,
                //       numberOfStudent: project?.numberOfStudents ?? 0),
                // ),
                BuildProjectDetails(project: project ?? Project()),
              ],
            ),
            const Center(child: Text('Message Tab')),
            const Center(child: Text('Hired Tab')),
          ],
        ),
      ),
    );
  }
}

class StudentProfileCard extends StatelessWidget {
  const StudentProfileCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 10),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Row(
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
                    SizedBox(height: 5),
                    Text('Number of years student'),
                  ],
                ),
              ],
            ),
            const SizedBox(height: 10),
            const Divider(),
            // Job title and Level
            const SizedBox(height: 10),
            const Row(
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
