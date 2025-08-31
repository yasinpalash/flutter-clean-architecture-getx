import 'package:network_caller/Core/network/result.dart';
import 'package:network_caller/Features/Courses/data/models/course_sessions_model.dart';

abstract class CourseRepository {
  Future<Result<CoursesSessionModel>> getCourses();
}
