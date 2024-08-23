import 'package:chat_app/screens/login_screen/logic/login_controller.dart';
import 'package:chat_app/shared/components/components.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class LoginScreen extends StatelessWidget {
  LoginScreen({super.key});

  var loginController = Get.put(LoginController());

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
              icon: Icons.person,
              controller: loginController.userNameController.value,
              errorText: 'errorText',
              hintText: 'user name',
              onChanged: (x) {},
            ),
            SizedBox(
              height: screenHeight * 0.02,
            ),
            ValidatedTextField(
              icon: Icons.key,
              controller: loginController.passwordController.value,
              errorText: 'errorText',
              hintText: 'password',
              onChanged: (x) {},
            ),
            SizedBox(
              height: screenHeight * 0.02,
            ),
            Obx(() {
              if (loginController.state.value == 'loading') {
                return const CircularProgressIndicator();
              }
              if (loginController.state.value != 'loading') {
                return ElevatedButton(
                  onPressed: () {
                    loginController.login(
                      context: context,
                        email: loginController.userNameController.value.text,
                        password: loginController.passwordController.value.text);
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
              }
              return Container();
            })
          ],
        ),
      ),
    );
  }
}
