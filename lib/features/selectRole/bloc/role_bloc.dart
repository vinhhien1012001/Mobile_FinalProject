import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'role_event.dart';
part 'role_state.dart';

class RoleBloc extends Bloc<RoleEvent, RoleState> {
  RoleBloc(super.initialState) {
    on<RoleSelect>((event, emit) {
      emit(RoleSelected(event.roleId));
    });
  }
}
