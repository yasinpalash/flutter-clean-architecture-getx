import 'course_sessions_model.dart';

class Sessions {
  String? id;
  String? title;
  String? level;
  String? bookingStartFrom;
  String? sessionTopics;
  String? slug;
  String? startAt;
  String? sessionDate;
  Instructor? instructor;

  Sessions(
      {this.id,
        this.title,
        this.level,
        this.bookingStartFrom,
        this.sessionTopics,
        this.slug,
        this.startAt,
        this.sessionDate,
        this.instructor});

  Sessions.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    title = json['title'];
    level = json['level'];
    bookingStartFrom = json['booking_start_from'];
    sessionTopics = json['session_topics'];
    slug = json['slug'];
    startAt = json['start_at'];
    sessionDate = json['session_date'];
    instructor = json['instructor'] != null
        ? Instructor.fromJson(json['instructor'])
        : null;
  }
}