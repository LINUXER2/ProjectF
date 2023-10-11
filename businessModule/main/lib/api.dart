import 'package:common/export.dart';
import 'package:common/network/http_utils.dart';

class Api {
  static Future<Response> getMainData() async {
    return HttpUtils.post("/api/v2/feed");
  }
}
