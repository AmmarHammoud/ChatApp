import 'package:flutter/material.dart';

import '../components/my_icon.dart';

enum MessageStatus {
  sending,
  sent,
  delivered,
  seen,
}

Icon messageStateIcon(
    {required MessageStatus messageStatus,
    double size = 16,
    Color color = Colors.grey}) {
  if (messageStatus == MessageStatus.sending) {
    return myIcon(icon: Icons.watch_later_outlined, size: size, color: color);
  } else if (messageStatus == MessageStatus.sent) {
    return myIcon(icon: Icons.done, size: size, color: color);
  } else if (messageStatus == MessageStatus.delivered) {
    return myIcon(icon: Icons.done_all, size: size, color: color);
  }
  return myIcon(
    icon: Icons.done_all,
    size: size,
    color: Colors.blue,
  );
}
