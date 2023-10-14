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

  Map<dynamic, dynamic> toJson(){
    return{
      "cpi_idx": cpi_idx,
      "cpi_name": cpi_name,
      "x": x,
      "y": y,
    };
  }
}