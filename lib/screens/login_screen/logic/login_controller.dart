import 'dart:developer';

import 'package:chat_app/models/user_model.dart';
import 'package:chat_app/shared/cash_helper.dart';
import 'package:chat_app/shared/components/show_toast.dart';
import 'package:chat_app/shared/dio_helper/dio_helper.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class LoginController extends GetxController {
  var userNameController = TextEditingController(text: 'u1@a.com').obs;
  var passwordController = TextEditingController(text: '123123').obs;
  var state = 'initial'.obs;

  void login(
      {required context, required String email, required String password}) {
    //log('email: $email, password: $password');
    state('loading');
    DioHelper.login(email: email, password: password).then((value) {
      log(value.data.toString());
      UserModel userModel = UserModel.fromJson(value.data['data']['user']);
      state('success');

      if (value.data['success'].toString() == 'true') {
        Get.toNamed('/home');
        showToast(
            context: context, text: value.data['message'], color: Colors.green);
        CashHelper.putUser(userToken: value.data['data']['token']);
        CashHelper.putUserId(id: userModel.id);
      } else {
        showToast(
            context: context, text: value.data['message'], color: Colors.red);
      }
    }).onError((error, x) {
      log('error login: ${error.toString()}');
      state('error');
    });
  }
}
