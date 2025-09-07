import 'package:get/get.dart';
import '../../features/Authentication/data/data_sources/login_remote_data_sources.dart';
import '../../features/Authentication/data/repositories/login_repository_impl.dart';
import '../../features/Authentication/domain/repositories/login_repository.dart';
import '../../features/Courses/data/data_sources/course_remote_data_source.dart';
import '../../features/Courses/data/repositories/course_repository_impl.dart';
import '../../features/Courses/domain/repositories/course_repository.dart';
import '../services/network_checker.dart';

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
}

