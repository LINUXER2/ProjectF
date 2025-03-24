import 'package:flutter/material.dart';
import 'dart:convert';

import '../utils/system_utils.dart';

enum ToastPosition { Top, Center, Bottom }

const DefaultDuration = Duration(milliseconds: 3500);

class FlutterToast {
  static show({String? msg, ToastPosition gravity = ToastPosition.Center, WidgetBuilder? widgetBuilder, Duration? duration}) {
    ToastPosition toastPosition = ToastPosition.Center;
    switch (gravity) {
      case ToastPosition.Top:
        toastPosition = ToastPosition.Top;
        break;

      case ToastPosition.Center:
        toastPosition = ToastPosition.Center;
        break;

      case ToastPosition.Bottom:
        toastPosition = ToastPosition.Bottom;
        break;
    }
    if (msg?.isNotEmpty == true) {
      Toast.show(System.context, msg, toastPosition, duration ?? DefaultDuration, widgetBuilder);
    }
  }
}

class Toast {
  static ToastView? _preToast;

  static show(BuildContext? context, dynamic msg,
      [ToastPosition position = ToastPosition.Center, Duration duration = DefaultDuration, WidgetBuilder? widgetBuilder]) {
    if (_preToast != null) {
      _preToast!.dismiss();
    }

    if (msg == null && widgetBuilder == null) return;

    String? message;
    if (msg is String) {
      message = msg;
    } else if (msg != null) {
      message = json.encode(msg);
    }

    var overlayState = Overlay.of(context ?? System.context);
    var controllerShowAnim = AnimationController(
      vsync: overlayState,
      duration: const Duration(milliseconds: 250),
    );
    var controllerShowOffset = AnimationController(
      vsync: overlayState,
      duration: const Duration(milliseconds: 350),
    );
    var controllerHide = AnimationController(
      vsync: overlayState,
      duration: const Duration(milliseconds: 250),
    );
    var opacityAnim1 = Tween(begin: 0.0, end: 1.0).animate(controllerShowAnim);
    var controllerCurvedShowOffset = CurvedAnimation(parent: controllerShowOffset, curve: const _BounceOutCurve._());
    var offsetAnim = Tween(begin: 30.0, end: 0.0).animate(controllerCurvedShowOffset);
    var opacityAnim2 = Tween(begin: 1.0, end: 0.0).animate(controllerHide);

    OverlayEntry overlayEntry = OverlayEntry(builder: (context) {
      return ToastWidget(
        opacityAnim1: opacityAnim1,
        opacityAnim2: opacityAnim2,
        offsetAnim: offsetAnim,
        child: buildToastLayout(msg: message, position: position, widgetBuilder: widgetBuilder),
      );
    });
    var toastView = ToastView(overlayEntry, controllerShowAnim, controllerShowOffset, controllerHide, overlayState);
    _preToast = toastView;
    toastView._show(duration);
  }

  static LayoutBuilder buildToastLayout({String? msg, ToastPosition? position, WidgetBuilder? widgetBuilder}) {
    double bottom = 0.15;
    if (position == ToastPosition.Center) {
      bottom = 0.45;
    } else if (position == ToastPosition.Top) {
      bottom = 0.8;
    }

    Widget? toastWidget;
    if (widgetBuilder != null) {
      toastWidget = widgetBuilder(System.context);
    }

    toastWidget ??= Container(
      child: Text(
        msg ?? '',
        style: const TextStyle(color: Colors.white),
      ),
      decoration: BoxDecoration(
        color: Colors.black.withOpacity(0.6),
        borderRadius: const BorderRadius.all(
          Radius.circular(5),
        ),
      ),
      padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
    );

    return LayoutBuilder(builder: (BuildContext context, BoxConstraints constraints) {
      return IgnorePointer(
        ignoring: true,
        child: Container(
          child: Material(
            color: Colors.white.withOpacity(0),
            child: Container(
              child: toastWidget,
              margin: EdgeInsets.only(
                bottom: constraints.biggest.height * bottom,
                left: constraints.biggest.width * 0.2,
                right: constraints.biggest.width * 0.2,
              ),
            ),
          ),
          alignment: Alignment.bottomCenter,
        ),
      );
    });
  }
}

class ToastView {
  final OverlayEntry overlayEntry;
  final AnimationController controllerShowAnim;
  final AnimationController controllerShowOffset;
  final AnimationController controllerHide;
  final OverlayState overlayState;
  bool dismissed = false;

  ToastView(this.overlayEntry, this.controllerShowAnim, this.controllerShowOffset, this.controllerHide, this.overlayState);

  _show(Duration duration) async {
    overlayState.insert(overlayEntry);
    controllerShowAnim.forward();
    controllerShowOffset.forward();
    await Future.delayed(duration);
    dismiss();
  }

  dismiss() async {
    if (dismissed) {
      return;
    }
    dismissed = true;
    controllerHide.forward();
    await Future.delayed(const Duration(milliseconds: 250));
    overlayEntry.remove();
  }
}

class ToastWidget extends StatelessWidget {
  final Widget? child;
  final Animation<double> opacityAnim1;
  final Animation<double> opacityAnim2;
  final Animation<double> offsetAnim;

  const ToastWidget({Key? key, this.child, required this.offsetAnim, required this.opacityAnim1, required this.opacityAnim2}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: opacityAnim1,
      child: child,
      builder: (BuildContext context, Widget? child) {
        return FadeTransition(
          opacity: opacityAnim1,
          child: AnimatedBuilder(
            animation: offsetAnim,
            builder: (BuildContext context, _) {
              return Transform.translate(
                offset: Offset(0, offsetAnim.value),
                child: AnimatedBuilder(
                  animation: opacityAnim2,
                  builder: (BuildContext context, _) {
                    return FadeTransition(
                      opacity: opacityAnim2,
                      child: child,
                    );
                  },
                ),
              );
            },
          ),
        );
      },
    );
  }
}

class _BounceOutCurve extends Curve {
  const _BounceOutCurve._();

  @override
  double transform(double t) {
    t -= 1.0;
    return t * t * ((2 + 1) * t + 2) + 1.0;
  }
}
