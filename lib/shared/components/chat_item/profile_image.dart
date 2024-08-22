import 'package:flutter/material.dart';

class ProfileImage extends StatelessWidget {
  const ProfileImage({super.key, required this.image});
  final String image;
  @override
  Widget build(BuildContext context) {
    // return Container(
    //   decoration: const BoxDecoration(
    //       borderRadius: BorderRadius.all(Radius.circular(20))),
    //   child: Image.asset(
    //     'assets/images/whatsapp.png',
    //     scale: 4,
    //   ),
    // );
    return ClipOval(
      child: Image.asset(
        image,
        scale: 5,
      ),
    );
  }
}
