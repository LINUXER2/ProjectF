import 'package:flutter/cupertino.dart';
import 'package:flutter/scheduler.dart';
import 'package:intl/intl.dart';

extension DateTimeExt on DateTime {
  /// 2023-10-01
  String toyyyyMMdd() {
    return DateFormat('yyyy-MM-dd').format(this);
  }

  /// 19:30:00
  String toHHmmss() {
    return DateFormat('HH:mm:ss').format(this);
  }

  /// 10-01 19:30
  String toMMddHHmm() {
    return DateFormat('MM-dd HH:mm').format(this);
  }
}

extension StateExt on State{
  safeRun(VoidCallback callback){
    if(mounted){
      callback.call();
    }
  }

  refresh([VoidCallback? fn]){
    fn ??= ((){});
    final schedulerPhase = SchedulerBinding.instance.schedulerPhase;
    if (schedulerPhase == SchedulerPhase.persistentCallbacks) {
      SchedulerBinding.instance.addPostFrameCallback((_) {
        if (mounted) setState(fn!);
      });
    } else {
      if (mounted) setState(fn);
    }

  }
}


extension StringExt on String{


}
