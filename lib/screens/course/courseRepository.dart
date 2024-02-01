import 'dart:convert' as convert;
import 'package:http/http.dart' as http;

import 'package:sangoproject/screens/course/courseData.dart';

class CourseRepository {
  var apiKey = "65474d596b626c7536364f6d436671";

  Future<List<CourseData>?> loadCourse(String courseName) async {
    String baseUrl = "http://openAPI.seoul.go.kr:8088/$apiKey/json/SeoulGilWalkCourse/1/30/$courseName/";
    final response = await http.get(Uri.parse(baseUrl));

    if (response.statusCode == 200) {
      final json = convert.utf8.decode(response.bodyBytes);

      Map<String, dynamic> jsonResult = convert.json.decode(json);
      final jsonCourse = jsonResult['SeoulGilWalkCourse'];

      if (jsonCourse['row'] != null) {
        List<dynamic> list = jsonCourse['row'];

        return list.map<CourseData>((item) => CourseData.fromJson(item)).toList();
      }
    }
  }
}