import 'package:final_project_mobile/models/user_profile.dart';

String getRoleDisplayName(Role role) {
  switch (role) {
    case Role.Student:
      return 'Student';
    case Role.Company:
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
