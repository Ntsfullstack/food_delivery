import 'dart:io';
import '../../base/networking/api.dart';
import '../../base/networking/api_response.dart';
import '../../base/networking/api_response_paging.dart';
import '../../base/networking/constants/endpoint.dart';
import '../../models/food/dishes.dart';
import 'package:dio/dio.dart';


class ProductRepositories {
  late ApiService _service;

  ProductRepositories({required ApiService apiService}) {
    _service = apiService;
  }

  Future<APIResponsePaging<List<Dishes>>> getListDishes({
    String page = "1",
    String limit = "1000",

  }) async {
    try {
      var data = {
        "page": page,
        "limit": limit,

      };

      var res = await _service.get(Endpoints.getListDishes, queryParameters: data);

      return APIResponsePaging.fromList(
          res,
              (json) => APIResponsePaging.fromLJsonListT(
              json, (json2) => Dishes.fromJson(json2 as Map<String, dynamic>)));
    } catch (e) {
      print(e.toString());
      rethrow;
    }
  }
  Future<APIResponse<Dishes>> getDetailDishes({required String dishId}) async {
    try {
      var res = await _service.get("${Endpoints.getListDishes}/$dishId");

      print('Raw dish response: $res');

      return APIResponse.fromJson(
          res,
              (json) {
            print('Parsing dish data in repository: $json');
            if (json is List && json.isNotEmpty) {
              return Dishes.fromJson(json[0] as Map<String, dynamic>);
            }
            return Dishes.fromJson(json as Map<String, dynamic>);
          }
      );
    } catch (e) {
      print('Error fetching dish details: $e');
      rethrow;
    }
  }
  
  Future<APIResponse<Dishes>> createDish({required Dishes dish}) async {
    try {
      print('Creating dish with data: ${dish.toJson()}');
      
      // Create FormData for multipart upload
      FormData formData = FormData.fromMap({
        'name': dish.name ?? '',
        'description': dish.description ?? '',
        'price': dish.price?.toString() ?? '0',
        'preparation_time': dish.preparationTime?.toString() ?? '',
        'category_id': dish.categoryId?.toString() ?? '',
      });

      // Add image file if provided
      if (dish.image != null && dish.image!.isNotEmpty) {
        print('Processing image: ${dish.image}');
        
        // Check if it's a file path (local file) - handle all platforms
        File imageFile = File(dish.image!);
        print('Image file exists: ${await imageFile.exists()}');
        print('Image file path: ${imageFile.path}');
        
        if (await imageFile.exists()) {
          // Get file extension to determine MIME type
          String extension = imageFile.path.split('.').last.toLowerCase();
          String mimeType = 'image/jpeg'; // default
          
          switch (extension) {
            case 'png':
              mimeType = 'image/png';
              break;
            case 'jpg':
            case 'jpeg':
              mimeType = 'image/jpeg';
              break;
            case 'gif':
              mimeType = 'image/gif';
              break;
            case 'webp':
              mimeType = 'image/webp';
              break;
          }
          
          print('File extension: $extension, MIME type: $mimeType');
          
          formData.files.add(MapEntry(
            'image',
            await MultipartFile.fromFile(
              imageFile.path,
              filename: imageFile.path.split('/').last,
              contentType: DioMediaType.parse(mimeType),
            ),
          ));
          print('Image file added to FormData');
        }
      } else {
        print('No image provided');
      }

      print('Sending FormData to API...');
      var res = await _service.post(
        Endpoints.getListDishes,
        data: formData,
      );
      
      print('API response: $res');
      return APIResponse.fromJson(res, (json) => Dishes.fromJson(json));
    } catch (e) {
      print('Error creating dish: $e');
      rethrow;
    }
  }
  
  Future<APIResponse<Dishes>> updateDish({required Dishes dish, String? imagePath}) async {
    try {
      // Create FormData for multipart upload
      FormData formData = FormData.fromMap({
        'name': dish.name ?? '',
        'description': dish.description ?? '',
        'price': dish.price?.toString() ?? '0',
        'preparation_time': dish.preparationTime?.toString() ?? '',
        'category_id': dish.categoryId?.toString() ?? '',
      });

      // Add image file if provided
      if (imagePath != null && imagePath.isNotEmpty) {
        print('Processing image for update: $imagePath');
        
        // Check if it's a file path (local file) - handle all platforms
        File imageFile = File(imagePath);
        print('Image file exists: ${await imageFile.exists()}');
        print('Image file path: ${imageFile.path}');
        
        if (await imageFile.exists()) {
          // Get file extension to determine MIME type
          String extension = imageFile.path.split('.').last.toLowerCase();
          String mimeType = 'image/jpeg'; // default
          
          switch (extension) {
            case 'png':
              mimeType = 'image/png';
              break;
            case 'jpg':
            case 'jpeg':
              mimeType = 'image/jpeg';
              break;
            case 'gif':
              mimeType = 'image/gif';
              break;
            case 'webp':
              mimeType = 'image/webp';
              break;
          }
          
          print('File extension: $extension, MIME type: $mimeType');
          
          formData.files.add(MapEntry(
            'image',
            await MultipartFile.fromFile(
              imageFile.path,
              filename: imageFile.path.split('/').last,
              contentType: DioMediaType.parse(mimeType),
            ),
          ));
          print('Image file added to FormData for update');
        }
      } else {
        print('No image provided for update');
      }

      print('Sending FormData to API for update...');
      var res = await _service.put(
        "${Endpoints.getListDishes}/${dish.id}",
        data: formData,
      );
      
      print('API response for update: $res');
      return APIResponse.fromJson(res, (json) => Dishes.fromJson(json));
    } catch (e) {
      print('Error updating dish: $e');
      rethrow;
    }
  }

  Future<APIResponse<Dishes>> rateDish({
    required String dishId,
    required int rating,
    String? comment,
  }) async {
    try {
      var data = {
        'rating': rating,
        if (comment != null && comment.isNotEmpty) 'comment': comment,
      };
      var res = await _service.post(
        "${Endpoints.rateDish}/$dishId/rate",
        data: data,
      );

      print('Rate dish response: $res');

      return APIResponse.fromJson(
        res,
        (json) {
          // API returns { statusCode: 200, message: "...", dish: {...} }
          if (json is Map<String, dynamic> && json.containsKey('dish')) {
            return Dishes.fromJson(json['dish'] as Map<String, dynamic>);
          }
          // Fallback for other formats
          if (json is List && json.isNotEmpty) {
            return Dishes.fromJson(json[0] as Map<String, dynamic>);
          }
          return Dishes.fromJson(json as Map<String, dynamic>);
        },
      );
    } catch (e) {
      print('Error rating dish: $e');
      rethrow;
    }
  }

  Future<APIResponse<Dishes>> updateAvailability({required int dishId, required bool available}) async {
    try {
      var res = await _service.patch(
        "${Endpoints.getListDishes}/$dishId/availability",
        data: {
          'available': available,
        },
      );
      return APIResponse.fromJson(res, (json) {
        final data = (json is Map && json.containsKey('data')) ? json['data'] : json;
        final bool? avail = (data is Map) ? data['available'] as bool? : null;
        return Dishes(id: dishId, available: avail ?? available);
      });
    } catch (e) {
      print('Error updating availability: $e');
      rethrow;
    }
  }
}
