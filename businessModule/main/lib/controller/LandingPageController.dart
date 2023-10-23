import 'package:common/utils/log_utils.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';

class LandingPageController extends GetxController {
  static const String _tag = "LandingPageController";
  static const String ID_ALL= "all";
  static const String ID_TOP= "top";
  static const String ID_BOTTOM= "bottom";

  static int num = 0;

  @override
  void onInit() {
    super.onInit();
    LogUtils.d(_tag, "onInit");
  }

  @override
  void onReady() {
    LogUtils.d(_tag, "onReady");
  }

  void updateTop(){
    update([ID_TOP]);
  }

  void updateBottom(){
    update([ID_BOTTOM]);
  }

  void updateAll() {
    update();
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
