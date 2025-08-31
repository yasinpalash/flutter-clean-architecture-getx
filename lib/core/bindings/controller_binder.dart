

import 'package:get/get.dart';

class ControllerBinder extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<LoginController>(
          () => LoginController(
        Get.find<LoginRepository>(),
      ),
      fenix: true,
    );

    Get.lazyPut<CourseListController>(
          () => CourseListController(
        Get.find<CourseRepository>(),
      ),
      fenix: true,
    );
  }
}
