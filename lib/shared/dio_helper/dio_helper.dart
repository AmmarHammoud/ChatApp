import 'dart:developer';

import 'package:chat_app/shared/dio_helper/end_points.dart';
import 'package:dio/dio.dart';

class DioHelper {
  static late Dio dio;

  //192.168.238.17
  static init({bool emulator = false}) {
    dio = Dio(
      BaseOptions(
        baseUrl: 'http://${emulator ? '10.0.2.2' : '192.168.238.17'}:8000/api/',
        headers: {'Accept': 'application/json'},
        receiveDataWhenStatusError: true,
        followRedirects: false,
        validateStatus: (status) {
          return true;
        },
      ),
    );
  }

  static Future<Response> register({
    required String name,
    required String email,
    required String password,
  }) async {
    return await dio.post(
      EndPoints.register,
      data: {
        'name': name,
        'email': email,
        'password': password,
      },
    );
  }

  static Future<Response> login(
      {required String email, required String password}) async {
    return await dio.post(
      EndPoints.login,
      data: {'email': email, 'password': password},
    );
  }

  static Future<Response> logout() async {
    return await dio.get(
      EndPoints.logout,
    );
  }

  static Future<Response> getAllChatsOfCurrentUser(
      {required String token}) async {
    return await dio.get(
      EndPoints.getUserConversation,
      options: Options(
        headers: {
          'Authorization': 'Bearer $token',
        },
      ),
    );
  }

  static Future<Response> getChatById({
    required int chatId,
    required String token,
    int offset = 0,
  }) async {
    return await dio.get(
      '${EndPoints.getChatMessages}/$chatId',
      data: {'offset': offset},
      options: Options(
        headers: {'Authorization': 'Bearer $token'},
      ),
    );
  }

  static Future<Response> sendMessage({
    required int chatId,
    required String message,
    required String token,
  }) async {
    return await dio.post(
      EndPoints.sendMessage,
      data: {'conversation_id': chatId, 'message': message},
      options: Options(
        headers: {'Authorization': 'Bearer $token'},
      ),
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
          'Authorization': 'Bearer $token',
        },
      ),
    );
  }
}
