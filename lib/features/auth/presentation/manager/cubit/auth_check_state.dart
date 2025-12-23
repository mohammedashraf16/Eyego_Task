part of 'auth_check_cubit.dart';

@immutable
sealed class AuthCheckState {}

final class AuthCheckInitial extends AuthCheckState {}

final class AuthCheckLoading extends AuthCheckState {}

final class AuthCheckAuthenticated extends AuthCheckState {
  final UserEntity user;

  AuthCheckAuthenticated(this.user);
}

final class AuthCheckUnauthenticated extends AuthCheckState {}
