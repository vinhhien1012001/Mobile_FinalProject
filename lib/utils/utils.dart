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

extension StringCasingExtension on String {
  String toCapitalized() =>
      length > 0 ? '${this[0].toUpperCase()}${substring(1).toLowerCase()}' : '';
  String toTitleCase() => replaceAll(RegExp(' +'), ' ')
      .split(' ')
      .map((str) => str.toCapitalized())
      .join(' ');
}
