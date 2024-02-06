import 'package:logger/logger.dart';

import '../core/api_manager/api_service.dart';

class LogService {

  static const _debug = true;

  void d(String message) {
    if (_debug) {

    } else {
      return;
    }
  }

  void e(String message) {
    if (_debug) {
      loggerObject.e(message);
    } else {
      return;
    }
  }

  void i(String message) {
    if (_debug) {

    } else {
      return;
    }
  }

  void l(Level level, String message) {
    if (_debug) {

    } else {
      return;
    }
  }

  void v(String message) {
    if (_debug) {

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
    } else {
      return;
    }
  }
}
