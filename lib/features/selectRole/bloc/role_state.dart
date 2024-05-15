part of 'role_bloc.dart';

// sealed class RoleState extends Equatable {
//   final int roleId;
//   const RoleState(this.roleId);

//   @override
//   List<Object> get props => [roleId];
// }

// class RoleInitial extends RoleState {
//   const RoleInitial(super.roleId);

//   @override
//   String toString() => 'RoleInitial { roleId: $roleId }';
// }

abstract class RoleState {}

class RoleInitial extends RoleState {}

class RoleLoaded extends RoleState {
  final Role role;

  RoleLoaded(this.role);
}

// class RoleSelected extends RoleState {
//   const RoleSelected(super.roleId);

//   @override
//   String toString() => 'RoleSelected { roleId: $roleId }';
// }