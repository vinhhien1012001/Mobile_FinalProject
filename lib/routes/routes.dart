import 'package:final_project_mobile/models/project.dart';

import 'package:final_project_mobile/screens/join_as.dart';
import 'package:final_project_mobile/pages/7-student-submit-proposal/submit_proposal.dart';
// import 'package:final_project_mobile/pages/7-student-submit-proposal/dashboard_student.dart';
import 'package:final_project_mobile/pages/profile_pages/student_profile_cv.dart';
import 'package:final_project_mobile/pages/profile_pages/student_profile_experiences.dart';
import 'package:final_project_mobile/pages/profile_pages/student_profile_input.dart';
import 'package:final_project_mobile/pages/sub-pages/dashboard_company.dart';
import 'package:final_project_mobile/pages/sub-pages/dashboard_student.dart';
import 'package:final_project_mobile/pages/sub-pages/dashboard.dart';
import 'package:final_project_mobile/pages/sub-pages/message_conversation.dart';
import 'package:final_project_mobile/pages/sub-pages/message.dart';
import 'package:final_project_mobile/pages/sub-pages/notification.dart';
import 'package:final_project_mobile/pages/sub-pages/project_student.dart';
import 'package:final_project_mobile/pages/favorite_project.dart';
import 'package:final_project_mobile/pages/home.dart';
import 'package:final_project_mobile/pages/login.dart';
import 'package:final_project_mobile/pages/post_jobs_step.dart';
import 'package:final_project_mobile/pages/profile.dart';
import 'package:final_project_mobile/pages/project_detail_student.dart';
import 'package:final_project_mobile/pages/project_details_company.dart';
import 'package:final_project_mobile/pages/sign_up.dart';
import 'package:final_project_mobile/pages/switch_account.dart';
import 'package:final_project_mobile/pages/welcome.dart';

import 'package:flutter/material.dart';

class Routes {
  Routes._();

  static const String pageHome = '/';
  static const String login = '/login';
  static const String signUp = '/sign_up';
  static const String joinAs = '/join_as';
  static const String welcome = '/welcome';
  static const String dashboard = '/dashboard';
  static const String submitProposal = '/submit_proposal';
  static const String studentProfileCV = '/student_profile_cv';
  static const String studentProfileExperiences =
      '/student_profile_experiences';
  static const String studentProfileInput = '/student_profile_input';
  static const String dashboardCompany = '/dashboard_company';
  static const String dashboardStudent = '/dashboard_student';
  static const String messageConversation = '/message_conversation';
  static const String message = '/message';
  static const String notification = '/notification';
  static const String projectStudent = '/project_student';
  static const String favoriteProject = '/favorite_project';
  static const String postJobsStep = '/post_jobs_step';
  static const String companyProfile = '/company_profile';
  static const String companyUpdateProfile = '/company_update_profile';
  static const String projectDetailStudent = '/project_detail_student';
  static const String projectDetailsCompany = '/project_details_company';
  static const String switchAccount = '/switch_account';

  static final GlobalKey<NavigatorState> mainNavigatorKey =
      GlobalKey<NavigatorState>();

  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case pageHome:
        return MaterialPageRoute(builder: (_) => const HomePage());
      case login:
        return MaterialPageRoute(builder: (_) => const LoginScreen());
      case signUp:
        return MaterialPageRoute(builder: (_) => const SignUpPage());
      case joinAs:
        return MaterialPageRoute(builder: (_) => const JoinAs());
      case welcome:
        return MaterialPageRoute(builder: (_) => const WelcomeScreen());
      case dashboard:
        return MaterialPageRoute(builder: (_) => const DashboardScreen());
      case studentProfileCV:
        return MaterialPageRoute(
            builder: (_) => const StudentProfileCVScreen());
      case studentProfileExperiences:
        return MaterialPageRoute(
            builder: (_) => const StudentProfileExperiencePage());
      case studentProfileInput:
        return MaterialPageRoute(
            builder: (_) => const StudentProfileInputPage());
      case dashboardCompany:
        return MaterialPageRoute(builder: (_) => const DashboardCompany());
      case dashboardStudent:
        return MaterialPageRoute(builder: (_) => StudentDashboardContent());
      case notification:
        return MaterialPageRoute(builder: (_) => const NotificationPage());
      case projectStudent:
        return MaterialPageRoute(builder: (_) => const ProjectStudentContent());
      case favoriteProject:
        return MaterialPageRoute(
            builder: (_) => const FavoriteProjectsScreen());
      case postJobsStep:
        return MaterialPageRoute(builder: (_) => const PostJobStepScreen());
      case companyProfile:
        return MaterialPageRoute(
            builder: (_) => const ProfileCompanyCreatePage());
      case companyUpdateProfile:
        return MaterialPageRoute(builder: (_) => const ProfileLoggedInPage());
      case projectDetailStudent:
        final Project project = settings.arguments as Project;
        return MaterialPageRoute(
            builder: (_) => ProjectDetailsStudent(project: project));
      case projectDetailsCompany:
        final Project project = settings.arguments as Project;
        return MaterialPageRoute(
            builder: (_) => ProjectDetailsCompany(project: project));
      case message:
        final int projectId = settings.arguments as int;
        return MaterialPageRoute(
            builder: (_) => MessagePage(
                  projectId: projectId,
                ));
      case messageConversation:
        final Map<String, int> args = settings.arguments as Map<String, int>;
        final int projectId = args['projectId']!;
        final int recipientId = args['recipientId']!;
        return MaterialPageRoute(
            builder: (_) => MessagesDetails(
                  projectId: projectId,
                  recipientId: recipientId,
                ));
      case submitProposal:
        final Project project = settings.arguments as Project;
        return MaterialPageRoute(
            builder: (_) => SubmitProposalScreen(project: project));
      case switchAccount:
        return MaterialPageRoute(builder: (_) => const SwitchAccountPage());
      default:
        return MaterialPageRoute(
            builder: (_) => Scaffold(
                body: Center(
                    child: Text('No route defined for ${settings.name}'))));
    }
  }
}
