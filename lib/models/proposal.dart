import 'package:equatable/equatable.dart';

class Proposal extends Equatable {
  final int? id;
  final String? createdAt;
  final String? updatedAt;
  final String? deletedAt;
  final int? projectId;
  final int? studentId;
  final String? coverLetter;
  final int? statusFlag;
  final int? disableFlag;

  const Proposal({
    this.id,
    this.createdAt,
    this.updatedAt,
    this.deletedAt,
    this.projectId,
    this.studentId,
    this.coverLetter,
    this.statusFlag,
    this.disableFlag,
  });

  factory Proposal.fromJson(Map<String, dynamic> json) {
    return Proposal(
      id: json['id'],
      createdAt: json['createdAt'],
      updatedAt: json['updatedAt'],
      deletedAt: json['deletedAt'],
      projectId: json['projectId'],
      studentId: json['studentId'],
      coverLetter: json['coverLetter'],
      statusFlag: json['statusFlag'],
      disableFlag: json['disableFlag'],
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> json = {};
    if (id != null) json['id'] = id;
    if (createdAt != null) json['createdAt'] = createdAt;
    if (updatedAt != null) json['updatedAt'] = updatedAt;
    if (projectId != null) json['projectId'] = projectId;
    if (studentId != null) json['studentId'] = studentId;
    if (coverLetter != null) json['coverLetter'] = coverLetter;
    return json;
  }

  @override
  List<Object?> get props {
    return [
      id,
      createdAt,
      updatedAt,
      deletedAt,
      projectId,
      studentId,
      coverLetter,
      statusFlag,
      disableFlag,
    ];
  }
}
