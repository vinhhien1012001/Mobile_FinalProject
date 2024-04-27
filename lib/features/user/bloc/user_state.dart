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
