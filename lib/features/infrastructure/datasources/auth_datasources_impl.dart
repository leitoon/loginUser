


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
  Future<User> checkAuthStatus(String token) async {
    try {
      final response= await dio.get('/auth/check-status',
      options: Options(
        headers: {
          'Authorization' : 'Bearer $token'
        }
      )
      );
      final user = UserMapper.userJsonToEntity(response.data);
      return user;
      
    } on DioException catch (e) {
      if( e.response?.statusCode == 401 ){
         throw CustomError('Token incorrecto' );
      }
      
      throw Exception();
    }catch (e) {
      throw Exception();
    }
  }

  @override
  Future<User> login(String email, String password)async{
      try {
      final response = await dio.post('/auth/login', data: {
        'email': email,
        'password': password
      });

      final user = UserMapper.userJsonToEntity(response.data);
      return user;
      
    } on DioException catch (e) {
      if( e.response?.statusCode == 401 ){
         throw CustomError(e.response?.data['message'] ?? 'Credenciales incorrectas' );
      }
      if ( e.type == DioExceptionType.connectionTimeout ){
        throw CustomError('Revisar conexión a internet');
      }
      throw Exception();
    } catch (e) {
      throw Exception();
    }
  }

  @override
  Future<User> register(String email, String password, String fullName) {
    // TODO: implement register
    throw UnimplementedError();
  }


}