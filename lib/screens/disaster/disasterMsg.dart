// 재난 정보 문자 데이터 골격. 필요한 데이터만 가져옴.
class DisasterMsg {
  String? create_date;
  String? location_name;
  String? msg;

  DisasterMsg({
    this.create_date,
    this.location_name,
    this.msg
  });

  factory DisasterMsg.fromJson(Map<String, dynamic> json) {
    return DisasterMsg(
      create_date: json["create_date"] as String,
      location_name: json["location_name"] as String,
      msg: json["msg"] as String,
    );
  }
}