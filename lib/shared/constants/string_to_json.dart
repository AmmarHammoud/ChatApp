import 'dart:developer';

import 'package:chat_app/models/message_model.dart';

extension NthOccurrenceOfSubstring on String {
  int nThIndexOf(String stringToFind, int n) {
    if (indexOf(stringToFind) == -1) return -1;
    if (n == 1) return indexOf(stringToFind);
    int subIndex = -1;
    while (n > 0) {
      subIndex = indexOf(stringToFind, subIndex + 1);
      n -= 1;
    }
    return subIndex;
  }

  bool hasNthOccurrence(String stringToFind, int n) {
    return nThIndexOf(stringToFind, n) != -1;
  }
}

MessageModel decodeEventToMessageModel({required String data}) {
  Map<String, int> requiredData = {
    'chat_id': 1,
    'message': 2,
    'id': 1, //3 for user,
    'updated_at': 1,
  };
  Map<String, String> values = {};
  try {
    //requiredData.i
    for (int i = 0; i < 4; i++) {
      String k = requiredData.keys.elementAt(i);
      int index = data.nThIndexOf(k, requiredData.values.elementAt(i));
      while (index < index + k.length) {
        if (values[k] == null) {
          values[k] = '';
        } else {
          values[k] = '${values[k]}${data[index]}';
        }
      }
    }
  } catch (e) {
    log('exception in decoding ${e.toString()}');
  }
  //id of user
  int i = data.nThIndexOf('id', 3);

  log('values from data-=-=-=-=-=-==-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=--=-=-=-=-=-=-=-=-\n: ${values.toString()}');
  return MessageModel(
      message: values['message']!, sendAt: values['updated_at']!, isMe: true);
}

///https://stackoverflow.com/a/69686082
void _() {
  String myString = 'I have a mobile. I have a cat.';
  String searchFor = 'have';
  int replaceOn = 2;
  String replaceText = 'newhave';
  String result = customReplace(myString, searchFor, replaceOn, replaceText);
  print(result);
}

String customReplace(
    String text, String searchText, int replaceOn, String replaceText) {
  Match result = searchText.allMatches(text).elementAt(replaceOn - 1);
  return text.replaceRange(result.start, result.end, replaceText);
}
