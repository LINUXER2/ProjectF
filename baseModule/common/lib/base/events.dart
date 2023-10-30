import 'package:common/export.dart';
import 'package:flutter/foundation.dart';

typedef Listener = Function(String type, Object? data);

class Events {
  Events() {
    _init();
  }

  Map<String, ObserverList<Listener>>? _events;

  void addListener(String type, Listener listener) {
    if (_events == null) {
      LogUtils.e("", "add listener error,$type");
      return;
    }
    if (_events!.containsKey(type) == false) {
      _events![type] = ObserverList<Listener>();
    }
    _events![type]!.add(listener);
  }

  void addListeners(List<String> types, Listener listener) {
    types.forEach((type) {
      addListener(type, listener);
    });
  }

  void removeListener(String type, Listener listener) {
    if (_events == null) {
      LogUtils.e("", "remove listener error,$type");
      return;
    }

    if (_events!.containsKey(type) == true) {
      _events![type]!.remove(listener);
    }
    if (_events![type] != null && _events![type]!.isEmpty) {
      _events!.remove(type);
    }
  }

  void removeListeners(List<String> types, Listener listener) {
    types.forEach((type) {
      removeListener(type, listener);
    });
  }

  void emit(String type, [Object? data]) {
    if (_events == null) {
      LogUtils.e("", "emit failed,$type");
      return;
    }
    if (_events!.containsKey(type) == true) {
      ObserverList<Listener> _listeners = _events![type]!;
      for (Listener listener in List<Listener>.from(_listeners)) {
        if (_listeners.contains(listener)) {
          listener(type, data);
        }
      }
    }
  }

  void _init() {
    _events?.clear();
    _events = {};
  }

  @mustCallSuper
  void dispose() {
    _events = null;
  }
}

Events eventCenter = Events();
