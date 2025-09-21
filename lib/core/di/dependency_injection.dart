import 'package:get/get.dart';
import 'package:project_structure_temp/Features/Authentication/data/data_sources/login_remote_data_sources.dart';
import 'package:project_structure_temp/Features/Authentication/data/repositories/login_repository_impl.dart';
import 'package:project_structure_temp/Features/Authentication/domain/repositories/login_repository.dart';
import 'package:project_structure_temp/Features/Courses/data/data_sources/course_remote_data_source.dart';
import 'package:project_structure_temp/Features/Courses/data/repositories/course_repository_impl.dart';
import 'package:project_structure_temp/Features/Courses/domain/repositories/course_repository.dart';
import 'package:project_structure_temp/core/services/Auth_service.dart';
import 'package:project_structure_temp/core/services/network_checker.dart';

Future<void> initDependencies() async {
  Get.lazyPut<LoginRepository>(
    () => LoginRepositoryImpl(LoginRemoteDataSource()),
    fenix: true,
  );
  Get.lazyPut<CourseRepository>(
    () => CourseRepositoryImpl(CourseRemoteDataSource()),
    fenix: true,
  );
  await NetworkChecker.init();
  await AuthService.init();
}
