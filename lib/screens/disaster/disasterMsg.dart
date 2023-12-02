class DisasterMsg {
  String? create_date;
  String? msg;

  DisasterMsg({
    this.create_date,
    this.msg
  });

  factory DisasterMsg.fromJson(Map<String, dynamic> json) {
    return DisasterMsg(
      create_date: json["create_date"] as String,
      msg: json["msg"] as String,
    );
  }
}