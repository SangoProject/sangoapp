// 산책코스 세부 정보 데이터 골격. 필요한 데이터만 가져옴
class CourseData{
  final cpi_idx;
  final cpi_name;
  final x;
  final y;

  CourseData({
    this.cpi_idx,
    this.cpi_name,
    this.x,
    this.y,
  });

  factory CourseData.fromJson(Map<dynamic, dynamic> json){
    return CourseData(
      cpi_idx: json["CPI_IDX"],
      cpi_name: json["CPI_NAME"],
      x: json["X"],
      y: json["Y"],
    );
  }
}