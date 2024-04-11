import 'package:final_project_mobile/widgets/custom_app_bar.dart';
import 'package:final_project_mobile/pages/post_jobs_step.dart';
import 'package:final_project_mobile/pages/sub-pages/project_student.dart';
import 'package:final_project_mobile/widgets/project_widgets.dart';
import 'package:flutter/material.dart';

class DashboardScreen extends StatefulWidget {
  const DashboardScreen({super.key});

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  int _selectedIndex = 0;
  static const TextStyle optionStyle =
      TextStyle(fontSize: 30, fontWeight: FontWeight.bold);

  late final List<Widget> _widgetOptions;
  _DashboardScreenState() {
    _widgetOptions = <Widget>[
      const ProjectStudentContent(),
      dashboardContent(), // Display dashboard content
      const Text(
        'Index 2: Message',
        style: optionStyle,
      ),
      const Text(
        'Index 3: Alerts',
        style: optionStyle,
      ),
    ];
  }

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
        child: _widgetOptions.elementAt(_selectedIndex),
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

  Widget dashboardContent() {
    List<Map<String, dynamic>> allProjects = [
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
    List<Map<String, dynamic>> archivedProjects = [
      {
        'title': 'Super frontend developer (fintech)',
        'created': '3 days ago',
        'proposals': 11,
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
    return Padding(
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
                        ProjectWidgets.buildProjectList(
                            allProjects), // All projects tab
                        ProjectWidgets.buildProjectList(
                            archivedProjects), // All projects tab
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
