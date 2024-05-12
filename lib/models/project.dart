import 'package:equatable/equatable.dart';
import 'package:final_project_mobile/models/proposal.dart';

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
  final int? status;
  final int? typeFlag;
  final List<Proposal>? proposals;
  final String? companyName;
  final int? countProposals;
  final int? countMessages;
  final int? countHired;
  bool? isFavorite;

  Project(
      {this.id,
      this.createdAt,
      this.updatedAt,
      this.deletedAt,
      this.companyId,
      this.projectScopeFlag,
      this.title,
      this.numberOfStudents,
      this.description,
      this.typeFlag,
      this.status,
      this.proposals,
      this.companyName,
      this.countProposals,
      this.countMessages,
      this.countHired,
      this.isFavorite});

  factory Project.fromJson(Map<String, dynamic> json) {
    // Parse the list of proposals
    List<dynamic>? jsonProposals = json['proposals'];
    List<Proposal>? proposals;
    if (jsonProposals != null) {
      proposals =
          jsonProposals.map((proposal) => Proposal.fromJson(proposal)).toList();
    }

    return Project(
      id: json['id'] ?? json['projectId'] ?? 0,
      createdAt: json['createdAt'],
      updatedAt: json['updatedAt'],
      deletedAt: json['deletedAt'],
      companyId: json['companyId'],
      projectScopeFlag: json['projectScopeFlag'],
      title: json['title'],
      numberOfStudents: json['numberOfStudents'] ?? json['numberOfStudents'],
      description: json['description'] ?? json['description'],
      typeFlag: json['typeFlag'],
      status: json['status'],
      proposals: proposals,
      companyName: json['companyName'],
      countProposals: json['countProposals'],
      countMessages: json['countMessages'],
      countHired: json['countHired'],
      isFavorite: json['isFavorite'],
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
    return [
      companyId,
      projectScopeFlag,
      title,
      numberOfStudents,
      description,
      // Other fields as needed
    ];
  }
}
