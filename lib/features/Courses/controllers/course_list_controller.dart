import 'package:get/get.dart';
import 'package:network_caller/Core/utils/logging/logger.dart';
import 'package:network_caller/Features/Courses/data/models/course_sessions_model.dart';
import 'package:network_caller/Features/Courses/domain/repositories/course_repository.dart';
import '../../../Core/network/result.dart';
import '../../../Core/network/server_exception.dart';

class CourseListController extends GetxController {
  final CourseRepository _courseRepository;
  CourseListController(this._courseRepository);

  final RxBool _inProgress = true.obs;
  final RxString _errorMessage = ''.obs;
  final Rx<CoursesSessionModel> _coursesSessionList = CoursesSessionModel().obs;

  RxBool get inProgress => _inProgress;
  RxString get errorMessage => _errorMessage;
  Rx<CoursesSessionModel> get courseSessionList => _coursesSessionList;

  @override
  void onInit() {
    fetchCourses();
    super.onInit();
  }

  Future<void> fetchCourses() async {
    try {
      _inProgress(true);
      _errorMessage.value = '';
      final result = await _courseRepository.getCourses();
      switch (result) {
        case Ok<CoursesSessionModel>():
          final response = result.value;
          _coursesSessionList.value = response;
          break;

        case Error<CoursesSessionModel>():
          final error = result.error;
          if (error is ServerException) {
            _errorMessage.value =
                error.data?['message'] ?? 'An unknown server error occurred.';
          } else {
            _errorMessage.value = 'An unexpected error occurred.';
          }
      }
    } catch (e) {
      _errorMessage.value = 'Failed to connect to the server.';
      AppLoggerHelper.error('Error fetching courses: $e');
    } finally {
      _inProgress(false);
    }
  }
}
