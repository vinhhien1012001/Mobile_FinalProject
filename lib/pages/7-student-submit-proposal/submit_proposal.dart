import 'package:final_project_mobile/features/proposal/bloc/proposal_bloc.dart';
import 'package:final_project_mobile/features/user/bloc/user_bloc.dart';
import 'package:final_project_mobile/models/project.dart';
import 'package:final_project_mobile/widgets/custom_app_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:toastification/toastification.dart';

class SubmitProposalScreen extends StatefulWidget {
  const SubmitProposalScreen({super.key, required this.project});
  final Project project;

  @override
  State<SubmitProposalScreen> createState() => _SubmitProposalScreenState();
}

class _SubmitProposalScreenState extends State<SubmitProposalScreen> {
  Project? project;
  late final UserProfileBloc userProfileBloc;
  final TextEditingController _coverLetterController =
      TextEditingController(); // Add text controller

  @override
  void initState() {
    super.initState();
    project = widget.project;
    userProfileBloc = BlocProvider.of<UserProfileBloc>(context);
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<ProposalBloc, ProposalState>(
      listener: (context, state) {
        if (state is ProposalCreateNE) {
          toastification.show(
            context: context,
            type: ToastificationType.success,
            style: ToastificationStyle.flat,
            title: Text(
                'Create proposal successfully with cover letter: ${state.proposal?.coverLetter}'),
            alignment: Alignment.bottomRight,
            autoCloseDuration: const Duration(seconds: 4),
            icon: const Icon(Icons.check),
            borderRadius: BorderRadius.circular(12.0),
            showProgressBar: true,
          );
          Navigator.pop(context);
        } else if (state is ProposalOperationFailure) {
          toastification.show(
            context: context,
            type: ToastificationType.error,
            style: ToastificationStyle.flat,
            title: Text('Create proposal failed: ${state.error}'),
            alignment: Alignment.bottomRight,
            autoCloseDuration: const Duration(seconds: 4),
            icon: const Icon(Icons.check),
            borderRadius: BorderRadius.circular(12.0),
            showProgressBar: true,
          );
        }
      },
      child: Scaffold(
        appBar: const AppBarBack(),
        body: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Cover letter',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const Text(
                'Describe why do you fit to this project',
                style: TextStyle(
                  fontSize: 16,
                  color: Colors.grey,
                ),
              ),
              const SizedBox(height: 10),
              TextField(
                controller: _coverLetterController,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  hintText: 'Cover letter',
                ),
                maxLines: 10,
              ),
              const SizedBox(height: 10),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  ElevatedButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    child: const Text('Cancel'),
                  ),
                  ElevatedButton(
                    onPressed: () {
                      BlocProvider.of<ProposalBloc>(context).add(
                        SubmitProposal(
                          projectId: project!.id.toString(),
                          coverLetter: _coverLetterController.text,
                          studentId: userProfileBloc
                                  .state.userProfile.student?.id
                                  .toString() ??
                              '',
                        ),
                      );
                    },
                    child: const Text('Submit'),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    _coverLetterController.dispose(); // Dispose the controller
    super.dispose();
  }
}
