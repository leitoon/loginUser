

import 'package:teslo_shop/features/domain/domain.dart';
import '../infrastructure.dart';

class AuthRepositoryImpl extends AuthRepository {
  final AuthDatasource datasource;

  AuthRepositoryImpl(
    AuthDatasource ? datasource
  ): datasource= datasource ?? AuthDatasourcesImpl();
  @override
  Future<User> checkAuthStatus(String token) {
    return datasource.checkAuthStatus(token);
  }

  @override
  Future<User> login(String email, String password) {
    // TODO: implement login
    return datasource.login(email, password);
  }

  @override
  Future<User> register(String email, String password, String fullName) {
    // TODO: implement register
    return datasource.register(email, password, fullName);
  }

}