import 'package:project_structure_temp/Features/Courses/data/models/course_sessions_model.dart';
import 'package:project_structure_temp/core/network/result.dart';

abstract class CourseRepository {
  Future<Result<CoursesSessionModel>> getCourses();
}
