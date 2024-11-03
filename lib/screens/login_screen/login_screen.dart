import 'dart:developer';

import 'package:chat_app/screens/login_screen/logic/login_controller.dart';
import 'package:chat_app/screens/login_screen/logic/login_screen_states.dart';
import 'package:chat_app/shared/components/components.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class LoginScreen extends StatelessWidget {
  LoginScreen({super.key});

  final loginController = Get.put(LoginController());

  @override
  Widget build(BuildContext context) {
    var screenHeight = MediaQuery.of(context).size.height;
    var screenWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
        title: const Text('Login'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          children: [
            ValidatedTextField(
              // validator:
              //     loginController.userTextValidators.value.emailValidator,
              icon: Icons.mail,
              controller:
                  loginController.userTextControllers.value.emailController,
              errorText: 'email cannot be empty',
              hintText: 'email',
              onChanged: (x) {},
            ),
            SizedBox(
              height: screenHeight * 0.02,
            ),
            ValidatedTextField(
              // validator:
              //     loginController.userTextValidators.value.passwordValidator,
              icon: Icons.key,
              controller:
                  loginController.userTextControllers.value.passwordController,
              errorText: 'password cannot be empty',
              hintText: 'password',
              onChanged: (x) {},
            ),
            SizedBox(
              height: screenHeight * 0.02,
            ),
            Obx(() {
              if (loginController.state.value is LoginScreenLoadingState) {
                return const CircularProgressIndicator();
              }
              return ElevatedButton(
                onPressed: () {
                  loginController.login(
                    context: context,
                    email: loginController
                        .userTextControllers.value.emailController.value.text,
                    password: loginController.userTextControllers.value
                        .passwordController.value.text,
                  );
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.blue,
                  minimumSize: Size(screenWidth * 0.3, screenHeight * 0.07),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                child: const Text(
                  'Login',
                  style: TextStyle(color: Colors.white),
                ),
              );
            })
          ],
        ),
      ),
    );
  }
}
