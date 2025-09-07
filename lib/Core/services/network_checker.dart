import 'dart:io';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:get/get.dart';
import 'package:project_structure_temp/core/constants/app_urls.dart';

class NetworkChecker extends GetxService {
  static final Connectivity _connectivity = Connectivity();
  static final RxBool hasInternet = false.obs;

  static NetworkChecker get to => Get.find<NetworkChecker>();

  @override
  void onInit() {
    super.onInit();
    _startMonitoring();
  }

  static Future<void> init() async {
    await Get.putAsync<NetworkChecker>(() async {
      final service = NetworkChecker();
      await service._initialCheck();
      return service;
    });
  }

  Future<void> _initialCheck() async {
    await _checkInternet();
  }

  void _startMonitoring() {
    _connectivity.onConnectivityChanged.listen((_) async {
      await _checkInternet();
    });
  }

  static Future<bool> isConnected() async {
    return await to._checkInternet();
  }

  Future<bool> _checkInternet() async {
    try {
      final connectivityResult = await _connectivity.checkConnectivity();
      if (connectivityResult.contains(ConnectivityResult.none)) {
        hasInternet.value = false;
        return false;
      }

      final result = await InternetAddress.lookup(
        AppUrls.lookupAddress,
      ).timeout(const Duration(seconds: 3), onTimeout: () => []);

      hasInternet.value =
          result.isNotEmpty && result.first.rawAddress.isNotEmpty;
      return hasInternet.value;
    } catch (e) {
      hasInternet.value = false;
      return false;
    }
  }
}

// bool connected = await NetworkChecker.isConnected();
// Obx(() => Text(NetworkChecker.hasInternet.value ? 'Online' : 'Offline'));
