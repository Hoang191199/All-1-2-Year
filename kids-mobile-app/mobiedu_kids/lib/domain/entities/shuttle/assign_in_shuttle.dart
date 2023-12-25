import 'package:mobiedu_kids/domain/entities/shuttle/day_in_assign_shuttle.dart';

class AssignInShuttle {
  AssignInShuttle({
    this.next_week,
    this.this_week
  });
  DayInAssignShuttle? next_week;
  DayInAssignShuttle? this_week;

  factory AssignInShuttle.fromJson(Map<String, dynamic>? json) {
    return AssignInShuttle(
      next_week:json?['next_week'] == null ? null : DayInAssignShuttle.fromJson(json?['next_week']),
      this_week:json?['this_week'] == null ? null : DayInAssignShuttle.fromJson(json?['this_week'])
    );
  }

  Map<String, dynamic> toJson() => {
    'next_week': next_week,
    'this_week': this_week,
  };
}