import 'dart:math';

import 'package:final_project_mobile/features/proposal/bloc/proposal_bloc.dart';
import 'package:final_project_mobile/models/project.dart';
import 'package:final_project_mobile/models/proposal.dart';
import 'package:final_project_mobile/pages/project_detail_student.dart';
import 'package:final_project_mobile/pages/sub-pages/message.dart';
import 'package:final_project_mobile/pages/sub-pages/message_conversation.dart';
import 'package:final_project_mobile/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:toastification/toastification.dart';

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
  List<Proposal> proposals = [];

  @override
  void initState() {
    super.initState();
    project = widget.project;
    BlocProvider.of<ProposalBloc>(context)
        .add(GetProposalsByProjectId(projectId: project?.id ?? 0));
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
                  BlocConsumer<ProposalBloc, ProposalState>(
                    builder: (context, state) {
                      if (state is ProposalsByProjectIdLoaded &&
                          state.projectId == project?.id) {
                        print('project id: ${project?.id}');
                        proposals = state.proposals;
                        return ListView.builder(
                          shrinkWrap: true, // Set shrinkWrap to true
                          physics:
                              const NeverScrollableScrollPhysics(), // Disable scrolling for the ListView
                          itemCount: proposals.length,
                          itemBuilder: (context, index) {
                            return StudentProfileCard(
                                proposal: proposals[index]);
                          },
                        );
                      } else if (state is ProposalOperationFailure) {
                        return const Center(
                          child: Text("No proposals found"),
                        );
                      } else {
                        return const Center(
                          child: CircularProgressIndicator(),
                        );
                      }
                    },
                    listener: (BuildContext context, ProposalState state) {
                      if (state is SendHireOfferSuccess) {
                        toastification.show(
                          context: context,
                          type: ToastificationType.success,
                          style: ToastificationStyle.flat,
                          title: Text(
                              'Send hire offer to student with id : ${state.proposal.student?.id ?? 0} successfully !'),
                          alignment: Alignment.bottomRight,
                          autoCloseDuration: const Duration(seconds: 4),
                          icon: const Icon(Icons.check),
                          borderRadius: BorderRadius.circular(12.0),
                          showProgressBar: true,
                        );
                      }
                    },
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
            Center(
                child: MessagePage(
              projectId: project?.id ?? 0,
            )),
            const Center(child: Text('Hired Tab')),
          ],
        ),
      ),
    );
  }
}

class StudentProfileCard extends StatefulWidget {
  const StudentProfileCard({super.key, required this.proposal});
  final Proposal proposal;

  @override
  State<StudentProfileCard> createState() => _StudentProfileCardState();
}

class _StudentProfileCardState extends State<StudentProfileCard> {
  late int randomAvatarNumber = 1;
  late bool hireSent;

  @override
  void initState() {
    super.initState();
    randomAvatarNumber = Random().nextInt(10) + 1;
    print('Proposal status flag: ${widget.proposal.statusFlag}');
    hireSent = widget.proposal.statusFlag == 2;
  }

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
                  backgroundImage: NetworkImage(
                      'https://raw.githubusercontent.com/mantinedev/mantine/master/.demo/avatars/avatar-$randomAvatarNumber.png'),
                ),
                const SizedBox(width: 10),
                // Student name and number of years student
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      widget.proposal.student?.user?.fullname ?? '',
                      style: const TextStyle(
                          fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(height: 5),
                    const Text('No education yet'),
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
                  widget.proposal.student?.techStack?.name ?? 'No title yet !',
                  style: const TextStyle(fontWeight: FontWeight.bold),
                ),
                const Text(
                  'Level: Excellent',
                  style: TextStyle(color: Colors.green),
                ),
              ],
            ),
            const SizedBox(height: 10),
            // Self proposal
            Text(
              widget.proposal.coverLetter.toString().toCapitalized(),
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
            ),
            const SizedBox(height: 10),
            // Buttons
            Row(
              children: [
                Expanded(
                  child: ElevatedButton(
                    onPressed: () {
                      // Send message
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => MessagesDetails(
                              projectId: widget.proposal.projectId ?? 0,
                              recipientId:
                                  widget.proposal.student?.userId ?? 0),
                        ),
                      );
                    },
                    child: const Text('Message'),
                  ),
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: ElevatedButton(
                    onPressed: hireSent
                        ? null
                        : () => _showConfirmationDialog(context),
                    child: Text(hireSent ? 'Sent hired offer' : 'Hire'),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  void _showConfirmationDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text("Hire offer"),
          content: const Text(
              "Do you really want to send a hire offer for this project?"),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(); // Close dialog
              },
              child: const Text("Cancel"),
            ),
            TextButton(
              onPressed: () {
                // Send hire offer
                BlocProvider.of<ProposalBloc>(context).add(SendHireOffer(
                  proposalId: widget.proposal.id.toString(),
                  disableFlag: 0,
                  statusFlag: 2,
                ));
                setState(() {
                  hireSent = true;
                });
                Navigator.of(context).pop(); // Close dialog
              },
              child: const Text("Send"),
            ),
          ],
        );
      },
    );
  }
}
