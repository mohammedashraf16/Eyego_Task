import 'dart:developer';
import 'package:dartz/dartz.dart';
import 'package:eyego_task/core/database/api/end_points.dart';
import 'package:eyego_task/core/database/cache/cache_helper.dart';
import 'package:eyego_task/core/errors/exceptions.dart';
import 'package:eyego_task/core/errors/failure.dart';
import 'package:eyego_task/core/services/database_service.dart';
import 'package:eyego_task/core/services/firebase_auth_service.dart';
import 'package:eyego_task/core/services/get_it_service.dart';
import 'package:eyego_task/features/auth/data/models/user_model.dart';
import 'package:eyego_task/features/auth/domain/entity/user_entity.dart';
import 'package:eyego_task/features/auth/domain/repos/auth_repo.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class AuthRepoImpl extends AuthRepo {
  final FirebaseAuthService firebaseAuthService;
  final DataBaseService dataBaseService;

  AuthRepoImpl({
    required this.firebaseAuthService,
    required this.dataBaseService,
  });

  @override
  Future<Either<Failure, UserEntity>> createUserWithEmailAndPassword(
    String email,
    String password,
    String name,
  ) async {
    User? user;
    try {
      user = await firebaseAuthService.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      var userEntity = UserEntity(name: name, email: email, uId: user.uid);
      await addUserData(user: userEntity);
      return Right(userEntity);
    } on CustomException catch (e) {
      await deleteUser(user);
      return Left(ServerFailure(errorMessage: e.message));
    } catch (e) {
      await deleteUser(user);
      log(
        "Exception in AuthRepoImpl.createUserWithEmailAndPassword : ${e.toString()}",
      );
      return Left(
        ServerFailure(errorMessage: "Something went wrong. Please try again."),
      );
    }
  }

  @override
  Future<Either<Failure, UserEntity>> signInWithEmailAndPassword(
    String email,
    String password,
  ) async {
    try {
      var user = await firebaseAuthService.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      await sl<CacheHelper>().saveData(key: "token", value: user.uid);
      final userDataResult = await getUserData(user.uid);
      return userDataResult.fold((failure) {
        return Right(UserModel.fromFireStore(user));
      }, (userEntity) => Right(userEntity));
    } on CustomException catch (e) {
      return Left(ServerFailure(errorMessage: e.message));
    } catch (e) {
      log(
        "Exception in AuthRepoImpl.signInWithEmailAndPassword : ${e.toString()}",
      );
      return Left(
        ServerFailure(errorMessage: "Something went wrong. Please try again."),
      );
    }
  }

  @override
  Future<Either<Failure, UserEntity>> getUserData(String uid) async {
    try {
      final querySnapshot = await FirebaseFirestore.instance
          .collection(ApiKeys.addUserData)
          .where('uid', isEqualTo: uid)
          .limit(1)
          .get();

      if (querySnapshot.docs.isNotEmpty) {
        final userData = querySnapshot.docs.first.data();
        return Right(UserModel.fromJson(userData));
      } else {
        return Left(ServerFailure(errorMessage: "User data not found"));
      }
    } catch (e) {
      log("Exception in AuthRepoImpl.getUserData : ${e.toString()}");
      return Left(ServerFailure(errorMessage: "Failed to fetch user data"));
    }
  }

  @override
  Future<dynamic> addUserData({required UserEntity user}) async {
    await dataBaseService.addData(
      path: ApiKeys.addUserData,
      data: user.toMap(),
    );
  }

  Future<void> deleteUser(User? user) async {
    if (user != null) {
      await firebaseAuthService.deleteUser();
    }
  }

  @override
  Future<void> signOut() async {
    try {
      await firebaseAuthService.logOut();
      await sl<CacheHelper>().removeData(key: "token");
      log("User logged out and session cleared");
    } on Exception catch (e) {
      log("Error Logging out: ${e.toString()}");
      throw CustomException(message: "Failed to log out");
    }
  }

  @override
  Future<Either<Failure, UserEntity>> signInWithGoogle() async {
    User? user;
    try {
      user = await firebaseAuthService.signInWithGoogle();
      var userEntity = UserModel.fromFireStore(user);
      await addUserData(user: userEntity);
      await sl<CacheHelper>().saveData(key: "token", value: user.uid);
      return Right(userEntity);
    } on CustomException catch (e) {
      await deleteUser(user);
      return Left(ServerFailure(errorMessage: e.message));
    } catch (e) {
      await deleteUser(user);
      log("Exception in AuthRepoImpl.signInWithGoogle : ${e.toString()}");
      return Left(
        ServerFailure(errorMessage: "Something went wrong. Please try again."),
      );
    }
  }

  @override
  Future<Either<Failure, UserEntity>> signInWithFacebook() async {
    User? user;
    try {
      user = await firebaseAuthService.signInWithFacebook();
      var userEntity = UserModel.fromFireStore(user);
      await addUserData(user: userEntity);
      return Right(userEntity);
    } on CustomException catch (e) {
      await deleteUser(user);
      return Left(ServerFailure(errorMessage: e.message));
    } catch (e) {
      await deleteUser(user);
      log("Exception in AuthRepoImpl.signInWithFacebook : ${e.toString()}");
      return Left(
        ServerFailure(errorMessage: "Something went wrong. Please try again."),
      );
    }
  }
}
