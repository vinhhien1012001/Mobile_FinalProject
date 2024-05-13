import 'package:final_project_mobile/features/user/bloc/user_bloc.dart';
import 'package:final_project_mobile/pages/profile_pages/student_profile_input.dart';
import 'package:final_project_mobile/screens/join_as.dart';
import 'package:final_project_mobile/utils/utils.dart';
import 'package:final_project_mobile/widgets/custom_app_bar.dart';
import 'package:final_project_mobile/pages/profile.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:final_project_mobile/features/selectRole/bloc/role_bloc.dart';
import 'package:final_project_mobile/features/user/bloc/user_bloc.dart';
import 'package:final_project_mobile/routes/routes.dart';

class SwitchAccountPage extends StatefulWidget {
  const SwitchAccountPage({super.key});

  @override
  State<SwitchAccountPage> createState() => _SwitchAccountPageState();
}

class _SwitchAccountPageState extends State<SwitchAccountPage> {
  @override
  void initState() {
    super.initState();
    context.read<UserProfileBloc>().add(const GetUserProfile());
  }

  @override
  Widget build(BuildContext context) {
    // final selectedRole = ref.watch(selectedRoleProvider);
    // final roleDisplayName = getRoleDisplayName(selectedRole);

    String _selectedAccount = 'Account 1';
    final List<Map<String, dynamic>> _accounts = [
      {'name': 'Account 1', 'icon': Icons.account_circle},
      {'name': 'Account 2', 'icon': Icons.account_circle},
      {'name': 'Account 3', 'icon': Icons.account_circle},
    ];

    final userProfileState = context.read<UserProfileBloc>().state;
    final role = userProfileState.userProfile.roles[0];
    final studentProfile = userProfileState.userProfile.student;
    final companyProfile = userProfileState.userProfile.company;
    print('role: $role');
    print('user ProfileState: $studentProfile');
    print('company ProfileState: $companyProfile');

    return MaterialApp(
      home: Scaffold(
        appBar: const CustomAppBar(),
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // switch account
            Container(
              padding: const EdgeInsets.all(16.0),
              decoration: const BoxDecoration(
                border: Border(
                  bottom: BorderSide(
                    color: Colors.grey,
                    width: 1.0,
                  ),
                ),
              ),
              child: DropdownButtonFormField<Map<String, dynamic>>(
                value: _accounts[0],
                items: _accounts.map((account) {
                  return DropdownMenuItem<Map<String, dynamic>>(
                    value: account,
                    child: Row(
                      children: [
                        Icon(account['icon']),
                        const SizedBox(width: 10),
                        Text(account['name']),
                      ],
                    ),
                  );
                }).toList(),
                onChanged: (Map<String, dynamic>? newValue) {
                  // setState(() {
                  //   _selectedAccount = newValue!['name'];
                  // });
                },
              ),
            ),
            ElevatedButton.icon(
              onPressed: () {
                // Company role
                if (role == 1) {
                  print('companyProfile: $companyProfile');
                  if (companyProfile != null) {
                    print('COMPANY NEW PROFILE');
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) =>
                                const ProfileCompanyCreatePage()));
                  } else {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const ProfileLoggedInPage()));
                  }
                }
                // Student role
                else {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) =>
                              const StudentProfileInputPage()));
                }
                // Navigator.push(
                //     context,
                //     MaterialPageRoute(
                //         builder: (context) => const ProfileNotLoggedInPage()));
              },
              icon: const Icon(Icons.account_circle),
              label: const Text('Profiles'),
              style: ElevatedButton.styleFrom(
                foregroundColor: Colors.white,
                backgroundColor: Colors.blue, // Background color
                padding: const EdgeInsets.all(12.0), // Button padding
                alignment: Alignment.centerLeft,
                shape: const RoundedRectangleBorder(), // Button border
              ),
            ),
            // ElevatedButton.icon(
            //   onPressed: () {
            //     Navigator.push(
            //         context,
            //         MaterialPageRoute(
            //             builder: (context) => const StudentProfileInputPage()));
            //   },
            //   icon: const Icon(Icons.settings),
            //   label: const Text('Settings'),
            //   style: ElevatedButton.styleFrom(
            //     foregroundColor: Colors.white,
            //     backgroundColor: Colors.green, // Background color
            //     padding: const EdgeInsets.all(12.0), // Button padding
            //     alignment: Alignment.centerLeft,
            //     shape: const RoundedRectangleBorder(), // Button border
            //   ),
            // ),
            ElevatedButton.icon(
              onPressed: () {
                BlocProvider.of<UserProfileBloc>(context).add(const SignOut());
                Navigator.pushReplacementNamed(context, '/login');
              },
              icon: const Icon(Icons.logout),
              label: const Text('Logout'),
              style: ElevatedButton.styleFrom(
                foregroundColor: Colors.white,
                backgroundColor: Colors.red, // Background color
                padding: const EdgeInsets.all(12.0), // Button padding
                alignment: Alignment.centerLeft,
                shape: const RoundedRectangleBorder(), // Button border
              ),
            ),
          ],
        ),
      ),
    );
  }
}
