import 'package:network_caller/Features/Courses/domain/repositories/course_repository.dart';
import '../../../../Core/network/result.dart';
import '../data_sources/course_remote_data_source.dart';
import '../models/course_sessions_model.dart';

class CourseRepositoryImpl extends CourseRepository {
  final CourseRemoteDataSource _remoteDataSource;

  CourseRepositoryImpl(this._remoteDataSource);

  @override
  Future<Result<CoursesSessionModel>> getCourses() {
    return _remoteDataSource.getCourseSessions();
  }
}
