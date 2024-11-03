import 'package:flutter/material.dart';

class UserTextControllers {
  final TextEditingController nameController = TextEditingController();
  final TextEditingController emailController =
      TextEditingController(text: 'ammar052368034@gmail.com');
  final TextEditingController passwordController =
      TextEditingController(text: '123123123');
  final TextEditingController passwordConfirmationController =
      TextEditingController();

  dispose() {
    nameController.dispose();
    emailController.dispose();
    passwordController.dispose();
    passwordController.dispose();
  }
}
