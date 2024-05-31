import 'package:dartz/dartz.dart';
import 'package:instafake_flutter/core/data/models/user_model.dart';
import 'package:instafake_flutter/core/data/sources/local_user_model_data_source.dart';
import 'package:instafake_flutter/core/data/sources/remote_user_model_data_source.dart';
import 'package:instafake_flutter/utils/log.dart';
import 'package:http/http.dart' as http;

abstract class UserModelRepository {
  Future<Either<Exception, UserModel>> login(String username, String password);
  Future<Either<Exception, UserModel>> getLocalData();
  Future<Either<Exception, http.Response>> register(String username, String password, String email, String realname);
  Future<void> logout();
}

class UserModelRepositoryImpl extends UserModelRepository{
  final RemoteUserModelDataSource _remoteDataSource;
  final LocalUserModelDataSource _localDataSource;

  UserModelRepositoryImpl({required LocalUserModelDataSource localDataSource, required RemoteUserModelDataSource remoteDataSource}) : _localDataSource = localDataSource, _remoteDataSource = remoteDataSource;

  @override
  Future<Either<Exception, UserModel>> login(String username, String password) async {
    try {
      final response = await _remoteDataSource.login(username, password);
      final metadata = response['metadata'];
      Log.yellow("Metadata : ${metadata.toString()}");
      Log.yellow("Username : ${metadata['username']}");
      Log.yellow("Created At : ${metadata['createdAt'].toString()}");
      final authResponse = UserModel(
        id: metadata['id'], 
        token: response['token'], 
        username: metadata['username'], 
        realname: metadata['realname'], 
        email: metadata['email'], 
        // createdAt: DateFormat("yyyyMMddHHmmss").parse(metadata['created_at'])
        createdAt: DateTime.parse(metadata['createdAt']),
      );
      await _localDataSource.saveUserMetadata(authResponse);
      return Right(authResponse);
    } on Exception catch (e) {
      return Left(Exception("Login failed : ${e.toString()}"));
    }
  }

  @override
  Future<Either<Exception, http.Response>> register(
    String username,
    String password,
    String email,
    String realname
  ) async {
    try {
      final response = await _remoteDataSource.register(
        username,
        email,
        password,
        realname
      );
      return Right(response);
    } on Exception catch (e) {
      return Left(Exception("Registration failed : ${e.toString()}"));
    }
  }
  
  @override
  Future<Either<Exception, UserModel>> getLocalData() async {
    try{
      UserModel? userData = _localDataSource.getUserMetadata();
      if(userData==null){
        return Left(Exception("User data not found"));
      }
      return Right(userData);
    } on Exception catch (e) {
      return Left(Exception("Registration failed : ${e.toString()}"));
    }
  }
  
  @override
  Future<void> logout() async {
    _localDataSource.clearUserMetadata();
  }

}