import 'extensions.dart';
import 'package:dog/dog.dart';
class LogUtils {
  static const int _LOG_LEVEL_DEBUG = 0;
  static const int _LOG_LEVEL_INFO = 1;
  static const int _LOG_LEVEL_WARNING = 2;
  static const int _LOG_LEVEL_ERROR = 3;
  static const int _LOG_LEVEL_NONE = 4;

  static int _logLevel = _LOG_LEVEL_DEBUG;

  static printD(dynamic msg) {
    if (_doPrint(_LOG_LEVEL_DEBUG)) _printLog('', "D -> ", msg);
  }

  static d(String tag, dynamic msg) {
    if (_doPrint(_LOG_LEVEL_DEBUG)) _printLog(tag, "D -> ", msg);
  }

  static i(String tag, dynamic msg) {
    if (_doPrint(_LOG_LEVEL_INFO)) _printLog(tag, "I -> ", msg);
  }

  static w(String tag, dynamic msg) {
    if (_doPrint(_LOG_LEVEL_WARNING)) _printLog(tag, "W ->", msg);
  }

  static e(String tag, dynamic msg) {
    if (_doPrint(_LOG_LEVEL_ERROR)) _printLog(tag, "E -> ", msg);
  }

  static bool _doPrint(final int logLevel) {
    return logLevel >= _logLevel;
  }

  static void _printLog(String tag, String level, dynamic message) {
    StringBuffer sb = StringBuffer();
    sb
      ..write(DateTime.now().toHHmmss())
      ..write(" ")
      ..write(level)
      ..write(tag ?? '')
      ..write(': ')
      ..write(message);
    print(sb.toString());
  }

  /// 日志级别debug,带堆栈输出的彩色日志
  static dogD(Object msg, {String? tag, int wrapWidth = -1, bool prettyJson = false}) {
    if (_doPrint(_LOG_LEVEL_DEBUG)) {
      if (msg == null) return;
      if (msg is String) {
        if (tag == null) tag = 'DEBUG';
        if (wrapWidth > 0 && (msg as String).length > wrapWidth) {
          msg = (msg as String).substring(0, wrapWidth);
        }
        dog.d('$msg', tag: tag);
      } else {
        if (tag == null) tag = "DEBUG";
        dog.d(msg, tag: tag);
      }
    }
  }

  /// 日志级别error,带堆栈输出的彩色日志
  static dogE(dynamic exception, {String? tag, int wrapWidth = -1}) {
    dog.e(exception, tag: tag);
  }
}