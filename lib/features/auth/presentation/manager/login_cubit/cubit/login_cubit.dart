import 'package:bloc/bloc.dart';
import 'package:eyego_task/core/database/cache/cache_helper.dart';
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
}
