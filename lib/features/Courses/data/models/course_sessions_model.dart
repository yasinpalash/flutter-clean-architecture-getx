import 'package:network_caller/Features/Courses/data/models/sessions_model.dart';

class CoursesSessionModel {
  bool? success;
  String? message;
  CoursesSessionModelListData? data;

  CoursesSessionModel({this.success, this.message, this.data});

  CoursesSessionModel.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    message = json['message'];
    data = json['data'] != null
        ? CoursesSessionModelListData.fromJson(json['data'])
        : null;
  }
}

class CoursesSessionModelListData {
  List<Sessions>? sessions;
  List<Courses>? courses;

  CoursesSessionModelListData({this.sessions, this.courses});

  CoursesSessionModelListData.fromJson(Map<String, dynamic> json) {
    if (json['sessions'] != null) {
      sessions = <Sessions>[];
      json['sessions'].forEach((v) {
        sessions!.add(Sessions.fromJson(v));
      });
    }
    if (json['courses'] != null) {
      courses = <Courses>[];
      json['courses'].forEach((v) {
        courses!.add(Courses.fromJson(v));
      });
    }
  }
}

class Instructor {
  String? professionalRank;
  String? experience;
  int? sessionPrice;
  User? user;

  Instructor(
      {this.professionalRank, this.experience, this.sessionPrice, this.user});

  Instructor.fromJson(Map<String, dynamic> json) {
    professionalRank = json['professional_rank'];
    experience = json['experience'];
    sessionPrice = json['session_price'];
    user = json['user'] != null ? User.fromJson(json['user']) : null;
  }
}

class User {
  String? id;
  String? fullName;

  User({this.id, this.fullName});

  User.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    fullName = json['full_name'];
  }
}

class Courses {
  String? id;
  String? title;
  String? slug;
  String? language;
  String? lessonTopics;
  String? level;
  int? rating;
  Instructor? instructor;

  Courses(
      {this.id,
      this.title,
      this.slug,
      this.language,
      this.lessonTopics,
      this.level,
      this.rating,
      this.instructor});

  Courses.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    title = json['title'];
    slug = json['slug'];
    language = json['language'];
    lessonTopics = json['lesson_topics'];
    level = json['level'];
    rating = json['rating'];
    instructor = json['instructor'] != null
        ? Instructor.fromJson(json['instructor'])
        : null;
  }
}

class InstructorProfile {
  int? sessionPrice;
  User? user;

  InstructorProfile({this.sessionPrice, this.user});

  InstructorProfile.fromJson(Map<String, dynamic> json) {
    sessionPrice = json['session_price'];
    user = json['user'] != null ? User.fromJson(json['user']) : null;
  }
}

class UserProfile {
  String? fullName;
  String? email;
  String? id;

  UserProfile({this.fullName, this.email, this.id});

  UserProfile.fromJson(Map<String, dynamic> json) {
    fullName = json['full_name'];
    email = json['email'];
    id = json['id'];
  }
}
