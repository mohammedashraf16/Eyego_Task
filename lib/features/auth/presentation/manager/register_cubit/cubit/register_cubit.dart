import 'package:bloc/bloc.dart';
import 'package:eyego_task/features/auth/domain/entity/user_entity.dart';
import 'package:eyego_task/features/auth/domain/repos/auth_repo.dart';
import 'package:meta/meta.dart';

part 'register_state.dart';

class RegisterCubit extends Cubit<RegisterState> {
  final AuthRepo authRepo;
  RegisterCubit(this.authRepo) : super(RegisterInitial());
  Future<void> createUserWithEmailAndPassword(
    String email,
    String password,
    String name,
  ) async {
    emit(RegisterLoading());
    final result = await authRepo.createUserWithEmailAndPassword(
      email,
      password,
      name,
    );
    result.fold(
      (failure) => emit(RegisterFailure(errorMessage: failure.errorMessage)),
      (userEntity) => emit(RegisterSuccess(userEntity: userEntity)),
    );
  }
}
