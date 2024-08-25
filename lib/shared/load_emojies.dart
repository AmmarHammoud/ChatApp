import 'dart:convert';
import 'package:emoji_picker_flutter/emoji_picker_flutter.dart';
import 'package:flutter/services.dart' show rootBundle;


Category _findBestCategory(String c) {
  for (var x in Category.values) {
    if (x.toString().toLowerCase().substring(9) == c) return x;
  }
  //will not reach here
  return Category.ANIMALS;
}

List<String> _moreThanOneUnicode(String s) {
  List<String> ans = [];
  String t = '';
  for (int i = 0; i < s.length; i++) {
    if (s[i] == '-') {
      ans.add(t);
      t = '';
    } else {
      t += s[i];
    }
  }
  //"1F441-FE0F-200D-1F5E8-FE0F",
  //"1F41-FE0F-200D-1F5E8-FE0F",
  // if (s[4] == '-') {
  //   ans.add(s.substring(0, 3));
  // }
  // if (s[5] == '-') {
  //   ans.add(s.substring(0, 4));
  // }
  return ans;
}

Future<List<CategoryEmoji>> loadEmojis() async {
  List<String> categories = [];
  for (var cat in Category.values) {
    categories.add(cat.toString().toLowerCase().substring(9));
  }
  List<CategoryEmoji> categoryEmoji = [];
  Map<Category, List<Emoji>> m = {};
  final jsonString = await rootBundle.loadString('assets/emoji.json');
  final List<dynamic> jsonResponse = jsonDecode(jsonString);
  for (int i = 0; i < jsonResponse.length; i++) {
    for (var c in categories) {
      if (jsonResponse[i]['category'].toString().toLowerCase().contains(c)) {
        //make a category
        Category cat = _findBestCategory(c);
        if (m[cat] == null) {
          m[cat] = [];
        }
        var more = _moreThanOneUnicode(jsonResponse[i]['unified'].toString());
        for(int j = 0; j < more.length; j++){
          var t = '0x${more[j]}';
          m[cat]!.add(
              Emoji(String.fromCharCode(int.parse(t)), jsonResponse[i]['name']));
        }
        // var t = '0x${jsonResponse[i]['unified'].toString().substring(0, 4)}';
        // m[cat]!.add(
        //     Emoji(String.fromCharCode(int.parse(t)), jsonResponse[i]['name']));
      }
      //if(c == 'smileys'){log('smileys: ${m[Category.SMILEYS]}');}
    }
  }
  m.forEach((k, v) {
    categoryEmoji.add(CategoryEmoji(k, v));
  });
  // var x = '0x1F32D';
  // log('${categoryEmoji[0].emoji[0].emoji}, ${String.fromCharCode(int.parse(x))}, ${String.fromCharCode(int.parse('0x263A'))}');
  //log('${categoryEmoji[0].emoji[0].emoji}, \\${categoryEmoji[0].emoji[0].emoji}');
  // for(var e in defaultEmojiSet){
  //   log('default category emoji list: ${e.category.toString()}: ${e.emoji.toString()}');
  // }
  // for (var e in categoryEmoji) {
  //   log('category emoji list: ${e.category.toString()}: ');
  //   for(var x in e.emoji){
  //     log(x.emoji);
  //   }
  // }
  return categoryEmoji;
}
