import 'package:get/get.dart';
import '../../common/widgets/internet_banner_manager.dart';
import '../../services/network_checker.dart';

class ConnectionListener {
  static void init() {

    // Initial State
    if (NetworkChecker.hasInternet.value) {
      InternetBannerManager.hide();
    } else {
      InternetBannerManager.show();
    }

    // React to changes
    ever(NetworkChecker.hasInternet, (hasInternet) {
      if (hasInternet) {
        InternetBannerManager.hide();
      } else {
        InternetBannerManager.show();
      }
    });
  }
}
