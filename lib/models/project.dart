import 'package:equatable/equatable.dart';

class Project extends Equatable {
  final int? id;
  final String? createdAt;
  final String? updatedAt;
  final String? deletedAt;
  final String? companyId;
  final int? projectScopeFlag;
  final String? title;
  final int? numberOfStudents;
  final String? description;

  const Project({
    this.id,
    this.createdAt,
    this.updatedAt,
    this.deletedAt,
    this.companyId,
    this.projectScopeFlag,
    this.title,
    this.numberOfStudents,
    this.description,
  });

  factory Project.fromJson(Map<String, dynamic> json) {
    return Project(
      id: json['id'] ?? json['projectId'] ?? 0,
      createdAt: json['createdAt'],
      updatedAt: json['updatedAt'],
      deletedAt: json['deletedAt'],
      companyId: json['companyId'],
      projectScopeFlag: json['projectScopeFlag'],
      title: json['title'],
      numberOfStudents: json['numberOfStudents'],
      description: json['description'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'companyId': companyId,
      'projectScopeFlag': projectScopeFlag,
      'title': title,
      'numberOfStudents': numberOfStudents,
      'description': description,
    };
  }

  @override
  List<Object?> get props {
    return [companyId, projectScopeFlag, title, numberOfStudents, description];
  }
}
