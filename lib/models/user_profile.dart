import 'package:equatable/equatable.dart';
import 'package:final_project_mobile/models/student.dart';

class UserProfile extends Equatable {
  const UserProfile({
    required this.id,
    required this.fullname,
    required this.roles,
    this.company, // Add company field
    this.student,
  });

  final int id;
  final String fullname;
  final List<int> roles;
  final Company? company; // Declare company field
  final Student? student;
  @override
  List<Object?> get props =>
      [id, fullname, roles, company, student]; // Include company in props

  static UserProfile fromJson(Map<String, dynamic> json) {
    return UserProfile(
      id: json['id'],
      fullname: json['fullname'],
      roles: List<int>.from(json['roles'].map((x) => x)),
      company: json['company'] != null
          ? Company.fromJson(json['company'])
          : null, // Parse company if available
      student:
          json['student'] != null ? Student.fromJson(json['student']) : null,
    );
  }
}

class Company extends Equatable {
  const Company({
    required this.id,
    required this.createdAt,
    required this.updatedAt,
    required this.userId,
    required this.companyName,
    required this.website,
    required this.size,
    required this.description,
  });

  final int id;
  final DateTime createdAt;
  final DateTime updatedAt;
  final int userId;
  final String companyName;
  final String website;
  final int size;
  final String description;

  @override
  List<Object?> get props => [
        id,
        createdAt,
        updatedAt,
        userId,
        companyName,
        website,
        size,
        description,
      ];

  static Company fromJson(Map<String, dynamic> json) {
    return Company(
      id: json['id'],
      createdAt: DateTime.parse(json['createdAt']),
      updatedAt: DateTime.parse(json['updatedAt']),
      userId: json['userId'],
      companyName: json['companyName'],
      website: json['website'],
      size: json['size'],
      description: json['description'],
    );
  }
}
