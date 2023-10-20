import 'package:common/utils/log_utils.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';

class LandingPageController extends GetxController {
  static const String _tag = "LandingPageController";

  @override
  void onInit() {
    super.onInit();
    LogUtils.d(_tag, "onInit");
  }

  @override
  void onReady() {
    LogUtils.d(_tag, "onReady");
  }

  @override
  void dispose() {
    super.dispose();
    LogUtils.d(_tag, "dispose");
  }

  @override
  void onClose() {
    LogUtils.d(_tag, "onClose");
  }
}
