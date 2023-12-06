// 산책코스 세부 정보 데이터 골격. 필요한 데이터만 가져옴
class CourseData{
  final cpi_idx;
  final cpi_name;
  final x;
  final y;

  CourseData({
    required this.cpi_idx,
    required this.cpi_name,
    required this.x,
    required this.y,
  });

  factory CourseData.fromJson(Map<dynamic, dynamic> json){
    return CourseData(
      cpi_idx: json["cpi_idx"],
      cpi_name: json["cpi_name"],
      x: json["x"],
      y: json["y"],
    );
  }
}