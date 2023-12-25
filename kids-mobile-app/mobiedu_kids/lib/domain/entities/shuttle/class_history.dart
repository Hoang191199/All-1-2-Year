class ClassHistory{
  ClassHistory({
    this.assign_time,
    this.pickup_time,
    this.action
  });

  String? assign_time;
  String? pickup_time;
  int? action;

  factory ClassHistory.fromJson(Map<String, dynamic>? json) {
    return ClassHistory(
      assign_time: json?["assign_time"] == null ? null : json?['assign_time'] as String,
      pickup_time: json?["pickup_time"] == null ? null : json?['pickup_time'] as String,
      action: json?["action"] == null ? null : json?['action'] as int,
    );
  }

  Map<String, dynamic> toJson() => {
    'assign_time': assign_time,
    'pickup_time': pickup_time,
    'action': action,
  };
}