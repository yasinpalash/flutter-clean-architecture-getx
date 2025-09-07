import 'package:project_structure_temp/Features/Courses/data/data_sources/course_remote_data_source.dart';
import 'package:project_structure_temp/Features/Courses/data/models/course_sessions_model.dart';
import 'package:project_structure_temp/Features/Courses/domain/repositories/course_repository.dart';
import 'package:project_structure_temp/core/network/result.dart';

class CourseRepositoryImpl extends CourseRepository {
  final CourseRemoteDataSource _remoteDataSource;

  CourseRepositoryImpl(this._remoteDataSource);

  @override
  Future<Result<CoursesSessionModel>> getCourses() {
    return _remoteDataSource.getCourseSessions();
  }
}
