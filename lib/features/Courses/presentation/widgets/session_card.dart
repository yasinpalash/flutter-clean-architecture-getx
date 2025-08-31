import 'package:flutter/material.dart';
import '../../data/models/sessions_model.dart';

class SessionCard extends StatelessWidget {
  final Sessions session;
  const SessionCard({super.key, required this.session});

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
              session.title ?? 'Untitled Session',
              style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                    fontWeight: FontWeight.w700,
                    color: Colors.blueAccent.shade700,
                  ),
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
            ),
            const SizedBox(height: 8),
            Row(
              children: [
                Icon(Icons.people_outline, size: 18, color: Colors.grey[600]),
                const SizedBox(width: 8),
                Text(
                  'With ${session.instructor?.user?.fullName ?? 'N/A'}',
                  style: Theme.of(context)
                      .textTheme
                      .bodyLarge
                      ?.copyWith(color: Colors.grey[700]),
                ),
              ],
            ),
            const Divider(height: 30, thickness: 0.8, color: Colors.grey),
            if (session.level != null)
              Align(
                alignment: Alignment.centerLeft,
                child: _buildStyledChip(context, session.level!,
                    Icons.bar_chart, Colors.blueAccent),
              ),
            if (session.sessionTopics != null &&
                session.sessionTopics!.isNotEmpty) ...[
              const SizedBox(height: 16),
              Text(
                'Session Focus:',
                style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                      fontWeight: FontWeight.w600,
                      color: Colors.blueAccent.shade700,
                    ),
              ),
              const SizedBox(height: 4),
              Text(
                session.sessionTopics!,
                style: Theme.of(context)
                    .textTheme
                    .bodyMedium
                    ?.copyWith(color: Colors.grey[700]),
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              ),
            ],
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
