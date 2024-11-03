import 'dart:developer';

import 'package:chat_app/shared/cash_helper.dart';
import 'package:chat_app/shared/dio_helper/dio_helper.dart';
import 'package:pusher_channels_flutter/pusher_channels_flutter.dart';

class Pusher {
  late PusherChannelsFlutter pusher;

  Future<void> init({required onEventx, channelName = 'chat', roomId}) async {
    try {
      pusher = PusherChannelsFlutter.getInstance();
      await pusher.init(
        apiKey: 'd1ff2cdd9bc8a7b28b67',
        cluster: 'ap2',
        onSubscriptionError: onSubscriptionError,
        onConnectionStateChange: onConnectionStateChange,
        onSubscriptionSucceeded: onSubscriptionSucceeded,
        onEvent: onEventx,
        onError: onError,
        onAuthorizer: onAuthorizer,
      );
      await pusher.subscribe(channelName: '$channelName.$roomId');
      await pusher.connect();
    } catch (e) {
      log('Error initializing Pusher: ${e.toString()}');
    }
  }

  void onSubscriptionError(String message, dynamic e) {
    log("onSubscriptionError: $message Exception: $e");
  }

  void onSubscriptionSucceeded(String channelName, dynamic data) {
    log("onSubscriptionSucceeded: $channelName data: $data");
    final me = pusher.getChannel(channelName)?.me?.userInfo;
    log("Me: $me");
  }

  void onConnectionStateChange(from, to) {
    log('Connection state changed from: $from to: $to');
  }

  void onEvent(event) {
    log('on event in Pusher.init: ${event.data.toString()}');
  }

  void onError(String message, int? code, dynamic e) {
    log("Error: $message, Code: $code, Exception: ${e.toString()}");
  }

  void onDecryptionFailure(String event, String reason) {
    log("onDecryptionFailure: $event reason: $reason");
  }

  void onMemberAdded(String channelName, PusherMember member) {
    log("onMemberAdded: $channelName user: $member");
  }

  void onMemberRemoved(String channelName, PusherMember member) {
    log("onMemberRemoved: $channelName user: $member");
  }

  void onSubscriptionCount(String channelName, int subscriptionCount) {
    log("onSubscriptionCount: $channelName subscriptionCount: $subscriptionCount");
  }

  void onAuthorizer(
    String channelName,
    String socketId,
    dynamic options,
  ) async {
    log('socket_id=$socketId&channel_name=$channelName');
    // String token = CashHelper.getUserToken()!;
    // log('token in pusher init: $token');
    // DioHelper.broadcast(
    //         token: token, socketId: socketId, channelName: channelName)
    //     .then((value) {
    //   log(value.statusCode.toString());
    //   log(value.data.toString());
    //   return value.data;
    // }).onError((error, h) {
    //   log('error in onAuth m: ${error.toString()}');
    // });
  }

  void unsubscribeAndClose({String channelName = 'chat', required int roomId}) {
    pusher.unsubscribe(channelName: '$channelName.${roomId.toString()}');
    pusher.disconnect();
  }
}
