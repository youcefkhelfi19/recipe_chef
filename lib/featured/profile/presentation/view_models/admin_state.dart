part of 'admin_cubit.dart';

@immutable
abstract class AdminState {}

class AdminInitial extends AdminState {}
class AdminFailed extends AdminState {
  final String errMsg;

  AdminFailed({required this.errMsg});
}
class AdminSuccess extends AdminState {
  final Admin admin;
  AdminSuccess({required this.admin});
}
class AdminLoading extends AdminState {}
