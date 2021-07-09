class ValidationUtil {
/**
 * e-mail 검증
 */
  static bool isEmail(String email) {
    if (email == null) {
      return true;
    }

    return RegExp(
            r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
        .hasMatch(email);
  }
}
