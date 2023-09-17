class CourseInfo{
  final String course_name;
  final String area_gu;
  final String distance;
  final String lead_time;
  final String course_level;
  final String detail_course;

  CourseInfo({
    required this.course_name,
    required this.area_gu,
    required this.distance,
    required this.lead_time,
    required this.course_level,
    required this.detail_course,
  });

  factory CourseInfo.fromJson(Map<dynamic, dynamic> json){
    return CourseInfo(
        course_name: json["course_name"],
        area_gu: json["area_gu"],
        distance: json["distance"],
        lead_time: json["lead_time"],
        course_level: json["course_level"],
        detail_course: json["detail_course"],
    );
  }

  Map<String, dynamic> toJson(){
    return{
      "course_name": course_name,
      "area_gu": area_gu,
      "distance": distance,
      "lead_time": lead_time,
      "course_level": course_level,
      "detail_course": detail_course,
    };
  }
}