import 'package:flutter/material.dart';

class StudentDashboardContent extends StatelessWidget {
  const StudentDashboardContent({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: double.infinity,
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Padding(
              padding: EdgeInsets.only(left: 16, top: 0, bottom: 10),
              child: Text(
                'Your Projects',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            DefaultTabController(
              length: 3,
              child: Column(
                children: [
                  const TabBar(
                    tabs: [
                      Tab(text: 'All Projects'),
                      Tab(text: 'Working'),
                      Tab(text: 'Archived'),
                    ],
                  ),
                  SizedBox(
                    height: MediaQuery.of(context).size.height /
                        2, // Adjust as needed
                    child: TabBarView(
                      children: [
                        // Content for 'All Projects' tab
                        Column(
                          children: [
                            Expanded(
                              child: ListView.builder(
                                itemCount: 2,
                                itemBuilder: (context, index) {
                                  return Container(
                                    margin: const EdgeInsets.all(16),
                                    decoration: BoxDecoration(
                                      border: Border.all(color: Colors.grey),
                                      borderRadius: BorderRadius.circular(8),
                                    ),
                                    child: const Padding(
                                      padding: EdgeInsets.only(
                                          left: 16,
                                          top: 16,
                                          right: 16,
                                          bottom: 8),
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          // Active Proposals heading

                                          SizedBox(height: 8),
                                          Text(
                                            'Title',
                                            style: TextStyle(
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                          Text(
                                            'Submitted (time ago)',
                                            style: TextStyle(
                                              fontSize: 12,
                                              color: Colors.grey,
                                            ),
                                          ),
                                          SizedBox(height: 8),
                                          // Replace with your actual list
                                          Text('List item 1'),
                                          Text('List item 2'),
                                          Text('List item 3'),
                                        ],
                                      ),
                                    ),
                                  );
                                },
                              ),
                            ),
                          ],
                        ),
                        // Content for 'Working' tab (Replace with actual content)
                        const Center(
                          child: Text('Working Projects'),
                        ),
                        // Content for 'Archived' tab (Replace with actual content)
                        const Center(
                          child: Text('Archived Projects'),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
