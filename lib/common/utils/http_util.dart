import 'package:dio/dio.dart';
import 'package:ulearning_app/common/values/constant.dart';
import 'package:ulearning_app/global.dart';

class HttpUtil {
  static final HttpUtil _instance = HttpUtil._internal();

  factory HttpUtil() {
    return _instance;
  }

  late Dio dio;

  HttpUtil._internal() {
    BaseOptions options = BaseOptions(
      baseUrl: AppConstants.serverApiUrl,
      connectTimeout: Duration(seconds: 100),
      receiveTimeout: Duration(seconds: 100),
      headers: {},
      contentType: "application/json: charset=utf-8",
      responseType: ResponseType.json,
    );

    dio = Dio(options);
  }

  Future post(
    String path, {
      dynamic data,
      Map <String, dynamic>? queryParameters,
      Options? options,
    }
  ) async {
    Options requestOptions = options ?? Options();
    requestOptions.headers = requestOptions.headers ?? {};
    Map <String, dynamic>? authorization = getAuthorizationHeader();
    
    if (authorization != null) {
      requestOptions.headers!.addAll(authorization);
    }

    var response = await dio.post(
      path,
      data: data,
      queryParameters: queryParameters,
      options: requestOptions,
    );
    return response.data;
  }

  Future get(
    String path, {
      dynamic data,
      Map <String, dynamic>? queryParameters,
      Options? options,
    }
  ) async {
    Options requestOptions = options ?? Options();
    requestOptions.headers = requestOptions.headers ?? {};
    Map <String, dynamic>? authorization = getAuthorizationHeader();
    
    if (authorization != null) {
      requestOptions.headers!.addAll(authorization);
    }

    var response = await dio.get(
      path,
      data: data,
      queryParameters: queryParameters,
      options: requestOptions,
    );
    return response.data;
  }

  Map <String, dynamic>? getAuthorizationHeader() {
    Map <String, dynamic> headers = <String, dynamic>{};
    String accessToken = Global.storageService.getUserToken();

    if (accessToken.isNotEmpty) {
      headers['Authorization'] = 'Bearer $accessToken';
    }

    return headers;
  }

}