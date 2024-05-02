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
    return {
      'id': id,
      'createdAt': createdAt,
      'updatedAt': updatedAt,
      'deletedAt': deletedAt,
      'projectId': projectId,
      'studentId': studentId,
      'coverLetter': coverLetter,
      'statusFlag': statusFlag,
      'disableFlag': disableFlag,
    };
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
