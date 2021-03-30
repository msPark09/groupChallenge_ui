import 'dart:convert';

class JwtHelper {
  Map<String, dynamic> parseJwt(String token) {
    final parts = token.split('.');
    print('token :: $token');
    // if (parts.length != 3) {
    //   throw Exception('invalid token');
    // }

    final payload = _decodeBase64(parts[1]);
    final payloadMap = json.decode(payload);
    if (payloadMap is! Map<String, dynamic>) {
      throw Exception('invalid payload');
    }

    return payloadMap;
  }

  bool expired(String token) {
    var parsed = parseJwt(token);
    //print('★★★★★ parsed JWT => ${parsed.toString()}, exp => ${parsed['exp']*1000}');

    var currentTime = DateTime.now().millisecondsSinceEpoch;
    var expiredTime = parsed['exp'] * 1000;
    print('★★★★★ current time => $currentTime exp time => $expiredTime');

    return expiredTime < currentTime;
  }

  String _decodeBase64(String str) {
    String output = str.replaceAll('-', '+').replaceAll('_', '/');

    switch (output.length % 4) {
      case 0:
        break;
      case 2:
        output += '==';
        break;
      case 3:
        output += '=';
        break;
      default:
      // throw Exception('Illegal base64url string!"');
    }

    print('_decodeBase64 :: $str');
    print('_decodeBase64 ::output $output');
    print('_decodeBase64 ::utf8 ${utf8.decode(base64Url.decode(output))}');

    return utf8.decode(base64Url.decode(output));
  }
}
