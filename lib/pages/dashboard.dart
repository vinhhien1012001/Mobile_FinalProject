import 'package:final_project_mobile/components/custom_app_bar.dart';
import 'package:final_project_mobile/pages/post_jobs_step.dart';
import 'package:flutter/material.dart';

class DashboardScreen extends StatefulWidget {
  const DashboardScreen({super.key});

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  int _selectedIndex = 1;

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Padding(
                    padding: EdgeInsets.only(top: 20),
                    child: Text('Your projects'), // Changed from 'Your jobs'
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 20, left: 10),
                    child: ElevatedButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const PostJobStepScreen(),
                          ),
                        );
                      },
                      style: ButtonStyle(
                        shape: MaterialStateProperty.all(
                          RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(0),
                          ),
                        ),
                        foregroundColor: MaterialStateProperty.all(Colors.blue),
                      ),
                      child: const Text('Post a job'),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 30),
              Expanded(
                child: DefaultTabController(
                  length: 2,
                  child: Column(
                    children: [
                      const TabBar(
                        tabs: [
                          Tab(text: 'All projects'),
                          Tab(text: 'Archived projects'),
                        ],
                      ),
                      Expanded(
                        child: TabBarView(
                          children: [
                            _buildProjectList(), // All projects tab
                            _buildArchivedProjectList(), // Archived projects tab
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.list),
            label: 'Projects',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.dashboard),
            label: 'Dashboard',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.message),
            label: 'Message',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.notifications),
            label: 'Alerts',
          ),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: Colors.blue[800],
        unselectedItemColor: Colors.grey,
        onTap: _onItemTapped,
      ),
    );
  }

  Widget _buildProjectList() {
    // Sample project data
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
    ];

    return ListView.builder(
      itemCount: projects.length,
      itemBuilder: (context, index) {
        final project = projects[index];
        return _buildProjectCard(
          title: project['title'],
          created: project['created'],
          proposals: project['proposals'],
          messages: project['messages'],
          hired: project['hired'],
        );
      },
    );
  }

  Widget _buildProjectCard({
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
                        fontSize: 18, fontWeight: FontWeight.bold),
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
                          '• Clear expectations about your project or deliverables'),
                      Text(
                          '• Clear expectations about your project or deliverables'),
                      Text(
                          '• Clear expectations about your project or deliverables'),
                    ],
                  ),
                )
              ],
            ),
            const SizedBox(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                _buildStatusColumn('Proposals', proposals),
                _buildStatusColumn('Messages', messages),
                _buildStatusColumn('Hired', hired),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildStatusColumn(String label, int value) {
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

  Widget _buildArchivedProjectList() {
    // Sample project data
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
    ];

    return ListView.builder(
      itemCount: projects.length,
      itemBuilder: (context, index) {
        final project = projects[index];
        return _buildArchivedProjectsCard(
          title: project['title'],
          created: project['created'],
          proposals: project['proposals'],
          messages: project['messages'],
          hired: project['hired'],
        );
      },
    );
  }

  Widget _buildArchivedProjectsCard({
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
                        fontSize: 18, fontWeight: FontWeight.bold),
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
                          '• Clear expectations about your project or deliverables'),
                      Text(
                          '• Clear expectations about your project or deliverables'),
                      Text(
                          '• Clear expectations about your project or deliverables'),
                    ],
                  ),
                )
              ],
            ),
            const SizedBox(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                _buildStatusColumn('Proposals', proposals),
                _buildStatusColumn('Messages', messages),
                _buildStatusColumn('Hired', hired),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
