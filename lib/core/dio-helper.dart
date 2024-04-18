

import 'package:dio/dio.dart';




class DioHelper2 {
  static late Dio dio;

  static void init() {
    dio = Dio(
      BaseOptions(
        baseUrl: 'https://onlinestore-xors.onrender.com/api/v1/',
        headers: {
          'Content-Type': 'application/json',
          // Any other default headers
        },
      ),
    );
  }

  static Future<Response> postData({
    required Map<String, dynamic> data,
    required String url,
    String? token,
  }) async {
    try {
      dio.options.headers['Authorization'] = 'Bearer $token';
      final response = await dio.post(url, data: data);
      return response;
    } on DioError catch (e) {
      // Handle Dio-specific errors
      throw e;
    }
  }


  static Future<Response> getData({
    required String url,
    required Map<String, dynamic> data,
    String? token, // Optional token parameter
  }) async {
    Map<String, dynamic> headers = {};
    if (token != null) {
      headers['Authorization'] = 'Bearer $token';
    }

    return await dio.get(
      url,
      queryParameters: data,
      options: Options(headers: headers), // Include the token in headers
    );
  }


  static Future<Response> delete(
      {required String url, required dynamic data,String ?token,content='application/json;charset=UTF-8',query,}) async {
    return await dio.delete(
        url,
        data: data,
        queryParameters: query,
        options: Options(
          headers: {
            "Content-Type": content,
            "token":token
          },
        )
    );
  }
}
