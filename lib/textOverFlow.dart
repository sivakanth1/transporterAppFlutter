import 'package:characters/characters.dart';

class TextOverFlow {
  String textOverflowEllipsis(String text, int limit) {
    var myChars = text.characters;
    if (myChars.length > limit) {
      return '${myChars.take(limit - 1)}…';
    } else {
      return text;
    }
  }
}
