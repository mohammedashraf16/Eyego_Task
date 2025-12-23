import 'package:dartz/dartz.dart';
import 'package:eyego_task/core/errors/failure.dart';
import 'package:eyego_task/features/auth/domain/entity/user_entity.dart';

abstract class AuthRepo {
  Future<Either<Failure, UserEntity>> createUserWithEmailAndPassword(
    String email,
    String password,
    String name,
  );

  Future<Either<Failure, UserEntity>> signInWithEmailAndPassword(
    String email,
    String password,
  );
  Future<Either<Failure, UserEntity>> signInWithGoogle();
  Future addUserData({required UserEntity user});
  Future<void> signOut();
}
