

String? checkEmail(String? email) {
  final bool emailValid =
      RegExp(r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
          .hasMatch(email ?? '');
  return emailValid ? email : null;
}

bool isMoreThanOneMonth(int firstTimestamp, int secondTimestamp) {
  int result = (firstTimestamp - secondTimestamp).abs();

  final r = result > 2592000000;
  // if (r) loggerObject.f(r);
  return r;
}
