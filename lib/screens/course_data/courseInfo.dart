class CourseInfo{
// <<<<<<< HEAD
//   final String course_name;
//   final String area_gu;
//   final String distance;
//   final String lead_time;
//   final String course_level;
//   final String detail_course;
//
//   CourseInfo({
//     required this.course_name,
//     required this.area_gu,
//     required this.distance,
//     required this.lead_time,
//     required this.course_level,
//     required this.detail_course,
// =======
  final cpi_idx;
  final cpi_name;
  final x;
  final y;

  CourseInfo({
    required this.cpi_idx,
    required this.cpi_name,
    required this.x,
    required this.y,
// >>>>>>> 8d7508d47e012dfb24d939465f54721d5f5e233a
  });

  factory CourseInfo.fromJson(Map<dynamic, dynamic> json){
    return CourseInfo(
// <<<<<<< HEAD
//         course_name: json["course_name"],
//         area_gu: json["area_gu"],
//         distance: json["distance"],
//         lead_time: json["lead_time"],
//         course_level: json["course_level"],
//         detail_course: json["detail_course"],
// =======
      cpi_idx: json["cpi_idx"],
      cpi_name: json["cpi_name"],
      x: json["x"],
      y: json["y"],
// >>>>>>> 8d7508d47e012dfb24d939465f54721d5f5e233a
    );
  }

  Map<dynamic, dynamic> toJson(){
    return{
// <<<<<<< HEAD
//       "course_name": course_name,
//       "area_gu": area_gu,
//       "distance": distance,
//       "lead_time": lead_time,
//       "course_level": course_level,
//       "detail_course": detail_course,
// =======
      "cpi_idx": cpi_idx,
      "cpi_name": cpi_name,
      "x": x,
      "y": y,
// >>>>>>> 8d7508d47e012dfb24d939465f54721d5f5e233a
    };
  }
// final String area_gu;
// final String distance;
// final String lead_time;
// final String course_level;
// final String detail_course;
//
// CourseInfo({
//   required this.area_gu,
//   required this.distance,
//   required this.lead_time,
//   required this.course_level,
//   required this.detail_course,
// });
//
// factory CourseInfo.fromJson(Map<dynamic, dynamic> json){
//   return CourseInfo(
//       area_gu: json["area_gu"],
//       distance: json["distance"],
//       lead_time: json["lead_time"],
//       course_level: json["course_level"],
//       detail_course: json["detail_course"],
//   );
// }
//
// Map<String, dynamic> toJson(){
//   return{
//     "area_gu": area_gu,
//     "distance": distance,
//     "lead_time": lead_time,
//     "course_level": course_level,
//     "detail_course": detail_course,
//   };
// }
}