import 'package:dio/dio.dart';
import 'package:project_structure_temp/Features/Courses/data/models/course_sessions_model.dart';
import 'package:project_structure_temp/core/constants/app_urls.dart';
import 'package:project_structure_temp/core/network/api_client.dart';
import 'package:project_structure_temp/core/network/network_caller.dart';
import 'package:project_structure_temp/core/network/result.dart';

class CourseRemoteDataSource {
  final Dio _dio = ApiClient.createDio();

  Future<Result<CoursesSessionModel>> getCourseSessions() {
    return _dio.getRequest<CoursesSessionModel>(
      AppUrls.course,
      fromJson: (json) =>
          CoursesSessionModel.fromJson(json as Map<String, dynamic>),
    );
  }
}
