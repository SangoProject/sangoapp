class PieData {
  int id = 0;
  double goal = 1.0;

  PieData(this.id, this.goal);

  PieData.fromJson(Map<String, dynamic> pieDataMap) {
    id = pieDataMap['id'] ?? 0;
    goal = pieDataMap['goal'] ?? 0;
  }

  Map<String, dynamic> toJson() {
    return {
      'id' : id,
      'goal' : goal,
    };
  }
}