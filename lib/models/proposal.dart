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
  final Student? student;
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
    this.student,
  });

  factory Proposal.fromJson(Map<String, dynamic> json) {
    return Proposal(
      id: json['id'],
      projectId: json['projectId'],
      createdAt: json['createdAt'],
      updatedAt: json['updatedAt'],
      deletedAt: json['deletedAt'],
      studentId: json['studentId'],
      coverLetter: json['coverLetter'],
      statusFlag: json['statusFlag'],
      disableFlag: json['disableFlag'],
      student:
          json['student'] != null ? Student.fromJson(json['student']) : null,
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
    if (statusFlag != null) json['statusFlag'] = statusFlag;
    if (disableFlag != null) json['disableFlag'] = disableFlag;
    if (student != null) json['student'] = student?.toJson();
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
      student,
    ];
  }
}

class Student extends Equatable {
  final int id;
  final String? createdAt;
  final String? updatedAt;
  final String? deletedAt;
  final int? userId;
  final int? techStackId;
  final String? resume;
  final String? transcript;
  final User? user;
  final TechStack? techStack;
  final List<Education> educations;

  const Student({
    required this.id,
    required this.createdAt,
    required this.updatedAt,
    required this.deletedAt,
    required this.userId,
    required this.techStackId,
    required this.resume,
    required this.transcript,
    required this.user,
    required this.techStack,
    required this.educations,
  });

  factory Student.fromJson(Map<String, dynamic> json) {
    return Student(
      id: json['id'],
      createdAt: json['createdAt'],
      updatedAt: json['updatedAt'],
      deletedAt: json['deletedAt'],
      userId: json['userId'],
      techStackId: json['techStackId'],
      resume: json['resume'],
      transcript: json['transcript'],
      user: User.fromJson(json['user']),
      techStack: TechStack.fromJson(json['techStack']),
      educations: (json['educations'] as List<dynamic>)
          .map((e) => Education.fromJson(e))
          .toList(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'createdAt': createdAt,
      'updatedAt': updatedAt,
      'deletedAt': deletedAt,
      'userId': userId,
      'techStackId': techStackId,
      'resume': resume,
      'transcript': transcript,
      'user': user?.toJson(),
      'techStack': techStack?.toJson(),
      'educations': educations.map((e) => e.toJson()).toList(),
    };
  }

  @override
  List<Object?> get props => [
        id,
        createdAt,
        updatedAt,
        deletedAt,
        userId,
        techStackId,
        resume,
        transcript,
        user,
        techStack,
        educations,
      ];
}

class User extends Equatable {
  final String fullName;

  const User({
    required this.fullName,
  });

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      fullName: json['fullname'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'fullname': fullName,
    };
  }

  @override
  List<Object?> get props => [fullName];
}

class TechStack extends Equatable {
  final int? id;
  final String? createdAt;
  final String? updatedAt;
  final String? deletedAt;
  final String? name;

  const TechStack({
    required this.id,
    required this.createdAt,
    required this.updatedAt,
    this.deletedAt,
    required this.name,
  });

  factory TechStack.fromJson(Map<String, dynamic> json) {
    return TechStack(
      id: json['id'],
      createdAt: json['createdAt'],
      updatedAt: json['updatedAt'],
      deletedAt: json['deletedAt'] != null ? json['deletedAt'] : null,
      name: json['name'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'createdAt': createdAt,
      'updatedAt': updatedAt,
      'deletedAt': deletedAt,
      'name': name,
    };
  }

  @override
  List<Object?> get props => [id, createdAt, updatedAt, deletedAt, name];
}

class Education extends Equatable {
  final int id; // Assuming you have an id for each education entry
  final String? institution;
  final String? degree;
  final String? startDate;
  final String? endDate;

  const Education({
    required this.id,
    required this.institution,
    required this.degree,
    required this.startDate,
    required this.endDate,
  });

  factory Education.fromJson(Map<String, dynamic> json) {
    return Education(
      id: json['id'],
      institution: json['institution'],
      degree: json['degree'],
      startDate: json['startDate'],
      endDate: json['endDate'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'institution': institution,
      'degree': degree,
      'startDate': startDate,
      'endDate': endDate,
    };
  }

  @override
  List<Object?> get props => [id, institution, degree, startDate, endDate];
}
