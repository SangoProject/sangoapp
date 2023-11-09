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