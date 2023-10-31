import 'extensions.dart';
import 'package:dog/dog.dart';
class LogUtils {
  static const int _LOG_LEVEL_DEBUG = 0;
  static const int _LOG_LEVEL_INFO = 1;
  static const int _LOG_LEVEL_WARNING = 2;
  static const int _LOG_LEVEL_ERROR = 3;
  static const int _LOG_LEVEL_NONE = 4;

  static const int _logLevel = _LOG_LEVEL_DEBUG;

  static printD(dynamic msg, {bool longLog = false}) {
    if (_doPrint(_LOG_LEVEL_DEBUG)) _printLog('', "D -> ", msg, longLog: longLog);
  }

  static d(String tag, dynamic msg, {bool longLog = false}) {
    if (_doPrint(_LOG_LEVEL_DEBUG)) _printLog(tag, "D -> ", msg, longLog: longLog);
  }

  static i(String tag, dynamic msg, {bool longLog = false}) {
    if (_doPrint(_LOG_LEVEL_INFO)) _printLog(tag, "I -> ", msg, longLog: longLog);
  }

  static w(String tag, dynamic msg, {bool longLog = false}) {
    if (_doPrint(_LOG_LEVEL_WARNING)) _printLog(tag, "W ->", msg, longLog: longLog);
  }

  static e(String tag, dynamic msg, {bool longLog = false}) {
    if (_doPrint(_LOG_LEVEL_ERROR)) _printLog(tag, "E -> ", msg, longLog: longLog);
  }


  static void _printAll(String prefix, String msg, int maxLength) {
    var outStr = StringBuffer();
    print("$prefix------------------------------------------------------------------------------------------------------------");
    for (var index = 0; index < msg.length; index++) {
      outStr.write(msg[index]);
      if (index % maxLength == 0 && index != 0) {
        print("$prefix| $outStr");
        outStr.clear();
        var lastIndex = index + 1;
        if (msg.length - lastIndex < maxLength) {
          var remainderStr = msg.substring(lastIndex, msg.length);
          print("$prefix| $remainderStr");
          break;
        }
      }
    }
    print("$prefix------------------------------------------------------------------------------------------------------------");
  }

  static bool _doPrint(final int logLevel) {
    return logLevel >= _logLevel;
  }

  static void _printLog(String tag, String level, dynamic message, {bool longLog = false}) {
    StringBuffer prefix = StringBuffer();
    prefix
      ..write(DateTime.now().toHHmmss())
      ..write(" ")
      ..write(level)
      ..write(tag ?? '')
      ..write(': ');

    if (longLog) {
      ///打印完整日志
      _printAll(prefix.toString(), message, 120);
    } else {
      /// 超长会截断
      print("${prefix.toString()}$message");
    }
  }

  /// 日志级别debug,带堆栈输出的彩色日志
  static dogD(Object msg, {String? tag, int wrapWidth = -1, bool prettyJson = false}) {
    if (_doPrint(_LOG_LEVEL_DEBUG)) {
      if (msg is String) {
        tag ??= 'DEBUG';
        if (wrapWidth > 0 && (msg).length > wrapWidth) {
          msg = (msg).substring(0, wrapWidth);
        }
        dog.d(msg, tag: tag);
      } else {
        tag ??= "DEBUG";
        dog.d(msg, tag: tag);
      }
    }
  }

  /// 日志级别error,带堆栈输出的彩色日志
  static dogE(dynamic exception, {String? tag, int wrapWidth = -1}) {
    dog.e(exception, tag: tag);
  }
}