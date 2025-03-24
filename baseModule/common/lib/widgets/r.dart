import 'package:cached_network_image/cached_network_image.dart';
import 'package:common/export.dart';
import 'dart:io';

import 'package:flutter/material.dart';

class R {
  static Widget img(
    String? path, {
    double? width,
    double? height,
    int? cachedWidth,
    int? cachedHeight,
    Color? color,
    BlendMode? colorBlendMode,
    bool matchTextDirection = false,
    BoxFit? fit,
    Key? key,
    Alignment alignment = Alignment.center,
  }) {
    if (path == null || path.isEmpty) {
      return const SizedBox.shrink();
    }
    if (path.startsWith('http')) {
      return CachedNetworkImage(
        imageUrl: path,
        key: key,
        fit: fit,
        width: width,
        height: height,
        alignment: alignment,
        color: color,
        matchTextDirection: matchTextDirection,
        colorBlendMode: colorBlendMode,
        //placeholder: (context, url) => const CircularProgressIndicator(),
        errorWidget: (context, url, error) => const Icon(Icons.error),
        errorListener: (e) {
          LogUtils.e("img", "img error:$e");
        },
      );
    } else if (path.startsWith(Platform.pathSeparator)) {
      return Image.file(
        File(path),
        key: key,
        width: width,
        height: height,
        color: color,
        colorBlendMode: colorBlendMode,
        cacheWidth: cachedWidth,
        cacheHeight: cachedHeight,
        matchTextDirection: matchTextDirection,
        fit: fit,
        alignment: alignment,
      );
    } else {
      return Image.asset(
        path,
        width: width,
        height: height,
        fit: fit,
        key: key,
        color: color,
        colorBlendMode: colorBlendMode,
        cacheWidth: cachedWidth,
        cacheHeight: cachedHeight,
        matchTextDirection: matchTextDirection,
        alignment: alignment,
      );
    }
  }

}
