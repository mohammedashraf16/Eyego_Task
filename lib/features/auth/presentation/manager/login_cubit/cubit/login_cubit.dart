import 'package:bloc/bloc.dart';
import 'package:eyego_task/features/auth/domain/entity/user_entity.dart';
import 'package:eyego_task/features/auth/domain/repos/auth_repo.dart';
import 'package:meta/meta.dart';

part 'login_state.dart';

class LoginCubit extends Cubit<LoginState> {
  LoginCubit(this.authRepo) : super(LoginInitial());
  final AuthRepo authRepo;

  Future<void> signInWithEmailAndPassword(String email, String password) async {
    emit(LoginLoading());
    var result = await authRepo.signInWithEmailAndPassword(email, password);
    result.fold(
      (failure) => emit(LoginFailure(errorMessage: failure.errorMessage)),
      (user) => emit(LoginSuccess(userEntity: user)),
    );
  }

  Future<void> signInWithGoogle() async {
    emit(LoginLoading());
    var result = await authRepo.signInWithGoogle();
    result.fold(
      (failure) {
        emit(LoginFailure(errorMessage: failure.errorMessage));
      },
      (user) {
        emit(LoginSuccess(userEntity: user));
      },
    );
  }

  Future<void> signInWithFacebook() async {
    emit(LoginLoading());
    var result = await authRepo.signInWithFacebook();
    result.fold(
      (failure) {
        emit(LoginFailure(errorMessage: failure.errorMessage));
      },
      (user) {
        emit(LoginSuccess(userEntity: user));
      },
    );
  }

  Future<void> logout() async {
    emit(LogoutLoading());
    await authRepo.signOut();
    emit(LogoutSuccess());
  }
}
