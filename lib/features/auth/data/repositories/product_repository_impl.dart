  import 'package:mycatalog/core/constants/api_constants.dart';
import 'package:mycatalog/core/services/dio_client.dart';
import 'package:mycatalog/features/auth/data/models/product_model.dart';

@override 
  Future<List<ProductModel>> getProducts({ 
    int page = 1, 
    int limit = 10, 
    String? category, 
  }) async { 
    final response = await DioClient.instance.get( 
      ApiConstants.products, 
      queryParameters: { 
        'page': page, 
        'limit': limit, 
         'category': category, 
      }, 
    ); 
 
    final List<dynamic> data = response.data['data']; 
    return data.map((e) => ProductModel.fromJson(e)).toList(); 
  } 
 
  @override 
  Future<ProductModel> getProductById(int id) async { 
    final response = await DioClient.instance.get( 
      '${ApiConstants.products}/$id', 
    ); 
    return ProductModel.fromJson(response.data['data']); 
  }
 