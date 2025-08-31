import 'package:dio/dio.dart';
import 'package:network_caller/Core/network/api_client.dart';
import 'package:network_caller/Core/network/network_caller.dart';
import 'package:network_caller/Core/network/result.dart';
import 'package:network_caller/Features/Courses/data/models/course_sessions_model.dart';
import '../../../../Core/utils/constants/app_urls.dart';

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
