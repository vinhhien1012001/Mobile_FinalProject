part of 'role_bloc.dart';

sealed class RoleEvent {
  const RoleEvent();
}

final class RoleSelect extends RoleEvent {
  final int roleId;
  const RoleSelect(this.roleId);
}
