part of 'user_bloc.dart';

abstract class UserProfileEvent {
  const UserProfileEvent();
}

class GetUserProfile extends UserProfileEvent {
  const GetUserProfile();
}
