part of 'role_bloc.dart';

// sealed class RoleEvent {
//   const RoleEvent();
// }

// final class RoleSelect extends RoleEvent {
//   final int roleId;
//   const RoleSelect(this.roleId);
// }

abstract class RoleEvent {}

class GetRole extends RoleEvent {}

class SetRole extends RoleEvent {
  final Role role;

  SetRole(this.role);
}
