import 'package:final_project_mobile/features/user/bloc/user_bloc.dart';
import 'package:final_project_mobile/routes/routes.dart';
import 'package:final_project_mobile/screens/join_as.dart';
import 'package:final_project_mobile/utils/utils.dart';
import 'package:final_project_mobile/widgets/custom_app_bar.dart';
import 'package:final_project_mobile/pages/login.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:toastification/toastification.dart';

class SignUpPage extends ConsumerStatefulWidget {
  const SignUpPage({super.key});

  @override
  ConsumerState<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends ConsumerState<SignUpPage> {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController fullnameController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    final selectedRole = ref.watch(selectedRoleProvider);
    final roleDisplayName = getRoleDisplayName(selectedRole);

    // print('roleDisplayName: $roleDisplayName');
    // print('selectedRole: $selectedRole');
    return BlocListener<UserProfileBloc, UserProfileState>(
        listener: (context, state) {
          if (state is SignUpSuccess) {
            toastification.show(
              context: context,
              type: ToastificationType.success,
              style: ToastificationStyle.flat,
              title: const Text(
                'Create account successs, please check email to confirm and login!',
                style: TextStyle(fontSize: 16),
              ),
              alignment: Alignment.topCenter,
              autoCloseDuration: const Duration(seconds: 6),
              icon: const Icon(Icons.check, size: 40),
              borderRadius: BorderRadius.circular(12.0),
              showProgressBar: true,
            );
            // Navigator.pushReplacement(
            //   context,
            //   'login',
            // );
            Navigator.pushNamed(context, Routes.login);
          } else if (state is SignUpFailure) {
            // print('SIGN UP FAILURE STATE');
            // print('ERROR: ${state.error}');
            toastification.show(
              context: context,
              type: ToastificationType.error,
              style: ToastificationStyle.flat,
              title: Text(
                'Sign up failed!  ${state.error.toString().replaceFirst('Exception: ', '')}',
                style: const TextStyle(
                    fontSize: 16), // Increase the font size here
              ),
              alignment: Alignment.topCenter,
              autoCloseDuration: const Duration(seconds: 4),
              icon: const Icon(Icons.error,
                  size: 40), // Increase the icon size here
              borderRadius: BorderRadius.circular(12.0),
              showProgressBar: true,
            );
          }
        },
        child: Scaffold(
          appBar: const AppBarBack(),
          body: Center(
            child: Padding(
                padding: const EdgeInsets.all(20),
                child: Stack(
                  children: [
                    Column(
                      children: [
                        Text(
                          'Sign up as $roleDisplayName ',
                          style: const TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 20),

                        // FULL NAME
                        TextField(
                          decoration: const InputDecoration(
                            labelText: 'Fullname',
                            border: OutlineInputBorder(),
                          ),
                          onChanged: (value) {
                            fullnameController.text = value;
                          },
                        ),
                        const SizedBox(height: 20),

                        // EMAIL
                        TextField(
                          decoration: const InputDecoration(
                            labelText: 'Work email address',
                            border: OutlineInputBorder(),
                          ),
                          onChanged: (value) {
                            emailController.text = value;
                          },
                        ),
                        const SizedBox(height: 20),

                        // PASSWORD
                        TextField(
                          decoration: const InputDecoration(
                            labelText: 'Password (8 characters or more)',
                            border: OutlineInputBorder(),
                          ),
                          onChanged: (value) {
                            passwordController.text = value;
                          },
                        ),
                        const Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            TermCheckBox(),
                            Text('Yes, I understand and agree to StudentHub '),
                          ],
                        ),

                        const SizedBox(height: 20),
                        // SIGN UP BUTTON
                        ElevatedButton(
                          onPressed: () {
                            if (emailController.text.isEmpty ||
                                passwordController.text.isEmpty ||
                                fullnameController.text.isEmpty) {
                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                    content: Text('Please fill in all fields')),
                              );
                            } else {
                              context.read<UserProfileBloc>().add(
                                    SignUp(
                                      email: emailController.text,
                                      password: passwordController.text,
                                      fullname: fullnameController.text,
                                      role:
                                          roleDisplayName == "Student" ? 0 : 1,
                                    ),
                                  );
                            }
                          },
                          style: ButtonStyle(
                            shape: MaterialStateProperty.all(
                              RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(0),
                              ),
                            ),
                            foregroundColor:
                                MaterialStateProperty.all(Colors.blue),
                          ),
                          child: const Text('Create Account'),
                        ),
                        // CHANGE ROLE SCREEN STUDENT
                        Center(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              const Text('Looking for a project?'),
                              const SizedBox(width: 2),
                              TextButton(
                                onPressed: () {
                                  Navigator.pushNamed(context, Routes.login);
                                },
                                style: ButtonStyle(
                                  textStyle: MaterialStateProperty.all(
                                    const TextStyle(
                                      decoration: TextDecoration.underline,
                                    ),
                                  ),
                                ),
                                child: const Text('Apply as Student'),
                              ),
                            ],
                          ),
                        )
                      ],
                    ),
                  ],
                )),
          ),
        ));
  }
}

class TermCheckBox extends StatefulWidget {
  const TermCheckBox({super.key});

  @override
  State<TermCheckBox> createState() => _TermCheckBox();
}

class _TermCheckBox extends State<TermCheckBox> {
  bool? isAgree = false;

  @override
  Widget build(BuildContext context) {
    Color getColor(Set<MaterialState> states) {
      const Set<MaterialState> interactiveStates = <MaterialState>{
        MaterialState.pressed,
        MaterialState.hovered,
        MaterialState.focused,
      };
      if (states.any(interactiveStates.contains)) {
        return Colors.black26;
      }
      return Colors.blue;
    }

    return Checkbox(
      checkColor: Colors.white,
      fillColor: MaterialStateProperty.resolveWith(getColor),
      value: isAgree,
      onChanged: (bool? value) {
        setState(() {
          isAgree = value!;
        });
      },
    );
  }
}
