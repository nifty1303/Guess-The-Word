import 'dart:convert';
import 'dart:math';
import 'package:http/http.dart';

class RandomWord {
  //-----------------------| Get random word from the API |----------------------------
  Future getWord() async {
    try {
      Response response = await get("https://api.datamuse.com/words?sp=${_getRandomString(1)}*&max=10");
      List<dynamic> words = jsonDecode(response.body) ;
      return words[Random().nextInt(9)];
    } catch (e) {
      print(e);
      return null;
    }
  }
  //====================================================================================

  //----------------------------| Generate Random start letter |--------------------------
  String _getRandomString(int length) {
    const _chars = 'AaBbCcDdEeFfGgHhIiJjKkLlMmNnOoPpQqRrSsTtUuVvWwXxYyZz';
    Random _rnd = Random();
    return String.fromCharCodes(Iterable.generate(
        length, (_) => _chars.codeUnitAt(_rnd.nextInt(_chars.length))));
  }
  //======================================================================================
}
