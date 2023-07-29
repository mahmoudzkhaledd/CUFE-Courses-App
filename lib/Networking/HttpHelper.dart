import 'package:dio/dio.dart';

class HttpHelper {
  static String baseUrl = "https://cufe-courses-production.up.railway.app/";
  static late Dio instance;
  static String accessToken = "";
  static void initDio() {
    BaseOptions options = BaseOptions(
      baseUrl: baseUrl,
      receiveTimeout: const Duration(seconds: 5),
      connectTimeout: const Duration(seconds: 5),
    );
    instance = Dio(options);
    instance.interceptors.add(
      InterceptorsWrapper(
        onRequest: (options, handeler) async {
          options.headers['token'] = 'Bearer $accessToken';
          return handeler.next(options);
        },
      ),
    );
  }
}