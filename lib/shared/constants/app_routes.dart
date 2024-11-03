import 'package:chat_app/screens/chat_screen/chat_screen.dart';
import 'package:get/get.dart';

import '../../screens/home_screen/home_screen.dart';
import '../../screens/login_screen/login_screen.dart';

class AppRoutes {
  static const loginScreen = '/login';
  static const homeScreen = '/home';
  static const chatScreen = '/chat';
  static final routes = [
    GetPage(
      name: loginScreen,
      page: () => LoginScreen(),
    ),
    GetPage(
      name: homeScreen,
      page: () => HomeScreen(),
    ),
    GetPage(
        name: chatScreen,
        page: () =>
            ChatScreen(name: 'name', lastSeen: 'lastSeen', image: 'assets/images/batman.png')),
  ];
}
