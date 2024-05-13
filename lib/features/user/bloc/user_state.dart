part of 'user_bloc.dart';

class UserProfileState extends Equatable {
  final UserProfile userProfile;

  const UserProfileState(
      {this.userProfile = const UserProfile(id: 0, fullname: '', roles: [])});
  @override
  List<Object?> get props => [userProfile];

  UserProfileState copyWith({UserProfile? userProfile}) {
    return UserProfileState(userProfile: userProfile ?? this.userProfile);
  }
}

class UserProfileInitial extends UserProfileState {}

class UserProfileLoadInProgress extends UserProfileState {}

class UserProfileLoadSuccess extends UserProfileState {
  final UserProfile userProfile;

  const UserProfileLoadSuccess(this.userProfile);

  @override
  List<Object?> get props => [userProfile];
}

class UserProfileLoadFailure extends UserProfileState {
  final String error;

  const UserProfileLoadFailure(this.error);

  @override
  List<Object?> get props => [error];
}

class SignUpSuccess extends UserProfileState {}

class SignUpFailure extends UserProfileState {
  final String error;

  const SignUpFailure(this.error);

  @override
  List<Object?> get props => [error];
}
