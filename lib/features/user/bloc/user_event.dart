part of 'user_bloc.dart';

abstract class UserProfileEvent {
  const UserProfileEvent();
}

class GetUserProfile extends UserProfileEvent {
  const GetUserProfile();
}

class SignIn extends UserProfileEvent {
  const SignIn({
    required this.email,
    required this.password,
    required this.fullname,
    required this.role,
  });
  final String email;
  final String password;
  final String fullname;
  final int role;
}
