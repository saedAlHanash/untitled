import 'package:logger/logger.dart';

class LogService {
  Logger log = Logger();
  static const _debug = true;

  void d(String message) {
    if (_debug) {
      log.d(message);
    } else {
      return;
    }
  }

  void e(String message) {
    if (_debug) {
      log.e(message);
    } else {
      return;
    }
  }

  void i(String message) {
    if (_debug) {
      log.i(message);
    } else {
      return;
    }
  }

  void l(Level level, String message) {
    if (_debug) {
      log.log(level, message);
    } else {
      return;
    }
  }

  void v(String message) {
    if (_debug) {
      log.v(message);
    } else {
      return;
    }
  }

  void w(String message) {
    if (_debug) {
    } else {
      return;
    }
  }

  void wtf(String message) {
    if (_debug) {
      log.wtf(message);
    } else {
      return;
    }
  }
}
