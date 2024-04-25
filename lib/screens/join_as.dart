import 'package:final_project_mobile/widgets/custom_app_bar.dart';
import 'package:final_project_mobile/pages/login.dart';
import 'package:final_project_mobile/pages/sign_up.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class JoinAs extends ConsumerWidget {
  const JoinAs({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: const CustomAppBar(),
      body: Center(
        child: Padding(
            padding: const EdgeInsets.all(20),
            child: Stack(
              children: [
                Column(
                  children: [
                    const Text(
                      'Join as Company or Student',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 20),
                    const RoleRadio(),
                    const SizedBox(height: 20),
                    ElevatedButton(
                      onPressed: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const SignUpPage()));
                      },
                      style: ButtonStyle(
                        shape: MaterialStateProperty.all(
                          RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(0),
                          ),
                        ),
                        foregroundColor: MaterialStateProperty.all(Colors.blue),
                      ),
                      child: const Text('Create Account'),
                    ),
                    Center(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Text('Already have an account?'),
                          const SizedBox(width: 10),
                          TextButton(
                            onPressed: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) =>
                                          const LoginScreen()));
                            },
                            style: ButtonStyle(
                              textStyle: MaterialStateProperty.all(
                                const TextStyle(
                                  decoration: TextDecoration.underline,
                                ),
                              ),
                            ),
                            child: const Text('Sign In'),
                          ),
                        ],
                      ),
                    )
                  ],
                ),
              ],
            )),
      ),
    );
  }
}

final selectedRoleProvider = StateProvider<RoleEnum>((ref) => RoleEnum.student);

class RoleRadio extends ConsumerStatefulWidget {
  const RoleRadio({super.key});
  @override
  ConsumerState<RoleRadio> createState() => _CompanyOrStudentRole();
}

enum RoleEnum { company, student }

class _CompanyOrStudentRole extends ConsumerState<RoleRadio> {
  @override
  Widget build(BuildContext context) {
    final selectedRole = ref.watch(selectedRoleProvider);
    return Column(
      children: <Widget>[
        Padding(
          padding:
              const EdgeInsets.only(bottom: 16.0), // Add space between boxes
          child: GestureDetector(
            onTap: () {
              ref
                  .read(selectedRoleProvider.notifier)
                  .update((state) => RoleEnum.company);
            },
            child: Container(
              decoration: BoxDecoration(
                border: Border.all(color: Colors.black), // Border
                borderRadius: BorderRadius.circular(8.0), // Rounded corners
              ),
              padding:
                  const EdgeInsets.all(16.0), // Padding inside the container
              child: Row(
                children: [
                  const Icon(Icons.people), // Icon of person
                  const SizedBox(width: 10), // Spacer between icon and text
                  const Expanded(
                    child: Text(
                      'I am a company, find engineer for project',
                      style: TextStyle(fontSize: 16.0),
                    ),
                  ),
                  Radio<RoleEnum>(
                    value: RoleEnum.company,
                    groupValue: selectedRole,
                    onChanged: (RoleEnum? value) {
                      ref
                          .read(selectedRoleProvider.notifier)
                          .update((state) => RoleEnum.company);
                    },
                  ),
                ],
              ),
            ),
          ),
        ),
        GestureDetector(
          onTap: () {
            ref
                .read(selectedRoleProvider.notifier)
                .update((state) => RoleEnum.student);
          },
          child: Container(
            decoration: BoxDecoration(
              border: Border.all(color: Colors.black), // Border
              borderRadius: BorderRadius.circular(8.0), // Rounded corners
            ),
            padding: const EdgeInsets.all(16.0), // Padding inside the container
            child: Row(
              children: [
                const Icon(Icons.person), // Icon of person
                const SizedBox(width: 10), // Spacer between icon and text
                const Expanded(
                  child: Text(
                    'I am a student, find project for doing',
                    style: TextStyle(fontSize: 16.0),
                  ),
                ),
                Radio<RoleEnum>(
                  value: RoleEnum.student,
                  groupValue: selectedRole,
                  onChanged: (RoleEnum? value) {
                    ref
                        .read(selectedRoleProvider.notifier)
                        .update((state) => RoleEnum.student);
                  },
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
