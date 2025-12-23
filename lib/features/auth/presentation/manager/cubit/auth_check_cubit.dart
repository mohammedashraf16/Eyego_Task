import 'package:bloc/bloc.dart';
import 'package:eyego_task/core/database/cache/cache_helper.dart';
import 'package:eyego_task/core/services/get_it_service.dart';
import 'package:eyego_task/features/auth/domain/entity/user_entity.dart';
import 'package:eyego_task/features/auth/domain/repos/auth_repo.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:meta/meta.dart';

part 'auth_check_state.dart';

class AuthCheckCubit extends Cubit<AuthCheckState> {
  final AuthRepo authRepo;

  AuthCheckCubit(this.authRepo) : super(AuthCheckInitial());

  Future<void> checkAuthStatus() async {
    emit(AuthCheckLoading());

    try {
      String? token = sl<CacheHelper>().getData(key: "token");

      if (token != null) {
        User? currentUser = FirebaseAuth.instance.currentUser;

        if (currentUser != null) {
          final result = await authRepo.getUserData(currentUser.uid);

          result.fold(
            (failure) {
              final userEntity = UserEntity(
                name: currentUser.displayName ?? 'User',
                email: currentUser.email ?? '',
                uId: currentUser.uid,
              );
              emit(AuthCheckAuthenticated(userEntity));
            },
            (userEntity) {
              emit(AuthCheckAuthenticated(userEntity));
            },
          );
          return;
        }
      }

      emit(AuthCheckUnauthenticated());
    } catch (e) {
      emit(AuthCheckUnauthenticated());
    }
  }
}
