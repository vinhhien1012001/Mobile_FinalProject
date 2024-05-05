import 'dart:async';
import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:final_project_mobile/features/user/repos/user_repository.dart';
import 'package:final_project_mobile/models/user_profile.dart';
import 'package:flutter/material.dart';

part 'user_event.dart';
part 'user_state.dart';

class UserProfileBloc extends Bloc<UserProfileEvent, UserProfileState> {
  final UserRepository userRepository = UserRepository();
  UserProfileBloc({required UserRepository repository})
      : super(const UserProfileState()) {
    on<GetUserProfile>(_getMyProfile);
    on<SignIn>(_signIn);
    on<SignOut>(_signOut);
  }

  Future<void> _getMyProfile(
      GetUserProfile event, Emitter<UserProfileState> emit) async {
    log('1st');
    final userProfile = await userRepository.getMyProfile();
    emit(state.copyWith(userProfile: userProfile));
    emit(UserProfileLoadSuccess(userProfile));
  }

  Future<void> _signIn(SignIn event, Emitter<UserProfileState> emit) async {
    try {
      final userProfile = await userRepository.signIn(
          event.email, event.password, event.fullname, event.role);
      emit(state.copyWith(userProfile: userProfile));
    } catch (error) {
      emit(state.copyWith(userProfile: null));
    }
  }

  Future<void> _signOut(SignOut event, Emitter<UserProfileState> emit) async {
    await userRepository.signOut();
    emit(state.copyWith(userProfile: null));
  }
}
