// @dart=2.12

import 'package:flutter/material.dart';

class ExtendedTabController extends TabController {
  ExtendedTabController({
    int initialIndex = 0,
    required int length,
    required TickerProvider vsync,
  }) : super(initialIndex: initialIndex, length: length, vsync: vsync);

  final List<ValueChanged<double>> _scrollListeners = [];

  double _scrollPosition = 0;

  set scrollPosition(double position) {
    _scrollPosition = position;
    _notifyScrollListeners();
  }

  double get scrollPosition {
    return _scrollPosition;
  }

  void addScrollListener(ValueChanged<double> onScroll) {
    if (!_scrollListeners.contains(onScroll)) {
      _scrollListeners.add(onScroll);
    }
  }

  void removeScrollListener(ValueChanged<double> onScroll) {
    if (_scrollListeners.contains(onScroll)) {
      _scrollListeners.remove(onScroll);
    }
  }

  void _notifyScrollListeners() {
    for (var onScroll in _scrollListeners) {
      onScroll(_scrollPosition);
    }
  }

  @override
  void dispose() {
    super.dispose();
    _scrollListeners.clear();
  }
}
