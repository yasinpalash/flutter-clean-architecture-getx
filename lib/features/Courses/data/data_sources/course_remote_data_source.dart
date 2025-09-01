import 'package:dio/dio.dart';
import 'package:project_structure_temp/core/network/network_caller.dart';

import '../../../../Core/network/result.dart';
import '../../../../core/constants/app_urls.dart';
import '../../../../core/network/api_client.dart';
import '../models/course_sessions_model.dart';


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
