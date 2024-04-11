import 'package:final_project_mobile/components/custom_app_bar.dart';
import 'package:flutter/material.dart';

class PostJobStepScreen extends StatefulWidget {
  const PostJobStepScreen({super.key});

  @override
  State<PostJobStepScreen> createState() => _PostJobStepScreen();
}

class _PostJobStepScreen extends State<PostJobStepScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(),
    );
  }
}
