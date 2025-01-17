


import 'package:dio/dio.dart';
import 'package:teslo_shop/config/config.dart';
import 'package:teslo_shop/features/domain/domain.dart';
import 'package:teslo_shop/features/infrastructure/infrastructure.dart';

class AuthDatasourcesImpl extends AuthDatasource {
  final dio = Dio(
    BaseOptions(
      baseUrl: Enviorenment.apiUrl
    )
  );
  @override
  Future<User> checkAuthStatus(String token) {
    // TODO: implement checkAuthStatus
    throw UnimplementedError();
  }

  @override
  Future<User> login(String email, String password)async{
    try{
      final response = await dio.post('/auth/login', data: {
        'email': email,
        'password':password
      });
      final user=UserMapper.userJsonToEntity(response.data);
      return user;
    }catch (e){
      throw WrongCredentials();

    }
  }

  @override
  Future<User> register(String email, String password, String fullName) {
    // TODO: implement register
    throw UnimplementedError();
  }


}