import 'package:common/network/base_response.dart';
import 'package:common/network/http_utils.dart';

class Api {
  static Future<BaseResponse> getMainData() async {
    return HttpUtils.post("/api/v2/feed");
  }
}
