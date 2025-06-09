


import 'package:dio/dio.dart';
import 'package:teslo_shop/config/config.dart';
import 'package:teslo_shop/features/products/domain/domain.dart';
import 'package:teslo_shop/features/products/infrastructure/mappers/product_mapper.dart';

import '../errors/product_errors.dart';

class ProductsDatasourceImpl extends ProductsDatasource{

  late final Dio dio;
  final String accesToken;
  ProductsDatasourceImpl({
    required this.accesToken
  }): dio = Dio(BaseOptions(
    baseUrl: Enviorenment.apiUrl,
    headers: {
      'Authorization': 'Bearer $accesToken'
    }
    ));
  
  @override
  Future<Product> createUpdateProduct(Map<String, dynamic> productLike) {
    // TODO: implement createUpdateProduct
    throw UnimplementedError();
  }

  @override
  Future<Product> getProductById(String id) async{
    try{
      final response = await dio.get('/products/$id');
      final product = ProductMapper.jsonToEntity(response.data);
      return product;
    } on DioException catch(e){
      if(e.response==404) throw ProductNotFound();
      throw Exception();
    }
    catch (e){
throw Exception();
    }
  }

  @override
  Future<List<Product>> getProductsByPage({int limit = 1, int offset = 0}) async{
    final response = await dio.get<List>('/products?limit=$limit&offset=$offset');
    final List<Product> products = [];
    for(final product in response.data ??  []){
      products.add(ProductMapper.jsonToEntity(product));

    }
    return products;
  }

  @override
  Future<List<Product>> searchProductByTerm(String term) {
    // TODO: implement searchProductByTerm
    throw UnimplementedError();
  }

}