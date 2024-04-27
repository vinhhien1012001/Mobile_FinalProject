import 'package:equatable/equatable.dart';

class UserProfile extends Equatable {
  const UserProfile(
      {required this.id, required this.fullname, required this.roles});
  final int id;
  final String fullname;
  final List<int> roles;
  @override
  List<Object> get props => [id, fullname, roles];

  static UserProfile fromJson(Map<String, dynamic> json) {
    return UserProfile(
      id: json['id'],
      fullname: json['fullname'],
      roles: List<int>.from(json['roles'].map((x) => x)),
    );
  }
}
