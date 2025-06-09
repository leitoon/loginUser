


import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:teslo_shop/features/products/domain/domain.dart';
import 'package:teslo_shop/features/products/infrastructure/datasources/products_datasource_impl.dart';
import 'package:teslo_shop/features/products/infrastructure/repositories/products_repository_impl.dart';
import 'package:teslo_shop/features/products/presentation/providers/auth_provider.dart';

final productsRepositoryProvider = Provider<ProductsRepository>((ref) {
  final accessToken= ref.watch(authProvider).user?.token ?? '';
  final productsRepository = ProductsRepositoryImpl(
    ProductsDatasourceImpl(accesToken: accessToken)
  );
  
  return productsRepository;
},);