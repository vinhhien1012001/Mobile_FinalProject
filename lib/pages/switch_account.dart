import 'package:final_project_mobile/features/selectRole/bloc/role_bloc.dart';
import 'package:final_project_mobile/features/user/bloc/user_bloc.dart';
import 'package:final_project_mobile/models/user_profile.dart';
import 'package:final_project_mobile/pages/profile_pages/student_profile_input.dart';
import 'package:final_project_mobile/routes/routes.dart';
import 'package:final_project_mobile/widgets/custom_app_bar.dart';
import 'package:final_project_mobile/pages/profile.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nb_utils/nb_utils.dart';

class SwitchAccountPage extends StatefulWidget {
  const SwitchAccountPage({super.key});

  @override
  State<SwitchAccountPage> createState() => _SwitchAccountPageState();
}

class _SwitchAccountPageState extends State<SwitchAccountPage> {
  UserProfileState? userProfileState;
  late Role role;
  late Company companyProfile;

  bool showRow = false;
  bool showInfoStudentRow = false;

  @override
  void initState() {
    super.initState();
    BlocProvider.of<UserProfileBloc>(context).add(GetUserProfile());
  }

  void changeProfile() {
    if (role == Role.Student) {
      BlocProvider.of<RoleBloc>(context).add(SetRole(Role.Company));
    } else {
      BlocProvider.of<RoleBloc>(context).add(SetRole(Role.Student));
      setState(() {});

      // Navigator.pushNamed(context, "home");
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<RoleBloc, RoleState>(
      builder: (context, state) {
        if (state is RoleLoaded) {
          role = state.role;
        }
        return BlocListener<UserProfileBloc, UserProfileState>(
          listener: (context, state) {
            if (state is UserProfileLoadSuccess) {
              log('userProfileState: $state');
              setState(() {
                userProfileState = state;
                if (userProfileState!.userProfile.company != null) {
                  companyProfile = userProfileState!.userProfile.company!;
                }
                log('userProfileState: $userProfileState');
                // BlocProvider.of<RoleBloc>(context).add(SetRole(Role.Student));
              });
            }
          },
          child: BlocBuilder<UserProfileBloc, UserProfileState>(
            builder: (context, userState) {
              if (userState is UserProfileLoadSuccess &&
                  userProfileState != null) {
                return MaterialApp(
                  home: Scaffold(
                    appBar: AppBar(
                      automaticallyImplyLeading: false,
                      // leading: IconButton(
                      //   icon: const Icon(Icons.arrow_back),
                      //   onPressed: () =>
                      //       Navigator.pushNamed(context, Routes.dashboard),
                      // ),
                      title: const Text('StudentHub'),
                      centerTitle: true,
                      backgroundColor: Colors.blue,
                    ),
                    body: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        // switch account
                        Container(
                          // padding: const EdgeInsets.all(16.0),
                          decoration: const BoxDecoration(
                            border: Border(
                              bottom: BorderSide(
                                color: Colors.grey,
                                width: 1.0,
                              ),
                            ),
                          ),

                          /******************** SWITCH ACCOUNT *********************/
                          child: SettingItemWidget(
                            leading: Icon(Icons.person_outline,
                                color: context.iconColor),
                            title: role == Role.Student
                                ? (userProfileState!.userProfile.fullname ??
                                    "Unknown")
                                : (userProfileState!.userProfile.company != null
                                    ? userProfileState!
                                        .userProfile.company!.companyName!
                                    : ""),
                            subTitle:
                                role == Role.Student ? "Student" : "Company",
                            titleTextStyle: boldTextStyle(),
                            onTap: () {
                              setState(() {
                                showRow = !showRow;
                              });
                            },
                            trailing: showRow
                                ? Transform.rotate(
                                    angle: 3.14 / 2, // Độ xoay 90 độ
                                    child: Icon(Icons.arrow_forward_ios_rounded,
                                        size: 18, color: context.iconColor))
                                : Icon(Icons.arrow_forward_ios_rounded,
                                    size: 18, color: context.iconColor),
                          ),
                        ),

                        /***************************  ACCOUNT LIST ROW ***************************/
                        ((role == Role.Student &&
                                    userProfileState!.userProfile.company !=
                                        null) ||
                                (role == Role.Company &&
                                    userProfileState!.userProfile.student !=
                                        null &&
                                    userProfileState!.userProfile != null))
                            /******** IF HAVE 2 ROLE ************/
                            ? SizedBox(
                                // height: showRow ? 85.0 : 0,
                                child: showRow
                                    ? Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          SettingItemWidget(
                                            leading: Icon(Icons.person_outline,
                                                color: context.iconColor),
                                            title: role == Role.Company
                                                ? userProfileState!
                                                    .userProfile.fullname
                                                : (userProfileState!.userProfile
                                                        .company!.companyName ??
                                                    "Unknown"),
                                            subTitle: role == Role.Company
                                                ? "Student"
                                                : "Company",
                                            titleTextStyle: boldTextStyle(),
                                            onTap: () {
                                              changeProfile();
                                            },
                                            trailing: Icon(
                                                Icons.arrow_forward_ios_rounded,
                                                size: 18,
                                                color: context.iconColor),
                                          )
                                        ],
                                      )
                                    : null,
                              )

                            //     /******** IF HAVE 1 ROLE ************/
                            : SizedBox(
                                child: showRow
                                    ? Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          SettingItemWidget(
                                            leading: Icon(
                                                Icons.add_circle_outline,
                                                color: context.iconColor),
                                            title: "Add company account",
                                            // subTitle: role == Role.Company
                                            //     ? "Student"
                                            //     : "Company",
                                            titleTextStyle: boldTextStyle(),
                                            onTap: () {
                                              // Navigator.push(
                                              //     context,
                                              //     MaterialPageRoute(
                                              //         builder: (context) =>
                                              //             const ProfileCompanyCreatePage()));
                                              Navigator.pushNamed(context,
                                                  Routes.companyProfile);
                                            },
                                            trailing: Icon(
                                                Icons.arrow_forward_ios_rounded,
                                                size: 18,
                                                color: context.iconColor),
                                          )
                                        ],
                                      )
                                    : null,
                              ),

                        /***************************  PROFILE BUTTON **************************/
                        ElevatedButton.icon(
                          onPressed: () {
                            // Company role
                            if (role == Role.Company) {
                              log('companyProfile: $companyProfile');
                              // Navigator.push(
                              //     context,
                              //     MaterialPageRoute(
                              //         builder: (context) =>
                              //             const ProfileLoggedInPage()));
                              Navigator.pushNamed(
                                  context, Routes.companyUpdateProfile);
                            }
                            // Student role
                            else {
                              // Navigator.push(
                              //     context,
                              //     MaterialPageRoute(
                              //         builder: (context) =>
                              //             const StudentProfileInputPage()));
                              Navigator.pushNamed(
                                  context, Routes.studentProfileInput);
                            }
                          },
                          icon: const Icon(Icons.account_circle),
                          label: const Text('Profiles'),
                          style: ElevatedButton.styleFrom(
                            foregroundColor: Colors.white,
                            backgroundColor: Colors.blue, // Background color
                            padding:
                                const EdgeInsets.all(12.0), // Button padding
                            alignment: Alignment.centerLeft,
                            shape:
                                const RoundedRectangleBorder(), // Button border
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
                            BlocProvider.of<UserProfileBloc>(context)
                                .add(const SignOut());
                            Navigator.pushReplacementNamed(
                                context, Routes.login);
                          },
                          icon: const Icon(Icons.logout),
                          label: const Text('Logout'),
                          style: ElevatedButton.styleFrom(
                            foregroundColor: Colors.white,
                            backgroundColor: Colors.red, // Background color
                            padding:
                                const EdgeInsets.all(12.0), // Button padding
                            alignment: Alignment.centerLeft,
                            shape:
                                const RoundedRectangleBorder(), // Button border
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              } else {
                return const Center(child: CircularProgressIndicator());
              }
            },
          ),
        );
      },
    );
  }
}
