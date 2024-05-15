import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:final_project_mobile/models/user_profile.dart';

part 'role_event.dart';
part 'role_state.dart';

// class RoleBloc extends Bloc<RoleEvent, RoleState> {
//   RoleBloc(super.initialState) {
//     on<RoleSelect>((event, emit) {
//       emit(RoleSelected(event.roleId));
//     });
//   }
// }

// class RoleBloc extends Bloc<RoleEvent, RoleState> {
//   Role _currentRole = Role.Student; // Default role

//   RoleBloc() : super(RoleInitial());

//   @override
//   Stream<RoleState> mapEventToState(RoleEvent event) async* {
//     if (event is GetRole) {
//       yield RoleLoaded(_currentRole);
//     } else if (event is SetRole) {
//       _currentRole = event.role;
//       yield RoleLoaded(_currentRole);
//     }
//   }
// }

class RoleBloc extends Bloc<RoleEvent, RoleState> {
  // RoleBloc() : super(RoleInitial()) {
  //   on<SetRole>((event, emit) {
  //     // Handle the SetRole event here
  //     // You can access the role with event.role
  //     // Then you can emit a new state with emit(newState)
  //     if (event.role == Role.Student) {
  //       emit(RoleLoaded(Role.Student));
  //     } else if (event.role == Role.Company) {
  //       emit(RoleLoaded(Role.Company));
  //     }
  //   });
  // }
  RoleBloc(super.initialState) {
    on<SetRole>((event, emit) {
      // Handle the SetRole event here
      // You can access the role with event.role
      // Then you can emit a new state with emit(newState)
      if (event.role == Role.Student) {
        emit(RoleLoaded(Role.Student));
      } else if (event.role == Role.Company) {
        emit(RoleLoaded(Role.Company));
      }
    });
  }
}
