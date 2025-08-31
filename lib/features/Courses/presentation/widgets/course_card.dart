import 'package:flutter/material.dart';
import '../../data/models/course_sessions_model.dart';

class CourseCard extends StatelessWidget {
  final Courses course;
  const CourseCard({super.key, required this.course});

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 2,
      margin: const EdgeInsets.only(bottom: 16),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              course.title ?? 'Untitled Course',
              style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                    fontWeight: FontWeight.w700,
                    color: Colors.blueAccent,
                  ),
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
            ),
            const SizedBox(height: 8),
            Row(
              children: [
                Icon(Icons.person_outline, size: 18, color: Colors.grey[600]),
                const SizedBox(width: 8),
                Text(
                  'Instructor: ${course.instructor?.user?.fullName ?? 'N/A'}',
                  style: Theme.of(context)
                      .textTheme
                      .bodyLarge
                      ?.copyWith(color: Colors.grey[700]),
                ),
              ],
            ),
            const SizedBox(height: 12),
            Wrap(
              spacing: 8.0,
              runSpacing: 4.0,
              children: [
                if (course.level != null)
                  _buildStyledChip(
                      context, course.level!, Icons.bar_chart, Colors.teal),
                if (course.language != null)
                  _buildStyledChip(
                      context, course.language!, Icons.language, Colors.orange),
              ],
            ),
            const SizedBox(height: 12),
            if (course.rating != null)
              Row(
                children: [
                  ...List.generate(5, (index) {
                    return Icon(
                      index < (course.rating ?? 0)
                          ? Icons.star
                          : Icons.star_border,
                      color: Colors.amber,
                      size: 20,
                    );
                  }),
                  const SizedBox(width: 8),
                  Text(
                    '${course.rating}/5 Rating',
                    style: Theme.of(context)
                        .textTheme
                        .bodyMedium
                        ?.copyWith(color: Colors.grey[600]),
                  ),
                ],
              ),
            const SizedBox(height: 12),
            if (course.lessonTopics != null && course.lessonTopics!.isNotEmpty)
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Topics Covered:',
                    style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                          fontWeight: FontWeight.w600,
                          color: Colors.blueAccent.shade700,
                        ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    course.lessonTopics!,
                    style: Theme.of(context)
                        .textTheme
                        .bodyMedium
                        ?.copyWith(color: Colors.grey[700]),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                ],
              ),
          ],
        ),
      ),
    );
  }

  Widget _buildStyledChip(
      BuildContext context, String label, IconData icon, Color color) {
    return Chip(
      avatar: Icon(icon, size: 18, color: color),
      label: Text(
        label,
        style: TextStyle(color: color, fontWeight: FontWeight.w600),
      ),
      backgroundColor: color.withValues(alpha: 0.1),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 6),
    );
  }
}
