import 'package:final_project_mobile/features/proposal/bloc/proposal_bloc.dart';
import 'package:final_project_mobile/widgets/custom_app_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:toastification/toastification.dart';

class SubmitProposalScreen extends StatelessWidget {
  const SubmitProposalScreen({super.key});

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
                'Create proposal successfully: ${state.proposal!.coverLetter}'),
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
        appBar: const CustomAppBar(),
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
              const TextField(
                decoration: InputDecoration(
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
                          projectId: '252',
                          studentId: '177',
                          coverLetter: 'DCM',
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
}
