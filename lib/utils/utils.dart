import 'package:final_project_mobile/screens/join_as.dart';

String getRoleDisplayName(RoleEnum role) {
  switch (role) {
    case RoleEnum.student:
      return 'Student';
    case RoleEnum.company:
      return 'Company';
    default:
      return '';
  }
}
