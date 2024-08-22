import 'package:dio/dio.dart';

class DioHelper {
  static late Dio dio;

  static init() {
    dio = Dio(
      BaseOptions(
        baseUrl: 'http://127.0.0.1:8000/api/',
        receiveDataWhenStatusError: true,
      ),
    );
  }

  static Future<Response> register(
      {required String name,
      required String password,
      required String passwordConfirmation}) async {
    return await dio.post(
      'auth/register',
      data: {
        'username': name,
        'password': password,
        'password_confirmation': passwordConfirmation,
      },
    );
  }

  static Future<Response> login(
      {required String email, required String password}) async {
    return await dio.post(
      'auth/login',
      data: {'email': email, 'password': password},
    );
  }

  static Future<Response> logout() async {
    return await dio.get(
      'logout',
    );
  }
}
