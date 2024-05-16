import 'package:equatable/equatable.dart';
import 'package:final_project_mobile/models/interview.dart';
import 'package:final_project_mobile/models/project.dart';
import 'package:final_project_mobile/models/proposal.dart';
import 'package:final_project_mobile/models/user_profile.dart';

class Student extends Equatable {
  const Student({
    required this.id,
    required this.createdAt,
    required this.updatedAt,
    required this.userId,
    required this.techStackId,
    required this.resume,
    required this.transcript,
    required this.proposals,
    required this.techStack,
    required this.skillSets,
  });

  final int id;
  final DateTime createdAt;
  final DateTime updatedAt;
  final int userId;
  final int techStackId;
  final dynamic resume; // Adjust data type if needed
  final dynamic transcript; // Adjust data type if needed
  final List<Proposal> proposals;
  final TechStack techStack;
  final List<SkillSet> skillSets;

  @override
  List<Object?> get props => [
        id,
        createdAt,
        updatedAt,
        userId,
        techStackId,
        resume,
        transcript,
        proposals,
        techStack,
        skillSets,
      ];

  static Student fromJson(Map<String, dynamic> json) {
    return Student(
      id: json['id'],
      createdAt: DateTime.parse(json['createdAt']),
      updatedAt: DateTime.parse(json['updatedAt']),
      userId: json['userId'],
      techStackId: json['techStackId'],
      resume: json['resume'],
      transcript: json['transcript'],
      proposals: List<Proposal>.from(
          json['proposals'].map((x) => Proposal.fromJson(x))),
      techStack: TechStack.fromJson(json['techStack']),
      skillSets: List<SkillSet>.from(
          json['skillSets'].map((x) => SkillSet.fromJson(x))),
    );
  }
}

class SkillSet {
  const SkillSet({
    this.id,
    this.createdAt,
    this.updatedAt,
    this.name,
  });

  final int? id;
  final DateTime? createdAt;
  final DateTime? updatedAt;
  final String? name;

  static SkillSet fromJson(Map<String, dynamic> json) {
    return SkillSet(
      id: json['id'],
      createdAt: DateTime.parse(json['createdAt']),
      updatedAt: DateTime.parse(json['updatedAt']),
      name: json['name'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'createdAt': createdAt,
      'updatedAt': updatedAt,
      'name': name,
    };
  }
}

class TechStack {
  const TechStack({
    this.id,
    this.createdAt,
    this.updatedAt,
    this.name,
  });

  final int? id;
  final DateTime? createdAt;
  final DateTime? updatedAt;
  final String? name;

  static TechStack fromJson(Map<String, dynamic> json) {
    return TechStack(
      id: json['id'],
      createdAt: DateTime.parse(json['createdAt']),
      updatedAt: DateTime.parse(json['updatedAt']),
      name: json['name'],
    );
  }
}

class Language {
  const Language({
    this.id,
    this.createdAt,
    this.updatedAt,
    this.studentId,
    this.languageName,
    this.level,
  });

  final int? id;
  final DateTime? createdAt;
  final DateTime? updatedAt;
  final int? studentId;
  final String? languageName;
  final String? level;

  static Language fromJson(Map<String, dynamic> json) {
    return Language(
      id: json['id'],
      createdAt: DateTime.parse(json['createdAt']),
      updatedAt: DateTime.parse(json['updatedAt']),
      languageName: json['languageName'],
      level: json['level'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      // 'id': id,
      // 'createdAt': createdAt,
      // 'updatedAt': updatedAt,
      // 'studentId': studentId,
      'languageName': languageName,
      'level': level,
    };
  }
}
