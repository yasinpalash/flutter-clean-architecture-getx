import 'package:get/get.dart';
import 'package:project_structure_temp/Features/Authentication/controllers/login_controller.dart';
import 'package:project_structure_temp/Features/Authentication/domain/repositories/login_repository.dart';
import 'package:project_structure_temp/Features/Courses/controllers/course_list_controller.dart';
import 'package:project_structure_temp/Features/Courses/domain/repositories/course_repository.dart';

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
