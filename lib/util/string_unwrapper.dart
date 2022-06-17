import 'dart:convert';
import 'dart:ffi';

class StringUnwrapper {
  static String unwrap(Array<Uint8> bytes) {
    String buf = "";
    int i = 0;
    while (bytes[i] != 0) {
      buf += utf8.decode([bytes[i]]);
      i += 1;
    }
    return buf;
  }
}
