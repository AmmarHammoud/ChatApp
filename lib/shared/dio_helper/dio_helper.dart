import 'dart:developer';

import 'package:dio/dio.dart';

class DioHelper {
  static late Dio dio;

  static init() {
    dio = Dio(
      BaseOptions(
        baseUrl: 'http://10.0.2.2:8000/api/',
        receiveDataWhenStatusError: true,
        //responseType: ResponseType.plain,
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
      options: Options(
          headers: {'Accept': 'application/json'},
          followRedirects: false,
          validateStatus: (status) {
            return true;
          }),
    );
  }

  static Future<Response> logout() async {
    return await dio.get(
      'logout',
    );
  }

  static Future<Response> getAllChatsOfCurrentUser(
      {required String token, required int userId}) async {
    return await dio.get(
      'user/$userId/chat',
      options: Options(
          headers: {
            'Authorization': 'Bearer $token',
            'Accept': 'application/json',
          },
          followRedirects: false,
          validateStatus: (status) {
            return true;
          }),
    );
  }

  static Future<Response> getChatById(
      {required int chatId, required int page, required String token}) async {
    return await dio.get(
      'chat_message',
      data: {'chat_id': chatId, 'page': page},
      options: Options(
          headers: {
            //'Accept': 'application/json',
            'Authorization': 'Bearer $token'
          },
          followRedirects: false,
          validateStatus: (status) {
            return true;
          }),
    );
  }

  static Future<Response> sendMessage(
      {required int chatId,
      required String message,
      required String token}) async {
    return await dio.post(
      'chat_message',
      data: {'chat_id': chatId, 'message': message},
      options: Options(
          headers: {
            'Accept': 'application/json',
            'Authorization': 'Bearer $token'
          },
          followRedirects: false,
          validateStatus: (status) {
            return true;
          }),
    );
  }

  static Future<Response> broadcast(
      {required String token,
      required String socketId,
      required String channelName}) async {
    // var formData = FormData.fromMap({
    //   'socket_id': socketId,
    //   'channel_name': channelName,
    // });
    log('in dio broadcast: $socketId, $channelName');
    return await dio.post(
      'broadcasting/auth',
      //data: formData,
      data: {'socket_id': socketId, 'channel_name': channelName},
      options: Options(
        headers: {
          'Accept': 'application/json',
          'Authorization': 'Bearer $token',
        },
        followRedirects: false,
        //responseType: ResponseType.plain,
        validateStatus: (status) {
          return true;
        },
      ),
    );
  }
}
