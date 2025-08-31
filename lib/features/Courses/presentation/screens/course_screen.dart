import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:network_caller/Features/Courses/controllers/course_list_controller.dart';
import '../widgets/course_card.dart';
import '../widgets/session_card.dart';

class CourseScreen extends StatelessWidget {
  CourseScreen({super.key});

  final courseController = Get.find<CourseListController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[50],
      appBar: AppBar(
        title: const Text('Explore Courses & Sessions'),
        backgroundColor: Colors.blueAccent,
        foregroundColor: Colors.white,
        elevation: 0,
        centerTitle: true,
      ),
      body: Obx(() {
        if (courseController.inProgress.value) {
          return const Center(
            child: CircularProgressIndicator(color: Colors.blueAccent),
          );
        }

        if (courseController.errorMessage.value.isNotEmpty) {
          return Center(
            child: Padding(
              padding: const EdgeInsets.all(32.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.cloud_off,
                      color: Colors.blueAccent.shade200, size: 80),
                  const SizedBox(height: 24),
                  Text(
                    'Oops! Something went wrong.',
                    style: Theme.of(context)
                        .textTheme
                        .headlineSmall
                        ?.copyWith(fontWeight: FontWeight.bold),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 12),
                  Text(
                    courseController.errorMessage.value,
                    textAlign: TextAlign.center,
                    style: Theme.of(context)
                        .textTheme
                        .bodyLarge
                        ?.copyWith(color: Colors.grey[700]),
                  ),
                  const SizedBox(height: 24),
                  ElevatedButton.icon(
                    onPressed: () => courseController.fetchCourses(),
                    icon: const Icon(Icons.refresh),
                    label: const Text('Try Again'),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.blueAccent,
                      foregroundColor: Colors.white,
                      padding: const EdgeInsets.symmetric(
                          horizontal: 24, vertical: 12),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10)),
                    ),
                  ),
                ],
              ),
            ),
          );
        }
        final courses =
            courseController.courseSessionList.value.data?.courses ?? [];
        final sessions =
            courseController.courseSessionList.value.data?.sessions ?? [];

        if (courses.isEmpty && sessions.isEmpty) {
          return Center(
            child: Padding(
              padding: const EdgeInsets.all(32.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.inbox,
                      color: Colors.blueAccent.shade100, size: 80),
                  const SizedBox(height: 24),
                  Text(
                    'Nothing to show yet!',
                    style: Theme.of(context)
                        .textTheme
                        .headlineSmall
                        ?.copyWith(fontWeight: FontWeight.bold),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 12),
                  Text(
                    'It looks like there are no courses or sessions available right now. Please check back later!',
                    textAlign: TextAlign.center,
                    style: Theme.of(context)
                        .textTheme
                        .bodyLarge
                        ?.copyWith(color: Colors.grey[700]),
                  ),
                ],
              ),
            ),
          );
        }

        return ListView(
          padding: const EdgeInsets.all(16.0),
          children: [
            if (courses.isNotEmpty) ...[
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 12.0),
                child: Text(
                  'Explore Top Courses',
                  style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                        fontWeight: FontWeight.bold,
                        color: Colors.blueAccent.shade700,
                      ),
                ),
              ),
              ...courses.map((course) => CourseCard(course: course)),
              const SizedBox(height: 24),
            ],
            if (sessions.isNotEmpty) ...[
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 12.0),
                child: Text(
                  'Upcoming Live Sessions',
                  style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                        fontWeight: FontWeight.bold,
                        color: Colors.blueAccent.shade700,
                      ),
                ),
              ),
              ...sessions.map((session) => SessionCard(session: session)),
            ],
          ],
        );
      }),
    );
  }
}


