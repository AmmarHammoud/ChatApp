import 'package:flutter/material.dart';

class LastSeen extends StatelessWidget {
  const LastSeen({super.key, required this.lastSeen});
  final String lastSeen;
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(lastSeen.toString(), style: const TextStyle(fontSize: 10),),
      ],
    );
  }
}
