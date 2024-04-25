import 'package:equatable/equatable.dart';

final class UserProfile extends Equatable {
  const UserProfile(
      {required this.id, required this.fullname, required this.roles});

  final int id;
  final String fullname;
  final List<int> roles;

  @override
  List<Object> get props => [id, fullname, roles];
}
