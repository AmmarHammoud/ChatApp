import 'dart:developer';

import 'package:chat_app/models/user_model.dart';
import 'package:chat_app/screens/login_screen/logic/login_screen_states.dart';
import 'package:chat_app/shared/cash_helper.dart';
import 'package:chat_app/shared/components/show_toast.dart';
import 'package:chat_app/shared/constants/app_routes.dart';
import 'package:chat_app/shared/constants/user_text_controllers.dart';
import 'package:chat_app/shared/constants/user_text_validators.dart';
import 'package:chat_app/shared/dio_helper/dio_helper.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class LoginController extends GetxController {
  late Rx<UserTextControllers> userTextControllers;
  late Rx<UserTextValidators> userTextValidators;
  late Rx<LoginScreenStates> state;

  @override
  void onInit() {
    // userNameController =
    //     TextEditingController(text: 'ammar052368034@gmail.com').obs;
    // passwordController = TextEditingController(text: '123123123').obs;
    userTextControllers = UserTextControllers().obs;
    userTextValidators = UserTextValidators().obs;
    state = LoginScreenStates().obs;
    state.value = LoginScreenInitialState();
    super.onInit();
  }

  void login({
    required context,
    required String email,
    required String password,
  }) {
    log('email: $email, password: $password');
    state.value = LoginScreenLoadingState();
    DioHelper.login(email: email, password: password).then((value) {
      UserModel user = UserModel.fromJson(value.data['data']['user']);
      state.value = LoginScreenSuccessState();
      log('login data: ${value.data}');
      if (value.statusCode == 200) {
        Get.offAllNamed(AppRoutes.homeScreen);

        CashHelper.saveUser(user: user);
        CashHelper.saveUserToken(token: value.data['data']['token']);

        showToast(
            context: context, text: value.data['message'], color: Colors.green);
        // CashHelper.putUser(userToken: value.data['data']['token']);
        // CashHelper.saveUserToken(token: token)
        // CashHelper.putUserId(id: userModel.id);
      } else {
        showToast(
            context: context, text: value.data['message'], color: Colors.red);
      }
    }).onError((error, x) {
      log('error login: ${error.toString()}');
      state.value = LoginScreenErrorState(error.toString());
    });
  }

  @override
  void onClose() {
    userTextControllers.value.dispose();
    super.onClose();
  }
}
