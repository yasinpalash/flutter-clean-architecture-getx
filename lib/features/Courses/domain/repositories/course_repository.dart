import '../../../../Core/network/result.dart';
import '../../data/models/course_sessions_model.dart';

abstract class CourseRepository {
  Future<Result<CoursesSessionModel>> getCourses();
}
