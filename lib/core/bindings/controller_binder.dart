import 'package:get/get.dart';
import '../../features/Authentication/controllers/login_controller.dart';
import '../../features/Authentication/domain/repositories/login_repository.dart';
import '../../features/Courses/controllers/course_list_controller.dart';
import '../../features/Courses/domain/repositories/course_repository.dart';

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
